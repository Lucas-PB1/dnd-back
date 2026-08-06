import type { CharacterDomainService } from '../../../../sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import type {
  TableActionResponseDto,
  UseWarlockTableActionDto,
} from '../../../dto/character-state.dto';
import type { CharacterStateRepository } from '../../../infrastructure/character-state.repository';
import type { PlayerCharacterAccessService } from '../../../../shared/player-character-access.service';

export type WarlockActionDeps = {
  access: PlayerCharacterAccessService;
  state: CharacterStateRepository;
  domain: CharacterDomainService;
};

export type WarlockTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseWarlockTableActionDto };
