import { In, type Repository } from 'typeorm';
import type { PhbWeapon } from '@entities/phb-weapon.entity';
import type { PhbWeaponMastery } from '@entities/phb-weapon-mastery.entity';
import type { PhbItem } from '@entities/phb-item.entity';
import type { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import {
  loadWeaponMasteryBySlug,
  weaponPropsOf,
} from '@catalog/game-port';
import type { EquippedWeaponPiece } from '../../domain/weapon-attacks';
import { psychicBladeEquipmentSlot } from '../../domain/rogue/psychic-blades';
import { parseWeaponCharm } from '../../domain/equipment';
import { isMagicCatalogItem } from '@game/inventory/domain/coverage/coverage-base-eligibility';
import {
  loadCharmsBySlug,
  loadCoveragesBySlug,
  resolveCoverageWeaponBonuses,
} from './coverage-and-charms';

function toPiece(
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

export async function piecesFromInventory(
  weapons: Repository<PhbWeapon>,
  masteryRepo: Repository<PhbWeaponMastery>,
  catalogItems: Repository<PhbItem>,
  equipped: PlayerCharacterItem[],
): Promise<EquippedWeaponPiece[]> {
  const rows = await weapons.find({
    where: { item: { slug: In(equipped.map((row) => row.itemSlug)) } },
    relations: ['item'],
  });
  const bySlug = new Map(rows.map((row) => [row.item.slug, row]));
  const masteryBySlug = await loadWeaponMasteryBySlug(rows, masteryRepo);
  const charmBySlug = await loadCharmsBySlug(catalogItems, equipped);
  const coverageBySlug = await loadCoveragesBySlug(catalogItems, equipped);
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
      ? resolveCoverageWeaponBonuses(
          coverageMeta,
          item.attachedCoverageBonus,
          isMagicCatalogItem(
            (weapon.item.properties ?? null) as Record<string, unknown> | null,
          ),
        )
      : { attackBonus: 0, damageBonus: 0 };
    pieces.push(
      toPiece(weapon, masteryBySlug, {
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

/** Armas do catálogo por slug (ex.: Lâminas Psíquicas do seed C015). */
export async function piecesFromCatalogSlugs(
  weapons: Repository<PhbWeapon>,
  masteryRepo: Repository<PhbWeaponMastery>,
  slugs: string[],
): Promise<EquippedWeaponPiece[]> {
  const rows = await weapons.find({
    where: { item: { slug: In(slugs) } },
    relations: ['item'],
  });
  if (rows.length === 0) return [];
  const masteryBySlug = await loadWeaponMasteryBySlug(rows, masteryRepo);
  const bySlug = new Map(rows.map((row) => [row.item.slug, row]));
  const pieces: EquippedWeaponPiece[] = [];
  for (const slug of slugs) {
    const weapon = bySlug.get(slug);
    if (!weapon) continue;
    pieces.push(
      toPiece(weapon, masteryBySlug, {
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
