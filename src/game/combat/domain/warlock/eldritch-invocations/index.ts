import { warlockInvocationLimit } from '../features';
import type { FeatureScheduleBand } from '../../feature-schedule';
import { validateEldritchInvocationPicks } from './validate';
import {
  GIFT_OF_THE_DEPTHS_SLUG,
  type EldritchBlastCantripBinding,
  type EldritchFreeCastResolution,
  type EldritchInvocationCatalogRow,
  type EldritchInvocationEffectRow,
} from './types';

export function collectEldritchFreeCastSpellSlugs(
  pickedSlugs: readonly string[],
  catalog: readonly Pick<
    EldritchInvocationEffectRow,
    'slug' | 'kind' | 'grantedSpellSlug'
  >[],
): Set<string> {
  const picked = new Set(pickedSlugs);
  const spells = new Set<string>();
  for (const row of catalog) {
    if (!picked.has(row.slug)) continue;
    if (row.kind !== 'free_cast') continue;
    if (!row.grantedSpellSlug) continue;
    spells.add(row.grantedSpellSlug);
  }
  return spells;
}

export function resolveEldritchInvocationFreeCast(input: {
  spellSlug: string;
  pickedSlugs: readonly string[];
  catalog: readonly Pick<
    EldritchInvocationEffectRow,
    'slug' | 'name' | 'kind' | 'grantedSpellSlug'
  >[];
}): EldritchFreeCastResolution | null {
  const picked = new Set(input.pickedSlugs);
  for (const row of input.catalog) {
    if (!picked.has(row.slug)) continue;
    if (row.kind !== 'free_cast') continue;
    if (row.grantedSpellSlug !== input.spellSlug) continue;
    return {
      invocationSlug: row.slug,
      invocationName: row.name,
      economy:
        row.slug === GIFT_OF_THE_DEPTHS_SLUG
          ? 'once_per_long_rest'
          : 'at_will',
    };
  }
  return null;
}

export function buildEldritchCantripCastNote(input: {
  spellLevel: number;
  spellSlug: string;
  bindings: readonly EldritchBlastCantripBinding[];
  charismaModifier: number;
  warlockLevel: number;
}): string | null {
  if (input.spellLevel !== 0) return null;
  const matching = input.bindings.filter(
    (binding) => binding.cantripSlug === input.spellSlug,
  );
  if (matching.length === 0) return null;

  const parts: string[] = [];
  const kinds = new Set(matching.map((binding) => binding.invocationSlug));
  if (kinds.has('agonizing-blast')) {
    const bonus = Math.max(0, input.charismaModifier);
    parts.push(`Explosão Agonizante: +${bonus} de Carisma no dano`);
  }
  if (kinds.has('repelling-blast')) {
    parts.push('Explosão Repulsiva: empurre até 3 m (Grande ou menor)');
  }
  if (kinds.has('eldritch-spear')) {
    const rangeBonus = 9 * Math.max(1, input.warlockLevel);
    parts.push(`Lança Mística: alcance +${rangeBonus} m`);
  }
  return parts.length > 0 ? parts.join(' · ') : null;
}

export function pickRandomValidEldritchInvocations(input: {
  level: number;
  catalog: readonly EldritchInvocationCatalogRow[];
  featureSchedules: readonly FeatureScheduleBand[];
  limit?: number;
  random?: () => number;
}): { slug: string; instanceIndex: number }[] {
  const limit =
    input.limit ?? warlockInvocationLimit(input.level, input.featureSchedules);
  const random = input.random ?? Math.random;
  const eligible = input.catalog.filter((row) => row.minLevel <= input.level);
  const picks: { slug: string; instanceIndex: number }[] = [];

  while (picks.length < limit) {
    const candidates = shuffle(
      eligible.filter((row) => {
        const trial = [
          ...picks,
          { slug: row.slug, instanceIndex: picks.length },
        ];
        return (
          validateEldritchInvocationPicks({
            level: input.level,
            picks: trial,
            catalog: input.catalog,
            featureSchedules: input.featureSchedules,
          }).length === 0
        );
      }),
      random,
    );
    if (candidates.length === 0) break;
    picks.push({ slug: candidates[0].slug, instanceIndex: picks.length });
  }

  return picks;
}

function shuffle<T>(items: readonly T[], random: () => number): T[] {
  const next = [...items];
  for (let i = next.length - 1; i > 0; i -= 1) {
    const j = Math.floor(random() * (i + 1));
    [next[i], next[j]] = [next[j], next[i]];
  }
  return next;
}

export type {
  ClassOptionLike,
  EldritchBlastCantripBinding,
  EldritchCantripEligibility,
  EldritchFreeCastResolution,
  EldritchInvocationCatalogRow,
  EldritchInvocationEffectRow,
  EldritchOriginFeatBinding,
} from './types';
export { GIFT_OF_THE_DEPTHS_SLUG } from './types';
export {
  cantripEligibleForBlastInvocation,
  inferSpellDealsDamage,
  knownPactSlugsFromPicks,
  parseSpellRangeMeters,
  readEldritchInvocationCantripBindings,
  readEldritchInvocationOriginFeatBindings,
  readEldritchInvocationPicks,
} from './read';
export {
  validateEldritchBlastCantripBindings,
  validateEldritchInvocationPicks,
  validateEldritchOriginFeatBindings,
} from './validate';
export {
  BLAST_INVOCATION_SLUGS,
  ELDRITCH_INVOCATION_ORIGIN_FEAT_OPTION_KEY,
  isBlastInvocationSlug,
  isLessonsOfTheFirstOnesSlug,
  LESSONS_OF_THE_FIRST_ONES_SLUG,
} from '../features';
