import { BadRequestException } from '@nestjs/common';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import type {
  DeclaredEconomyTableActionDeps,
  DeclaredEconomyTableActionOptions,
} from './types';

/**
 * Slug-based validations before effect lookup.
 * Throws on invalid input; always returns null to continue routing.
 */
export async function trySlugEarlyRoute(
  _deps: DeclaredEconomyTableActionDeps,
  character: PlayerCharacter,
  action: ClassEconomyActionRecord,
  actionSlug: string,
  options: DeclaredEconomyTableActionOptions,
): Promise<null> {
  if (actionSlug === 'recover-risk' && character.level < 15) {
    throw new BadRequestException(
      'Gambito Terrível requires Gunslinger level 15+',
    );
  }

  if (actionSlug === 'healing-light' && options.diceCount != null) {
    const chaMod = abilityModifier(character.abilityScores?.carisma ?? 10);
    const maxDice = Math.max(1, chaMod);
    if (
      !Number.isInteger(options.diceCount) ||
      options.diceCount < 1 ||
      options.diceCount > maxDice
    ) {
      throw new BadRequestException(
        `Luz Medicinal: escolha de 1 a ${maxDice} d6(s)`,
      );
    }
  }

  if (actionSlug === 'bastion-of-law' && options.amount != null) {
    if (
      !Number.isInteger(options.amount) ||
      options.amount < 1 ||
      options.amount > 5
    ) {
      throw new BadRequestException(
        'Bastião da Lei: gaste de 1 a 5 Pontos de Feitiçaria',
      );
    }
  }

  if (actionSlug.startsWith('natural-recovery-')) {
    const slotLevel = Number(actionSlug.replace('natural-recovery-', ''));
    const maxCircles = Math.ceil(character.level / 2);
    if (
      !Number.isInteger(slotLevel) ||
      slotLevel < 1 ||
      slotLevel > 5 ||
      slotLevel > maxCircles
    ) {
      throw new BadRequestException(
        `Recuperação Natural: no nível ${character.level} escolha slot de 1 a ${maxCircles}`,
      );
    }
  }

  if (
    action.subclassSlug != null &&
    character.subclassSlug !== action.subclassSlug
  ) {
    throw new BadRequestException(`${action.name} exige a subclasse correta`);
  }

  return null;
}
