import { CharacterDomainService } from '../../../../sheet/domain/core/character-domain.service';
import type { LoadCombatMechanicalCatalog } from '../../../../combat/application/load-combat-mechanical-catalog';
import type { PlayerCharacter } from '../../../../shared/infrastructure/player-character.entity';
import {
  FighterTableActionResponseDto,
  UseRogueTableActionDto,
} from '../../../dto/character-state.dto';
import { CharacterStateRepository } from '../../../infrastructure/character-state.repository';

export type RogueActionDeps = {
  state: CharacterStateRepository;
  domain: CharacterDomainService;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

export type RogueTableActionResult = FighterTableActionResponseDto;
export type { PlayerCharacter, UseRogueTableActionDto };
