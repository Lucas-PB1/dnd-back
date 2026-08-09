import { CharacterStateResponseDto } from '@game/session/dto/character-state.dto';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { PlayerCharacterState } from '@game/session/infrastructure/player-character-state.entity';

export type BuildResponse = (
  character: PlayerCharacter,
  stateRow?: PlayerCharacterState,
) => Promise<CharacterStateResponseDto>;
