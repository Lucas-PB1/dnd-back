import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseRogueTableActionDto,
} from '@game/session/dto/table-actions/table-actions-martial.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export type RogueActionDeps = {
  state: CharacterStateRepository;
  domain: CharacterDomainService;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

export type RogueTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseRogueTableActionDto };
