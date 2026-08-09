import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  FighterTableActionResponseDto,
  UseRogueTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export type RogueActionDeps = {
  state: CharacterStateRepository;
  domain: CharacterDomainService;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

export type RogueTableActionResult = FighterTableActionResponseDto;
export type { PlayerCharacter, UseRogueTableActionDto };
