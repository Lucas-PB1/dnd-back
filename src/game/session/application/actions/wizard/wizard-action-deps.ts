import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export type WizardActionDeps = {
  state: CharacterStateRepository;
  domain: CharacterDomainService;
};

export type WizardTableActionResult = TableActionResponseDto;
export type { PlayerCharacter };
