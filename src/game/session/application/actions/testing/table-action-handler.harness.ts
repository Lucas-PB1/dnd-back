import type { CombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import type { CharacterSheetData } from '@game/sheet/domain/character-sheet.types';
import type {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

/** Cast test double para construtor de handler — não usar `as never`. */
export function asHandlerDep<T>(mock: object): T {
  return mock as unknown as T;
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

const DEFAULT_SCORES: AbilityScores = {
  forca: 10,
  destreza: 14,
  constituicao: 12,
  inteligencia: 10,
  sabedoria: 12,
  carisma: 10,
};

export function createTestAbilityScores(
  overrides: Partial<AbilityScores> = {},
): AbilityScores {
  return { ...DEFAULT_SCORES, ...overrides };
}

export function createTestCharacter(
  overrides: Partial<TableActionTestCharacter> &
    Pick<TableActionTestCharacter, 'classSlug'>,
): TableActionTestCharacter {
  return {
    id: 'char-1',
    userId: 'user-1',
    subclassSlug: null,
    level: 5,
    abilityScores: createTestAbilityScores(),
    ...overrides,
  };
}

export function createEmptyMechanicalCatalogLoad(
  overrides: Partial<CombatMechanicalCatalog> = {},
): CombatMechanicalCatalog {
  return {
    gunslingerManeuvers: [],
    battleMasterManeuvers: [],
    cunningStrikeEffects: [],
    tableActions: [],
    personaMasks: [],
    personaMaskSlugs: [],
    beastborneAspectBenefits: [],
    dungeoneerSlayerLabels: [],
    precautionSpells: [],
    economyActions: [],
    panelActions: [],
    ...overrides,
  };
}

function createMartialMock(
  stateResponse: CharacterStateResponseDto,
): TableActionMartialMock {
  return {
    toggleRage: jest.fn().mockImplementation(async (_c, active?: boolean) => ({
      ...stateResponse,
      rageActive: active ?? true,
    })),
    toggleReckless: jest.fn().mockImplementation(async (_c, active?: boolean) => ({
      ...stateResponse,
      recklessActive: active ?? true,
    })),
    recoverAllRage: jest.fn().mockResolvedValue(stateResponse),
    listManeuvers: jest.fn(),
    useManeuver: jest.fn().mockResolvedValue({ state: stateResponse }),
    reloadFirearm: jest.fn().mockResolvedValue(stateResponse),
    fireChamber: jest.fn().mockResolvedValue(stateResponse),
    setPersonaMasks: jest.fn().mockResolvedValue(stateResponse),
  };
}

export function createTableActionStateMock(
  stateResponse: CharacterStateResponseDto,
): TableActionStateMock {
  const state = {
    useClassResource: jest
      .fn()
      .mockResolvedValue({ state: stateResponse, roll: null }),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    recoverSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    consumeSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    patch: jest.fn().mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    })),
    setStarryForm: jest.fn().mockImplementation(async (_c, input) => ({
      ...stateResponse,
      starryFormActive: input.active,
      stellarConstellation: input.constellation ?? null,
    })),
    martial: createMartialMock(stateResponse),
  };
  return state as TableActionStateMock;
}

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
