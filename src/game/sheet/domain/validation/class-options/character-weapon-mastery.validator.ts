import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '@common/assert';
import { ClassProficienciesQuery } from '@catalog/game-port';
import { CharacterSheetInput, CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import {
  classWeaponMasterySlotsAtLevel,
  isClassWeaponMasteryOptionKey,
  parseWeaponMasteryEligibility,
} from './class-weapon-mastery-slots';
import { isProficient, type EquippedWeaponPiece } from '@game/combat/domain/weapon-attacks';
import { collectFightingStyleSlugsFromSubclassOptions } from './fighting-style-feat-options';
import {
  loadWeaponMasteryPiece,
} from '@game/sheet/infrastructure/queries/class-option.queries';
import {
  loadWeaponMasteryEligibility,
  loadWeaponMasteryProgression,
} from '@game/sheet/infrastructure/queries/class-meta.queries';

@Injectable()
export class CharacterWeaponMasteryValidator {
  constructor(
    private readonly dataSource: DataSource,
    private readonly proficiencies: ClassProficienciesQuery,
  ) {}

  async validateClassWeaponMasteryOptions(
    ctx: CharacterSheetContext,
    options: NonNullable<CharacterSheetInput['classOptions']>,
    sheet?: Pick<CharacterSheetInput, 'characterFeats' | 'subclassOptions'>,
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
      masteryOptions.map((option) => option.optionKey),
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
    const weaponProficiencySlugs = (
      await this.proficiencies.forClassSlug(ctx.classSlug)
    ).weaponProficiencySlugs;
    const featSlugs = (sheet?.characterFeats ?? ctx.characterFeats ?? []).map(
      (feat) => feat.featSlug,
    );
    const fightingStyleSlugs = collectFightingStyleSlugsFromSubclassOptions(
      sheet?.subclassOptions,
    );
    const chosen = masteryOptions.map((option) => option.valueId);
    assertUnique(chosen, 'Weapon mastery choices must be distinct');

    for (const option of masteryOptions) {
      await this.assertMasteryWeaponChoice(
        ctx.classSlug,
        option.valueId,
        eligibility,
        weaponProficiencySlugs,
        featSlugs,
        fightingStyleSlugs,
      );
    }
  }

  async loadWeaponMasteryProgression(classSlug: string) {
    return loadWeaponMasteryProgression(this.dataSource, classSlug);
  }

  private async loadWeaponMasteryEligibility(classSlug: string): Promise<string | null> {
    return loadWeaponMasteryEligibility(this.dataSource, classSlug);
  }

  private async assertMasteryWeaponChoice(
    classSlug: string,
    weaponSlug: string,
    eligibility: ReturnType<typeof parseWeaponMasteryEligibility>,
    weaponProficiencySlugs: string[],
    featSlugs: string[],
    fightingStyleSlugs: string[],
  ): Promise<void> {
    const row = await loadWeaponMasteryPiece(this.dataSource, weaponSlug);
    if (!row) {
      throw new BadRequestException(
        `Weapon mastery choice '${weaponSlug}' is not a valid weapon`,
      );
    }
    if (!row.masterySlug) {
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
      damageType: row.damageType,
      versatileDamage: props.versatileDamage ?? null,
      propertySlugs,
      equipmentSlot: 'main_hand',
    };
    if (
      !isProficient(piece, {
        proficiencyBonus: 2,
        weaponProficiencySlugs,
        featSlugs,
        fightingStyleSlugs,
      })
    ) {
      throw new BadRequestException(
        `Weapon mastery choice '${weaponSlug}' requires proficiency`,
      );
    }
  }
}
