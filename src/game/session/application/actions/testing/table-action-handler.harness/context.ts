import type { CombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  createEmptyMechanicalCatalogLoad,
  createTestCharacter,
} from './factories';
import { createTableActionStateMock } from './state-mock';
import type {
  TableActionAccessMock,
  TableActionDomainMock,
  TableActionHandlerTestContext,
  TableActionMechanicalCatalogMock,
  TableActionSheetMock,
  TableActionTestCharacter,
} from './types';
import type { CharacterSheetData } from '@game/sheet/domain/character-sheet.types';

export function createTableActionHandlerTestContext(options?: {
  stateResponse?: Partial<CharacterStateResponseDto>;
  defaultCharacter?: TableActionTestCharacter;
  proficiencyBonus?: number;
  mechanicalCatalogLoad?: Partial<CombatMechanicalCatalog>;
}): TableActionHandlerTestContext {
  const stateResponse = {
    classResources: [],
    ...options?.stateResponse,
  } as CharacterStateResponseDto;
  const proficiencyBonus = options?.proficiencyBonus ?? 3;
  const defaultCharacter =
    options?.defaultCharacter ?? createTestCharacter({ classSlug: 'fighter' });
  const catalogLoad = createEmptyMechanicalCatalogLoad(
    options?.mechanicalCatalogLoad,
  );

  const access: TableActionAccessMock = {
    findAccessibleOrFail: jest
      .fn()
      .mockResolvedValue(defaultCharacter as PlayerCharacter),
  };
  const domain: TableActionDomainMock = {
    getProficiencyBonus: jest.fn().mockResolvedValue(proficiencyBonus),
  };
  const state = createTableActionStateMock(stateResponse);
  const sheet: TableActionSheetMock = {
    load: jest.fn().mockResolvedValue({
      classSkillSlugs: [],
      speciesChoices: [],
      heritageChoices: [],
      classOptions: [],
      subclassOptions: [],
      characterFeats: [],
      featOptions: [],
      backgroundSkillSlugs: [],
      equipment: [],
      languageSlugs: [],
      characterSpells: [],
      abilityGenerationMethodSlug: null,
      transformation: null,
    } as CharacterSheetData),
  };
  const mechanicalCatalog: TableActionMechanicalCatalogMock = {
    load: jest.fn().mockResolvedValue(catalogLoad),
  };

  const resetStateMocks = () => {
    state.useClassResource.mockResolvedValue({
      state: stateResponse,
      roll: null,
    });
    state.recoverClassResource.mockResolvedValue(stateResponse);
    state.buildResponse.mockResolvedValue(stateResponse);
    state.recoverSpellSlotLevel.mockResolvedValue(undefined);
    state.consumeSpellSlotLevel.mockResolvedValue(undefined);
    state.patch.mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    }));
    domain.getProficiencyBonus.mockResolvedValue(proficiencyBonus);
    access.findAccessibleOrFail.mockResolvedValue(defaultCharacter as PlayerCharacter);
    mechanicalCatalog.load.mockResolvedValue(catalogLoad);
  };

  return {
    access,
    domain,
    state,
    sheet,
    mechanicalCatalog,
    stateResponse,
    defaultCharacter,
    mockCharacter: (overrides) => {
      access.findAccessibleOrFail.mockResolvedValue({
        ...defaultCharacter,
        ...overrides,
      } as PlayerCharacter);
    },
    mockCharacterOnce: (overrides) => {
      access.findAccessibleOrFail.mockResolvedValueOnce({
        ...defaultCharacter,
        ...overrides,
      } as PlayerCharacter);
    },
    resetMocks: () => {
      jest.clearAllMocks();
      resetStateMocks();
    },
  };
}
