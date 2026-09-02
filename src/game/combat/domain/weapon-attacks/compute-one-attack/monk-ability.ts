import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { abilityModifier } from '@game/shared/domain/ability-scores';
import type { AbilityPick } from '../attack-bonuses';

export function resolveMonkAbility(
  scores: AbilityScores,
  ability: AbilityPick,
): AbilityPick {
  const str = abilityModifier(scores.forca);
  const dex = abilityModifier(scores.destreza);
  if (dex > ability.mod) return { slug: 'destreza', mod: dex };
  if (str >= dex && str > ability.mod) return { slug: 'forca', mod: str };
  return ability;
}
