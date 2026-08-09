import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  TableActionResponseDto,
  UseWarlockTableActionDto,
} from '@game/session/dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';

export type WarlockActionDeps = {
  access: PlayerCharacterAccessService;
  state: CharacterStateRepository;
  domain: CharacterDomainService;
};

export type WarlockTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseWarlockTableActionDto };
