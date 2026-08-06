import { CharacterStateResponseDto } from '../../../dto/character-state.dto';
import { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import { PlayerCharacterState } from '../../player-character-state.entity';

export type BuildResponse = (
  character: PlayerCharacter,
  stateRow?: PlayerCharacterState,
) => Promise<CharacterStateResponseDto>;
