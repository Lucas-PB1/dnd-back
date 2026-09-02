import { BadRequestException } from '@nestjs/common';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { BarbarianActionsHandler } from './barbarian-actions.handler';

describe('BarbarianActionsHandler', () => {
  const barbarian = createTestCharacter({
    id: 'barb-1',
    classSlug: 'barbarian',
    subclassSlug: 'berserker',
    level: 5,
    abilityScores: createTestAbilityScores({
      forca: 16,
      destreza: 14,
      constituicao: 14,
      inteligencia: 8,
      sabedoria: 10,
      carisma: 8,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: {
      classResources: [
        { slug: 'rage', remaining: 2, max: 2, name: 'Fúria', used: 0 },
      ],
      tempHp: 0,
      rageActive: false,
      recklessActive: false,
    },
    defaultCharacter: barbarian,
  });
  const syncCompanion = { execute: jest.fn().mockResolvedValue(undefined) };
  const dataSource = { query: jest.fn() };
  let handler: BarbarianActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    ctx.state.martial.toggleRage.mockImplementation(async (_c, active) => ({
      ...ctx.stateResponse,
      rageActive: active ?? true,
    }));
    handler = new BarbarianActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.domain),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(syncCompanion),
      asHandlerDep(dataSource),
    );
  });

  it('toggles rage on and spends via martial', async () => {
    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'toggle-rage',
    });

    expect(ctx.state.martial.toggleRage).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      true,
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Fúria ativa');
  });

  it('applies world-tree temp HP when entering rage', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'world-tree',
      level: 5,
    });

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'toggle-rage',
    });

    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      expect.objectContaining({ tempHp: 5 }),
    );
    expect(result.note).toContain('Surto de Vitalidade');
  });

  it('resolves Frenzy damage for Berserker', async () => {
    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'frenzy',
    });

    expect(result.expression).toBe('2d6');
    expect(result.note).toContain('Frenesi');
  });

  it('resolves Champion of the Gods with dice spend', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'zealot',
      level: 6,
    });

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'champion-of-the-gods',
      diceCount: 2,
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      'divine-fury-dice',
      2,
    );
    expect(result.expression).toBe('2d12');
    expect(result.note).toContain('Campeão dos Deuses');
  });

  it('enters free rage for muscle wizard without spend flag', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'path-of-the-muscle-wizard',
    });

    await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'undeniable-magic-rage',
    });

    expect(ctx.state.martial.toggleRage).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      true,
      false,
    );
  });

  it('resolves Wild Heart Eagle while raging', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'wild-heart',
    });
    ctx.state.buildResponse.mockResolvedValueOnce({
      ...ctx.stateResponse,
      rageActive: true,
    });

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'wild-heart-eagle',
    });

    expect(result.note).toContain('Águia');
    expect(result.note).toContain('Correr');
  });

  it('rejects Wild Heart Eagle without rage', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'wild-heart',
    });
    ctx.state.buildResponse.mockResolvedValueOnce({
      ...ctx.stateResponse,
      rageActive: false,
    });

    await expect(
      handler.useTableAction('user-1', 'barb-1', {
        actionSlug: 'wild-heart-eagle',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects non-barbarian', async () => {
    ctx.mockCharacterOnce({ ...barbarian, classSlug: 'fighter' });

    await expect(
      handler.useTableAction('user-1', 'barb-1', {
        actionSlug: 'toggle-rage',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
