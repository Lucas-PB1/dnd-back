import { BadRequestException } from '@nestjs/common';
import { BoardCharacterVehicleHandler } from './character-vehicle.handlers';

describe('BoardCharacterVehicleHandler', () => {
  const access = {
    findAccessibleOrFail: jest.fn().mockResolvedValue({ id: 'pc-1' }),
  };
  const actors = { findOne: jest.fn() };
  const states = {
    findOne: jest.fn().mockResolvedValue({ characterId: 'pc-1', boardedActorId: null }),
    create: jest.fn((row) => row),
    save: jest.fn(async (row) => row),
  };
  const handler = new BoardCharacterVehicleHandler(
    access as never,
    actors as never,
    states as never,
  );

  beforeEach(() => {
    jest.clearAllMocks();
    access.findAccessibleOrFail.mockResolvedValue({ id: 'pc-1' });
    states.findOne.mockResolvedValue({
      characterId: 'pc-1',
      boardedActorId: null,
    });
  });

  it('desmonta com actorId null', async () => {
    const result = await handler.execute('u1', 'pc-1', { actorId: null });
    expect(result.boardedActorId).toBeNull();
  });

  it('embarca montaria vinculada', async () => {
    actors.findOne.mockResolvedValue({
      id: 'mount-1',
      parentCharacterId: 'pc-1',
      actorKind: 'mount',
      hitPointsCurrent: 13,
    });
    const result = await handler.execute('u1', 'pc-1', { actorId: 'mount-1' });
    expect(result.boardedActorId).toBe('mount-1');
  });

  it('recusa montaria a 0 PV', async () => {
    actors.findOne.mockResolvedValue({
      id: 'mount-1',
      parentCharacterId: 'pc-1',
      actorKind: 'mount',
      hitPointsCurrent: 0,
    });
    await expect(
      handler.execute('u1', 'pc-1', { actorId: 'mount-1' }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
