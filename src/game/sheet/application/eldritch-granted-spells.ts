import { DataSource } from 'typeorm';
import {
  collectEldritchFreeCastSpellSlugs,
  readEldritchInvocationPicks,
  type ClassOptionLike,
} from '@game/combat/domain/warlock-features';
import { loadEldritchInvocationEffectCatalog } from '@game/combat/application/load-eldritch-invocation-effect-catalog';

/**
 * Magias always_prepared concedidas por Invocações Místicas free_cast.
 */
export async function resolveEldritchGrantedSpellSlugs(
  dataSource: DataSource,
  classOptions: readonly ClassOptionLike[] | null | undefined,
): Promise<Set<string>> {
  const picks = readEldritchInvocationPicks(classOptions);
  if (picks.length === 0) return new Set();
  const catalog = await loadEldritchInvocationEffectCatalog(dataSource);
  return collectEldritchFreeCastSpellSlugs(
    picks.map((pick) => pick.slug),
    catalog,
  );
}
