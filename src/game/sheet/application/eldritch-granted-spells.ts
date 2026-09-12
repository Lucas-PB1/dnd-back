import { DataSource } from 'typeorm';
import {
  collectEldritchFreeCastSpellSlugs,
  readEldritchInvocationPicks,
  type ClassOptionLike,
} from '@game/combat/domain/warlock';
import { loadEldritchInvocationEffectCatalog } from '@game/combat/application/load-eldritch-invocation-effect-catalog';


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
