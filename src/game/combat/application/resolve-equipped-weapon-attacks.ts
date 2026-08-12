import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { PhbItem } from '@entities/phb-item.entity';
import { PhbWeapon } from '@entities/phb-weapon.entity';
import { PhbWeaponMastery } from '@entities/phb-weapon-mastery.entity';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import {
  loadWeaponMasteryBySlug,
  weaponPropsOf,
} from '@catalog/equipment/weapon-props';
import {
  computeWeaponAttacks,
  type EquippedWeaponPiece,
  type WeaponAttack,
} from '../domain/weapon-attacks';
import {
  hasPsychicBlades,
  PSYCHIC_BLADE_ITEM_SLUGS,
  psychicBladeEquipmentSlot,
} from '../domain/rogue/psychic-blades';
import { parseWeaponCharm } from '../domain/equipment';
import { itemRequiresAttunement } from '@game/inventory/domain/attunement';
import {
  coverageBonusToEffects,
  parseItemCoverage,
} from '@game/inventory/domain/coverage/item-coverage';
import {
  isMagicCatalogItem,
  masterworkTierBonusApplies,
} from '@game/inventory/domain/coverage/coverage-base-eligibility';
import { parsePermanentItemEffects } from '@game/inventory/domain/permanent-item-effects';
import { extraWeaponProficiencyFromClassOrder } from '@game/sheet/domain/validation/class-options/class-order-effects';

export type WeaponAttackResolveContext = {
  classSlug: string;
  proficiencyBonus: number;
  featSlugs?: readonly string[];
  fightingStyleSlugs?: readonly string[];
  classOptions?: readonly { optionKey: string; valueId: string }[];
  sizeCategory?: import('../domain/equipment').SizeCategory;
  hasShield?: boolean;
  masteredWeaponSlugs?: readonly string[];
  itemAttackBonus?: number;
  itemDamageBonus?: number;
  level?: number;
  subclassSlug?: string | null;
  rageActive?: boolean;
  recklessActive?: boolean;
  /** Snapshot compartilhado — evita novo `find` no combat slice. */
  equippedItems?: PlayerCharacterItem[];
};

@Injectable()
export class ResolveEquippedWeaponAttacks {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbWeapon)
    private readonly weapons: Repository<PhbWeapon>,
    @InjectRepository(PhbWeaponMastery)
    private readonly masteryRepo: Repository<PhbWeaponMastery>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
    private readonly dataSource: DataSource,
  ) {}

  async resolve(
    characterId: string,
    scores: AbilityScores,
    context: WeaponAttackResolveContext,
  ): Promise<WeaponAttack[]> {
    const isMonk = context.classSlug === 'monk';
    const soulknifeBlades = hasPsychicBlades({
      classSlug: context.classSlug,
      subclassSlug: context.subclassSlug,
      level: context.level,
    });
    const equipped = context.equippedItems
      ? context.equippedItems.filter(
          (row) =>
            row.location === 'equipped' &&
            (row.equipmentSlot === 'main_hand' ||
              row.equipmentSlot === 'off_hand'),
        )
      : await this.inventoryItems.find({
          where: {
            characterId,
            location: 'equipped',
            equipmentSlot: In(['main_hand', 'off_hand']),
          },
        });

    const pieces: EquippedWeaponPiece[] = [];
    if (equipped.length > 0) {
      pieces.push(...(await this.piecesFromInventory(equipped)));
    }
    if (soulknifeBlades) {
      pieces.push(...(await this.piecesFromCatalogSlugs([...PSYCHIC_BLADE_ITEM_SLUGS])));
    }

    if (pieces.length === 0 && !isMonk) {
      return [];
    }

    const weaponProficiencySlugs = [
      ...(await this.loadWeaponProficiencySlugs(context.classSlug)),
      ...extraWeaponProficiencyFromClassOrder(
        context.classSlug,
        context.classOptions,
      ),
    ];
    return this.computeAttacks(scores, pieces, context, weaponProficiencySlugs);
  }

  private async piecesFromInventory(
    equipped: PlayerCharacterItem[],
  ): Promise<EquippedWeaponPiece[]> {
    const rows = await this.weapons.find({
      where: { item: { slug: In(equipped.map((row) => row.itemSlug)) } },
      relations: ['item'],
    });
    const bySlug = new Map(rows.map((row) => [row.item.slug, row]));
    const masteryBySlug = await loadWeaponMasteryBySlug(rows, this.masteryRepo);
    const charmBySlug = await this.loadCharmsBySlug(equipped);
    const coverageBySlug = await this.loadCoveragesBySlug(equipped);
    const pieces: EquippedWeaponPiece[] = [];

    for (const item of equipped) {
      const weapon = bySlug.get(item.itemSlug);
      if (!weapon) continue;
      const coverageSlug = item.attachedCoverageSlug ?? null;
      const coverageMeta = coverageSlug
        ? coverageBySlug.get(coverageSlug)
        : undefined;
      const coverageActive =
        Boolean(coverageSlug) &&
        (!coverageMeta?.requiresAttunement ||
          item.attachedCoverageAttuned === true);
      const coverageBonuses = coverageActive
        ? this.resolveCoverageWeaponBonuses(
            coverageMeta,
            item.attachedCoverageBonus,
            isMagicCatalogItem(
              (weapon.item.properties ?? null) as Record<
                string,
                unknown
              > | null,
            ),
          )
        : { attackBonus: 0, damageBonus: 0 };
      pieces.push(
        this.toPiece(weapon, masteryBySlug, {
          equipmentSlot: item.equipmentSlot ?? 'main_hand',
          attachedCharmSlug: item.attachedCharmSlug ?? null,
          attachedCharmName: item.attachedCharmSlug
            ? (charmBySlug.get(item.attachedCharmSlug)?.name ?? null)
            : null,
          weaponCharm: item.attachedCharmSlug
            ? (charmBySlug.get(item.attachedCharmSlug)?.charm ?? null)
            : null,
          attachedCoverageSlug: coverageActive ? coverageSlug : null,
          attachedCoverageName: coverageActive
            ? (coverageMeta?.name ?? coverageSlug)
            : null,
          coverageAttackBonus: coverageBonuses.attackBonus,
          coverageDamageBonus: coverageBonuses.damageBonus,
        }),
      );
    }
    return pieces;
  }

  /** Carrega armas do catálogo por slug (ex.: Lâminas Psíquicas do seed C015). */
  private async piecesFromCatalogSlugs(
    slugs: string[],
  ): Promise<EquippedWeaponPiece[]> {
    const rows = await this.weapons.find({
      where: { item: { slug: In(slugs) } },
      relations: ['item'],
    });
    if (rows.length === 0) return [];
    const masteryBySlug = await loadWeaponMasteryBySlug(rows, this.masteryRepo);
    const bySlug = new Map(rows.map((row) => [row.item.slug, row]));
    const pieces: EquippedWeaponPiece[] = [];
    for (const slug of slugs) {
      const weapon = bySlug.get(slug);
      if (!weapon) continue;
      pieces.push(
        this.toPiece(weapon, masteryBySlug, {
          equipmentSlot: psychicBladeEquipmentSlot(slug),
          attachedCharmSlug: null,
          attachedCharmName: null,
          weaponCharm: null,
          attachedCoverageSlug: null,
          attachedCoverageName: null,
          coverageAttackBonus: 0,
          coverageDamageBonus: 0,
        }),
      );
    }
    return pieces;
  }

  private toPiece(
    weapon: PhbWeapon,
    masteryBySlug: Map<string, PhbWeaponMastery>,
    extras: {
      equipmentSlot: string;
      attachedCharmSlug: string | null;
      attachedCharmName: string | null;
      weaponCharm: NonNullable<ReturnType<typeof parseWeaponCharm>> | null;
      attachedCoverageSlug: string | null;
      attachedCoverageName: string | null;
      coverageAttackBonus: number;
      coverageDamageBonus: number;
    },
  ): EquippedWeaponPiece {
    const props = weaponPropsOf(weapon);
    const masterySlug = props.masteryId ?? null;
    const mastery = masterySlug
      ? (masteryBySlug.get(masterySlug) ?? null)
      : null;
    return {
      itemSlug: weapon.item.slug,
      itemName: weapon.item.name,
      category: weapon.category,
      damage: weapon.damage,
      damageType: weapon.damageType,
      versatileDamage: props.versatileDamage ?? null,
      propertySlugs: props.propertyIds ?? [],
      equipmentSlot: extras.equipmentSlot,
      masterySlug,
      masteryName: mastery?.name ?? null,
      reloadCapacity: typeof props.reload === 'number' ? props.reload : null,
      attachedCharmSlug: extras.attachedCharmSlug,
      attachedCharmName: extras.attachedCharmName,
      weaponCharm: extras.weaponCharm,
      attachedCoverageSlug: extras.attachedCoverageSlug,
      attachedCoverageName: extras.attachedCoverageName,
      coverageAttackBonus: extras.coverageAttackBonus,
      coverageDamageBonus: extras.coverageDamageBonus,
    };
  }

  private async loadCharmsBySlug(
    equipped: PlayerCharacterItem[],
  ): Promise<
    Map<string, { name: string; charm: NonNullable<ReturnType<typeof parseWeaponCharm>> }>
  > {
    const slugs = [
      ...new Set(
        equipped
          .map((row) => row.attachedCharmSlug)
          .filter((slug): slug is string => Boolean(slug)),
      ),
    ];
    const result = new Map<
      string,
      { name: string; charm: NonNullable<ReturnType<typeof parseWeaponCharm>> }
    >();
    if (slugs.length === 0) return result;

    const items = await this.catalogItems.find({
      where: { slug: In(slugs) },
    });
    for (const item of items) {
      const charm = parseWeaponCharm(
        (item.properties ?? null) as Record<string, unknown> | null,
      );
      if (!charm) continue;
      result.set(item.slug, { name: item.name, charm });
    }
    return result;
  }

  private async loadCoveragesBySlug(
    equipped: PlayerCharacterItem[],
  ): Promise<
    Map<
      string,
      {
        name: string;
        requiresAttunement: boolean;
        properties: Record<string, unknown> | null;
      }
    >
  > {
    const slugs = [
      ...new Set(
        equipped
          .map((row) => row.attachedCoverageSlug)
          .filter((slug): slug is string => Boolean(slug)),
      ),
    ];
    const result = new Map<
      string,
      {
        name: string;
        requiresAttunement: boolean;
        properties: Record<string, unknown> | null;
      }
    >();
    if (slugs.length === 0) return result;

    const items = await this.catalogItems.find({
      where: { slug: In(slugs) },
    });
    for (const item of items) {
      const properties = (item.properties ?? null) as Record<
        string,
        unknown
      > | null;
      if (!parseItemCoverage(properties)) continue;
      result.set(item.slug, {
        name: item.name,
        requiresAttunement: itemRequiresAttunement(properties),
        properties,
      });
    }
    return result;
  }

  private resolveCoverageWeaponBonuses(
    coverageMeta:
      | {
          name: string;
          requiresAttunement: boolean;
          properties: Record<string, unknown> | null;
        }
      | undefined,
    bonus: number | null | undefined,
    baseIsMagic = false,
  ): { attackBonus: number; damageBonus: number } {
    if (!coverageMeta) return { attackBonus: 0, damageBonus: 0 };
    const coverage = parseItemCoverage(coverageMeta.properties);
    if (!coverage) return { attackBonus: 0, damageBonus: 0 };

    if (
      !masterworkTierBonusApplies(coverageMeta.properties, baseIsMagic)
    ) {
      return { attackBonus: 0, damageBonus: 0 };
    }

    if (bonus === 1 || bonus === 2 || bonus === 3) {
      const fromTier = coverageBonusToEffects(coverage.appliesTo, bonus);
      return {
        attackBonus: fromTier.attackBonus ?? 0,
        damageBonus: fromTier.damageBonus ?? 0,
      };
    }

    const pe = parsePermanentItemEffects(coverageMeta.properties);
    return {
      attackBonus: pe.attackBonus,
      damageBonus: pe.damageBonus,
    };
  }

  private computeAttacks(
    scores: AbilityScores,
    pieces: EquippedWeaponPiece[],
    context: WeaponAttackResolveContext,
    weaponProficiencySlugs: string[],
  ): WeaponAttack[] {
    return computeWeaponAttacks(scores, pieces, {
      proficiencyBonus: context.proficiencyBonus,
      weaponProficiencySlugs,
      featSlugs: context.featSlugs,
      fightingStyleSlugs: context.fightingStyleSlugs,
      sizeCategory: context.sizeCategory,
      hasShield: context.hasShield,
      masteredWeaponSlugs: context.masteredWeaponSlugs,
      itemAttackBonus: context.itemAttackBonus,
      itemDamageBonus: context.itemDamageBonus,
      classSlug: context.classSlug,
      level: context.level,
      subclassSlug: context.subclassSlug,
      rageActive: context.rageActive,
      recklessActive: context.recklessActive,
    });
  }

  private async loadWeaponProficiencySlugs(classSlug: string): Promise<string[]> {
    const rows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT cwp.ref_slug AS slug
       FROM rpg.phb_class c
       JOIN rpg.phb_class_proficiency cwp
         ON cwp.class_id = c.id AND cwp.kind = 'weapon'::rpg.class_proficiency_kind
       WHERE c.slug = $1
       ORDER BY cwp.ref_slug`,
      [classSlug],
    );
    return rows.map((row) => row.slug);
  }
}
