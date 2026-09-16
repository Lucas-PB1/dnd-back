import { BadRequestException } from '@nestjs/common';
import { ApplyVehicleSheetActionHandler } from './apply-vehicle-sheet-action.handler';

function ship() {
  return {
    id: 'veh-1',
    actorKind: 'vehicle',
    parentCharacterId: 'pc-1',
    templateSlug: 'navio-a-vela',
    crewCapacity: 20,
    passengerCapacity: null,
    cargoCapacityLb: 200000,
  };
}

describe('ApplyVehicleSheetActionHandler', () => {
  const access = {
    findAccessibleOrFail: jest.fn().mockResolvedValue({ id: 'pc-1' }),
  };
  const board = {
    execute: jest.fn().mockResolvedValue({ boardedActorId: 'veh-1' }),
  };
  const actorState = {
    patch: jest.fn().mockResolvedValue({
      crewCurrent: 4,
      crewCapacity: 20,
      passengerCurrent: 0,
      passengerCapacity: null,
      cargoCurrentLb: 500,
      cargoCapacityLb: 200000,
    }),
  };
  const actors = { findOne: jest.fn().mockResolvedValue(ship()) };
  const pcStates = {
    findOne: jest.fn().mockResolvedValue({ boardedActorId: 'veh-1' }),
  };
  const handler = new ApplyVehicleSheetActionHandler(
    access as never,
    board as never,
    actorState as never,
    actors as never,
    pcStates as never,
  );

  beforeEach(() => {
    jest.clearAllMocks();
    actors.findOne.mockResolvedValue(ship());
    pcStates.findOne.mockResolvedValue({ boardedActorId: 'veh-1' });
    board.execute.mockResolvedValue({ boardedActorId: 'veh-1' });
  });

  it('desembarca', async () => {
    board.execute.mockResolvedValue({ boardedActorId: null });
    const result = await handler.execute('u1', 'pc-1', { action: 'dismount' });
    expect(result.boardedActorId).toBeNull();
  });

  it('atualiza métricas', async () => {
    const result = await handler.execute('u1', 'pc-1', {
      action: 'set-metrics',
      crewCurrent: 4,
      cargoCurrentLb: 500,
    });
    expect(actorState.patch).toHaveBeenCalled();
    expect(result.note).toMatch(/4\/20 tripulação/);
    expect(result.actorState?.crewCurrent).toBe(4);
  });

  it('recusa leme sem estar embarcado', async () => {
    pcStates.findOne.mockResolvedValue({ boardedActorId: 'other' });
    await expect(
      handler.execute('u1', 'pc-1', { action: 'helm' }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('declara leme quando embarcado', async () => {
    const result = await handler.execute('u1', 'pc-1', { action: 'helm' });
    expect(result.actionName).toBe('Leme');
    expect(result.note).toMatch(/leme/i);
  });
});
