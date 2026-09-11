import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '../../primitives/table-action-guards';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export type MissileMageArmActionSlug =
  | 'arm-missile-shield'
  | 'disarm-missile-shield'
  | 'arm-giga-missile'
  | 'disarm-giga-missile';

export function parseMissileMageArmAction(
  actionSlug: string,
): { kind: 'shield' | 'giga'; armed: boolean } | null {
  switch (actionSlug) {
    case 'arm-missile-shield':
      return { kind: 'shield', armed: true };
    case 'disarm-missile-shield':
      return { kind: 'shield', armed: false };
    case 'arm-giga-missile':
      return { kind: 'giga', armed: true };
    case 'disarm-giga-missile':
      return { kind: 'giga', armed: false };
    default:
      return null;
  }
}

export async function applyMissileMageArmTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  kind: 'shield' | 'giga';
  armed: boolean;
}): Promise<TableActionResponseDto> {
  assertCharacterSubclass(input.character, 'magic-missile-mage', 'Mago dos Mísseis');
  if (input.kind === 'shield') {
    assertCharacterLevel(input.character, 10, 'Mago', 'Escudo de Mísseis');
  } else {
    assertCharacterLevel(input.character, 14, 'Mago', 'Giga-Míssil');
  }

  const state = await input.state.setMissileMageArmedFlags(input.character, {
    missileShieldArmed: input.kind === 'shield' ? input.armed : undefined,
    gigaMissileArmed: input.kind === 'giga' ? input.armed : undefined,
  });

  const label = input.kind === 'shield' ? 'Escudo de Mísseis' : 'Giga-Míssil';
  return {
    state: await input.state.buildResponse(input.character, state),
    actionName: label,
    resourceSpent: false,
    note: input.armed
      ? `${label} armado: aplica no próximo Mísseis Mágicos (gasta o uso no cast).`
      : `${label} desarmado.`,
  };
}
