import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '../../../../../common/assert';
import { CharacterSheetInput, CharacterSheetContext } from '../../character-sheet.types';
import {
  classWeaponMasterySlotsAtLevel,
  isClassWeaponMasteryOptionKey,
  parseWeaponMasteryEligibility,
  type ClassProgressionMasteryRow,
} from './class-weapon-mastery-slots';
import { isProficient, type EquippedWeaponPiece } from '../../../../combat/domain/weapon-attack';

@Injectable()
export class CharacterWeaponMasteryValidator {
  constructor(private readonly dataSource: DataSource) {}

  async validateClassWeaponMasteryOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
  ): Promise<void> {
    const masteryOptions = options.filter((option) =>
      isClassWeaponMasteryOptionKey(option.optionKey),
    );
    const unlocked = classWeaponMasterySlotsAtLevel(
      await this.loadWeaponMasteryProgression(ctx.classSlug),
      ctx.level,
    );
    const unlockedKeys = new Set(unlocked.map((slot) => slot.optionKey));

    assertUnique(
      options.map((option) => option.optionKey),
      'Duplicate class option keys are not allowed',
    );

    if (unlocked.length === 0) {
      if (masteryOptions.length > 0) {
        throw new BadRequestException(
          `Class '${ctx.classSlug}' has no weapon mastery options at level ${ctx.level}`,
        );
      }
      return;
    }

    for (const option of masteryOptions) {
      if (!unlockedKeys.has(option.optionKey)) {
        throw new BadRequestException(
          `Class option '${option.optionKey}' is not unlocked for '${ctx.classSlug}' at level ${ctx.level}`,
        );
      }
    }

    const eligibility = parseWeaponMasteryEligibility(
      await this.loadWeaponMasteryEligibility(ctx.classSlug),
    );
    const weaponProficiencySlugs = await this.loadClassWeaponProficiencySlugs(ctx.classSlug);
    const chosen = masteryOptions.map((option) => option.valueId);
    assertUnique(chosen, 'Weapon mastery choices must be distinct');

    for (const option of masteryOptions) {
      await this.assertMasteryWeaponChoice(ctx.classSlug, option.valueId, eligibility, weaponProficiencySlugs);
    }
  }

  async loadWeaponMasteryProgression(
    classSlug: string,
  ): Promise<ClassProgressionMasteryRow[]> {
    return this.dataSource.query<ClassProgressionMasteryRow[]>(
      `SELECT cp.level, cp.weapon_mastery AS "weaponMastery"
       FROM rpg.phb_class_progression cp
       JOIN rpg.phb_class c ON c.id = cp.class_id
       WHERE c.slug = $1
       ORDER BY cp.level`,
      [classSlug],
    );
  }

  private async assertMasteryWeaponChoice(
    classSlug: string,
    weaponSlug: string,
    eligibility: ReturnType<typeof parseWeaponMasteryEligibility>,
    weaponProficiencySlugs: string[],
  ): Promise<void> {
    const rows = await this.dataSource.query<
      {
        slug: string;
        name: string;
        category: string;
        damage: string | null;
        damage_type: string | null;
        properties: Record<string, unknown> | null;
        mastery_slug: string | null;
      }[]
    >(
      `SELECT i.slug, i.name, w.category, w.damage, w.damage_type,
              i.properties, m.slug AS mastery_slug
       FROM rpg.phb_weapon w
       JOIN rpg.phb_item i ON i.id = w.item_id
       LEFT JOIN rpg.phb_weapon_mastery m ON m.id = w.mastery_id
       WHERE i.slug = $1
       LIMIT 1`,
      [weaponSlug],
    );
    const row = rows[0];
    if (!row) {
      throw new BadRequestException(
        `Weapon mastery choice '${weaponSlug}' is not a valid weapon`,
      );
    }
    if (!row.mastery_slug) {
      throw new BadRequestException(`Weapon '${weaponSlug}' has no mastery property`);
    }

    const props = (row.properties ?? {}) as {
      propertyIds?: string[];
      versatileDamage?: string;
    };
    const propertySlugs = props.propertyIds ?? [];
    if (
      eligibility === 'melee' &&
      propertySlugs.includes('ammunition') &&
      !propertySlugs.includes('thrown')
    ) {
      throw new BadRequestException(
        `Weapon mastery for '${classSlug}' requires a melee weapon; '${weaponSlug}' is ranged-only`,
      );
    }
    if (eligibility === 'ranged' && !propertySlugs.includes('ammunition')) {
      throw new BadRequestException(
        `Weapon mastery for '${classSlug}' requires a ranged weapon; '${weaponSlug}' is melee-only`,
      );
    }

    const piece: EquippedWeaponPiece = {
      itemSlug: row.slug,
      itemName: row.name,
      category: row.category,
      damage: row.damage,
      damageType: row.damage_type,
      versatileDamage: props.versatileDamage ?? null,
      propertySlugs,
      equipmentSlot: 'main_hand',
    };
    if (
      !isProficient(piece, {
        proficiencyBonus: 2,
        weaponProficiencySlugs,
      })
    ) {
      throw new BadRequestException(
        `Weapon mastery choice '${weaponSlug}' requires proficiency`,
      );
    }
  }

  private async loadWeaponMasteryEligibility(classSlug: string): Promise<string | null> {
    const rows = await this.dataSource.query<{ weapon_mastery_eligibility: string | null }[]>(
      `SELECT weapon_mastery_eligibility FROM rpg.phb_class WHERE slug = $1`,
      [classSlug],
    );
    return rows[0]?.weapon_mastery_eligibility ?? null;
  }

  private async loadClassWeaponProficiencySlugs(classSlug: string): Promise<string[]> {
    const rows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT wp.slug
       FROM rpg.phb_class c
       JOIN rpg.phb_class_weapon_proficiency cwp ON cwp.class_id = c.id
       JOIN rpg.phb_weapon_proficiency wp ON wp.id = cwp.proficiency_id
       WHERE c.slug = $1`,
      [classSlug],
    );
    return rows.map((row) => row.slug);
  }
}
