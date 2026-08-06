import type { LoadCombatMechanicalCatalog } from '../../../../combat/application/load-combat-mechanical-catalog';
import type { CharacterDomainService } from '../../../../sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '../../../../sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacterAccessService } from '../../../../shared/player-character-access.service';
import type { CharacterStateRepository } from '../../../infrastructure/character-state.repository';

export type FighterActionDeps = {
  access: PlayerCharacterAccessService;
  state: CharacterStateRepository;
  domain: CharacterDomainService;
  sheet: CharacterSheetRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};
