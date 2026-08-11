import { DataSource } from 'typeorm';
import {
  isWarlockClass,
  readEldritchInvocationPicks,
  resolveEldritchInvocationFreeCast,
  type EldritchFreeCastResolution,
} from '@game/combat/domain/warlock';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { loadEldritchInvocationEffectCatalog } from '@game/combat/application/load-eldritch-invocation-effect-catalog';

export async function resolveEldritchFreeCastForSpell(input: {
  character: PlayerCharacter;
  dataSource: DataSource;
  spellSlug: string;
  classOptions: unknown;
}): Promise<EldritchFreeCastResolution | null> {
  const picks = isWarlockClass(input.character.classSlug)
    ? readEldritchInvocationPicks(input.classOptions as never)
    : [];
  if (picks.length === 0) return null;
  const catalog = await loadEldritchInvocationEffectCatalog(input.dataSource);
  return resolveEldritchInvocationFreeCast({
    spellSlug: input.spellSlug,
    pickedSlugs: picks.map((pick) => pick.slug),
    catalog,
  });
}
