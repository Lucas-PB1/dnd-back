import { DataSource, In } from 'typeorm';
import { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import {
  loadSpellSpiritProfile,
  loadSpellSpiritVariants,
} from '@game/spirit/infrastructure/spell-spirit.queries';

/**
 * Remove actors do personagem cujos templates pertencem à magia spirit mapeada.
 * No-op se a magia não está em phb_spell_spirit (ex.: Find Steed nunca entra via concentração).
 */
export async function despawnSpiritsForSpell(
  dataSource: DataSource,
  characterId: string,
  spellSlug: string | null | undefined,
): Promise<number> {
  if (!spellSlug) return 0;
  const profile = await loadSpellSpiritProfile(dataSource, spellSlug);
  if (!profile) return 0;
  const variants = await loadSpellSpiritVariants(dataSource, spellSlug);
  const templateSlugs = variants.map((v) => v.templateSlug);
  if (templateSlugs.length === 0) return 0;

  const actors = dataSource.getRepository(GameActor);
  const existing = await actors.find({
    where: {
      parentCharacterId: characterId,
      templateSlug: In(templateSlugs),
    },
  });
  if (existing.length === 0) return 0;
  await actors.remove(existing);
  return existing.length;
}

/** Se a concentração anterior era spirit e mudou/encerrou, despawna. */
export async function despawnSpiritsOnConcentrationChange(
  dataSource: DataSource,
  characterId: string,
  previousSpellSlug: string | null | undefined,
  nextSpellSlug: string | null | undefined,
): Promise<number> {
  if (!previousSpellSlug || previousSpellSlug === nextSpellSlug) return 0;
  return despawnSpiritsForSpell(dataSource, characterId, previousSpellSlug);
}
