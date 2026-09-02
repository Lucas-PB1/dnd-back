import type { CombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

import { asDep } from '@common/testing/as-dep';

/** Cast test double para construtor de handler — não usar `as never`. */
export function asHandlerDep<T = never>(mock: object): T {
  return asDep<T>(mock);
}

export type TableActionTestCharacter = Pick<
  PlayerCharacter,
  'id' | 'userId' | 'classSlug' | 'subclassSlug' | 'level' | 'abilityScores'
> &
  Partial<PlayerCharacter>;

export type TableActionAccessMock = jest.Mocked<
  Pick<PlayerCharacterAccessService, 'findAccessibleOrFail'>
>;

export type TableActionDomainMock = jest.Mocked<
  Pick<CharacterDomainService, 'getProficiencyBonus'>
>;

export type TableActionSheetMock = jest.Mocked<
  Pick<CharacterSheetRepository, 'load'>
>;

export type TableActionMartialMock = {
  toggleRage: jest.Mock;
  toggleReckless: jest.Mock;
  recoverAllRage: jest.Mock;
  listManeuvers: jest.Mock;
  useManeuver: jest.Mock;
  reloadFirearm: jest.Mock;
  fireChamber: jest.Mock;
  setPersonaMasks: jest.Mock;
};

export type TableActionStateMock = jest.Mocked<
  Pick<
    CharacterStateRepository,
    | 'buildResponse'
    | 'useClassResource'
    | 'recoverClassResource'
    | 'recoverSpellSlotLevel'
    | 'patch'
  >
> & {
  consumeSpellSlotLevel: jest.Mock;
  setStarryForm: jest.Mock;
  martial: TableActionMartialMock;
};

export type TableActionMechanicalCatalogMock = {
  load: jest.Mock<Promise<CombatMechanicalCatalog>, []>;
};

export type TableActionHandlerTestContext = {
  access: TableActionAccessMock;
  domain: TableActionDomainMock;
  state: TableActionStateMock;
  sheet: TableActionSheetMock;
  mechanicalCatalog: TableActionMechanicalCatalogMock;
  stateResponse: CharacterStateResponseDto;
  defaultCharacter: TableActionTestCharacter;
  mockCharacter: (overrides: Partial<TableActionTestCharacter>) => void;
  mockCharacterOnce: (overrides: Partial<TableActionTestCharacter>) => void;
  resetMocks: () => void;
};
