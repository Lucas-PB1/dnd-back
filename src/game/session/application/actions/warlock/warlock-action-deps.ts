import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import type {
  UseWarlockTableActionDto,
} from '@game/session/dto/table-actions/table-actions-caster.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';

export type WarlockActionDeps = {
  access: PlayerCharacterAccessService;
  state: CharacterStateRepository;
  domain: CharacterDomainService;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};

export type WarlockTableActionResult = TableActionResponseDto;
export type { PlayerCharacter, UseWarlockTableActionDto };
