import { BadRequestException } from '@nestjs/common';
import { psiEnergyDieFaces } from '@game/combat/domain/fighter';
import { featureSchedulesFromCatalog } from '@game/combat/domain/feature-schedule';
import {
  resolveSoulknifeTableAction,
  type SoulknifeActionSlug,
} from '@game/combat/domain/rogue';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type { PlayerCharacter, RogueActionDeps } from './rogue-action-deps';

export async function psiDieFaces(
  deps: RogueActionDeps,
  character: PlayerCharacter,
): Promise<number> {
  const catalog = await deps.mechanicalCatalog.load();
  const bands = featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
  const faces = psiEnergyDieFaces(character.level, bands);
  if (faces == null) {
    throw new BadRequestException('Soulknife Psi Energy Die is unavailable');
  }
  return faces;
}

export async function resolveSoulknifeAction(
  deps: RogueActionDeps,
  character: PlayerCharacter,
  actionSlug: SoulknifeActionSlug,
  options: {
    dieRoll?: number;
    usePsiDice?: boolean;
    succeededWithDie?: boolean;
  },
) {
  const pb = await deps.domain.getProficiencyBonus(character.level);
  const catalog = await deps.mechanicalCatalog.load();
  const bands = featureSchedulesFromCatalog(
    catalog,
    character.classSlug,
    character.subclassSlug,
  );
  return resolveSoulknifeTableAction({
    catalog: catalog.tableActions,
    actionSlug,
    level: character.level,
    dexterityModifier: abilityModifier(character.abilityScores.destreza),
    proficiencyBonus: pb,
    ...options,
    bands,
  });
}
