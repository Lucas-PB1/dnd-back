import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import {
  resolveCompanionSummon,
  type CompanionTableActionDeps,
} from '../../shared/companion-table-actions';
import type {
  BarbarianActionDeps,
  BarbarianTableActionResult,
} from '../barbarian-action-deps';
import { SHAPE_OF_THE_WILD } from '../barbarian-action-deps';

const SUBCLASS = 'pathofthe-primal-spirit';
const SUBCLASS_LABEL = 'Espírito Primal';

/** Forma do Selvagem: gasta o uso e restaura o companheiro ao PV máximo (formas atuais da ficha). */
export async function resolveShapeOfTheWild(
  deps: BarbarianActionDeps,
  companionDeps: CompanionTableActionDeps,
  userId: string,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, SUBCLASS, SUBCLASS_LABEL);
  assertCharacterLevel(character, 14, 'Bárbaro', 'Forma do Selvagem');
  await deps.state.useClassResource(character, SHAPE_OF_THE_WILD, 1);
  const synced = await resolveCompanionSummon(
    companionDeps,
    userId,
    character,
    SUBCLASS,
    SUBCLASS_LABEL,
    'Forma do Selvagem',
    true,
  );
  return {
    ...synced,
    resourceSpent: true,
    note: [
      synced.note,
      'Companheiro sincronizado com as opções atuais da ficha (Guardian/Striker/ambiente).',
    ]
      .filter(Boolean)
      .join(' '),
  };
}
