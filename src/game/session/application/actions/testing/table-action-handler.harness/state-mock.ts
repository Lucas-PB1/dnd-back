import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { TableActionMartialMock, TableActionStateMock } from './types';

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
