import { In, type Repository } from 'typeorm';
import type { PhbItem } from '@entities/equipment/phb-item.entity';
import type { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { itemRequiresAttunement } from '@game/inventory/domain/attunement';
import {
  coverageBonusToEffects,
  parseItemCoverage,
} from '@game/inventory/domain/coverage/item-coverage';
import { masterworkTierBonusApplies } from '@game/inventory/domain/coverage/coverage-base-eligibility';
import { parsePermanentItemEffects } from '@game/inventory/domain/permanent-item-effects';
import { parseWeaponCharm } from '../../domain/equipment';
import type { CoverageCatalogMeta } from './types';

export type CharmCatalogEntry = {
  name: string;
  charm: NonNullable<ReturnType<typeof parseWeaponCharm>>;
};

export async function loadCharmsBySlug(
  catalogItems: Repository<PhbItem>,
  equipped: PlayerCharacterItem[],
): Promise<Map<string, CharmCatalogEntry>> {
  const slugs = [
    ...new Set(
      equipped
        .map((row) => row.attachedCharmSlug)
        .filter((slug): slug is string => Boolean(slug)),
    ),
  ];
  const result = new Map<string, CharmCatalogEntry>();
  if (slugs.length === 0) return result;

  const items = await catalogItems.find({ where: { slug: In(slugs) } });
  for (const item of items) {
    const charm = parseWeaponCharm(
      (item.properties ?? null) as Record<string, unknown> | null,
    );
    if (!charm) continue;
    result.set(item.slug, { name: item.name, charm });
  }
  return result;
}

export async function loadCoveragesBySlug(
  catalogItems: Repository<PhbItem>,
  equipped: PlayerCharacterItem[],
): Promise<Map<string, CoverageCatalogMeta>> {
  const slugs = [
    ...new Set(
      equipped
        .map((row) => row.attachedCoverageSlug)
        .filter((slug): slug is string => Boolean(slug)),
    ),
  ];
  const result = new Map<string, CoverageCatalogMeta>();
  if (slugs.length === 0) return result;

  const items = await catalogItems.find({ where: { slug: In(slugs) } });
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

export function resolveCoverageWeaponBonuses(
  coverageMeta: CoverageCatalogMeta | undefined,
  bonus: number | null | undefined,
  baseIsMagic = false,
): { attackBonus: number; damageBonus: number } {
  if (!coverageMeta) return { attackBonus: 0, damageBonus: 0 };
  const coverage = parseItemCoverage(coverageMeta.properties);
  if (!coverage) return { attackBonus: 0, damageBonus: 0 };

  if (!masterworkTierBonusApplies(coverageMeta.properties, baseIsMagic)) {
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
