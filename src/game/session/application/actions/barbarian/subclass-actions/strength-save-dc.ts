import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type {
  BarbarianActionDeps,
  PlayerCharacter,
} from '../barbarian-action-deps';

export async function strengthSaveDc(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<number> {
  const proficiency = await deps.domain.getProficiencyBonus(character.level);
  return 8 + proficiency + abilityModifier(character.abilityScores.forca);
}
