import type { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export type FighterActionDeps = {
  access: PlayerCharacterAccessService;
  state: CharacterStateRepository;
  domain: CharacterDomainService;
  sheet: CharacterSheetRepository;
  mechanicalCatalog: LoadCombatMechanicalCatalog;
};
