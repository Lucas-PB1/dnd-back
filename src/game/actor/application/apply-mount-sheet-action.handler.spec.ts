import { BadRequestException } from '@nestjs/common';
import { ApplyMountSheetActionHandler } from './apply-mount-sheet-action.handler';

function celestialMount() {
  return {
    id: 'mount-1',
    actorKind: 'mount',
    parentCharacterId: 'pc-1',
    templateSlug: 'montaria-sobrenatural-celestial',
    hitPointsCurrent: 10,
    hitPointsMax: 25,
  };
}

describe('ApplyMountSheetActionHandler', () => {
  const character = {
    id: 'pc-1',
    hitPointsCurrent: 20,
    hitPointsMax: 40,
  };
  const access = {
    findAccessibleOrFail: jest.fn().mockResolvedValue(character),
  };
  const characters = { save: jest.fn().mockResolvedValue(character) };
  const board = {
    execute: jest.fn().mockResolvedValue({ boardedActorId: 'mount-1' }),
  };
  const actorState = {
    ensureState: jest.fn().mockResolvedValue({ innateSpellUses: {} }),
  };
  const actors = {
    findOne: jest.fn().mockResolvedValue(celestialMount()),
    save: jest.fn(),
  };
  const actorStates = { save: jest.fn() };
  const pcStates = {
    findOne: jest.fn().mockResolvedValue({ boardedActorId: 'mount-1' }),
  };

  const handler = new ApplyMountSheetActionHandler(
    access as never,
    characters as never,
    board as never,
    actorState as never,
    actors as never,
    actorStates as never,
    pcStates as never,
  );

  beforeEach(() => {
    jest.clearAllMocks();
    character.hitPointsCurrent = 20;
    access.findAccessibleOrFail.mockResolvedValue(character);
    actors.findOne.mockResolvedValue(celestialMount());
    actorState.ensureState.mockResolvedValue({ innateSpellUses: {} });
    pcStates.findOne.mockResolvedValue({ boardedActorId: 'mount-1' });
    board.execute.mockResolvedValue({ boardedActorId: 'mount-1' });
  });

  it('desmonta', async () => {
    board.execute.mockResolvedValue({ boardedActorId: null });
    const result = await handler.execute('u1', 'pc-1', { action: 'dismount' });
    expect(board.execute).toHaveBeenCalledWith('u1', 'pc-1', { actorId: null });
    expect(result.boardedActorId).toBeNull();
  });

  it('aplica Toque Curativo no cavaleiro', async () => {
    const result = await handler.execute('u1', 'pc-1', {
      action: 'healing-touch',
      amount: 10,
    });
    expect(character.hitPointsCurrent).toBe(30);
    expect(result.healed).toBe(10);
    expect(result.resourceSpent).toBe(true);
    expect(actorStates.save).toHaveBeenCalled();
  });

  it('recusa Toque Curativo sem amount', async () => {
    await expect(
      handler.execute('u1', 'pc-1', { action: 'healing-touch' }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('declara Passo Feérico só na montaria feérica embarcada', async () => {
    actors.findOne.mockResolvedValue({
      ...celestialMount(),
      templateSlug: 'montaria-sobrenatural-feerico',
    });
    const result = await handler.execute('u1', 'pc-1', { action: 'fey-step' });
    expect(result.actionName).toBe('Passo Feérico');
    expect(result.note).toMatch(/teleporta/);
  });
});
