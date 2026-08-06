import { BadRequestException } from '@nestjs/common';
import { psiEnergyDieFaces } from '../../../../combat/domain/fighter-features';
import {
  resolveSoulknifeTableAction,
  type SoulknifeActionSlug,
} from '../../../../combat/domain/rogue-table-actions';
import { abilityModifier } from '../../../../sheet/domain/stats/ability-modifier';
import type { PlayerCharacter, RogueActionDeps } from './rogue-action-deps';

export function psiDieFaces(character: PlayerCharacter): number {
  const faces = psiEnergyDieFaces(character.level);
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
  return resolveSoulknifeTableAction({
    catalog: catalog.tableActions,
    actionSlug,
    level: character.level,
    dexterityModifier: abilityModifier(character.abilityScores.destreza),
    proficiencyBonus: pb,
    ...options,
  });
}
