import { BadRequestException } from '@nestjs/common';
import { DismissCharacterCompanionHandler } from './dismiss-character-companion.handler';

describe('DismissCharacterCompanionHandler', () => {
  const access = {
    findAccessibleOrFail: jest.fn().mockResolvedValue({ id: 'pc-1' }),
  };
  const actors = {
    find: jest.fn(),
    remove: jest.fn(),
  };
  const pcStates = {
    findOne: jest.fn().mockResolvedValue({ boardedActorId: null }),
    save: jest.fn(),
  };
  const handler = new DismissCharacterCompanionHandler(
    access as never,
    actors as never,
    pcStates as never,
  );

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('dispensa o único companheiro', async () => {
    actors.find.mockResolvedValue([{ id: 'c1', actorKind: 'companion' }]);
    const result = await handler.execute('u1', 'pc-1', {});
    expect(result.dismissedActorId).toBe('c1');
    expect(actors.remove).toHaveBeenCalled();
  });

  it('exige actorId quando há vários', async () => {
    actors.find.mockResolvedValue([{ id: 'c1' }, { id: 'c2' }]);
    await expect(handler.execute('u1', 'pc-1', {})).rejects.toBeInstanceOf(
      BadRequestException,
    );
  });
});
