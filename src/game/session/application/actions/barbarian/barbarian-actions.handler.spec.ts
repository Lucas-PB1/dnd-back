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
        {
          slug: 'divine-fury-dice',
          remaining: 4,
          max: 4,
          name: 'Dados de Fúria Divina',
          used: 0,
        },
      ],
      tempHp: 0,
      rageActive: false,
      recklessActive: false,
    },
    defaultCharacter: barbarian,
    mechanicalCatalogLoad: {
      economyActions: [
        {
          id: 'barbarian-rage',
          name: 'Fúria',
          economy: 'bonus',
          classSlug: 'barbarian',
          minLevel: 1,
          resourceSlug: 'rage',
          alwaysSpendsResource: false,
          tableAction: 'toggle-rage',
          itemSlug: null,
          featSlug: null,
          description: 'Entrar/encerrar Fúria.',
        },
        {
          id: 'barbarian-frenzy',
          name: 'Frenesi',
          economy: 'free',
          classSlug: 'barbarian',
          subclassSlug: 'berserker',
          minLevel: 3,
          tableAction: 'frenzy',
          itemSlug: null,
          featSlug: null,
          description: 'Frenesi.',
        },
        {
          id: 'barbarian-champion',
          name: 'Campeão dos Deuses',
          economy: 'bonus',
          classSlug: 'barbarian',
          subclassSlug: 'zealot',
          minLevel: 3,
          resourceSlug: 'divine-fury-dice',
          alwaysSpendsResource: false,
          tableAction: 'champion-of-the-gods',
          itemSlug: null,
          featSlug: null,
          description: 'Gaste d12s.',
        },
        {
          id: 'barbarian-retaliation',
          name: 'Retaliação',
          economy: 'reaction',
          classSlug: 'barbarian',
          subclassSlug: 'berserker',
          minLevel: 10,
          tableAction: 'retaliation',
          itemSlug: null,
          featSlug: null,
          description: 'Reação: ataque corpo a corpo.',
        },
        {
          id: 'gh-shape-recover',
          name: 'Restaurar Forma do Selvagem',
          economy: 'free',
          classSlug: 'barbarian',
          subclassSlug: 'pathofthe-primal-spirit',
          minLevel: 14,
          resourceSlug: 'rage',
          alwaysSpendsResource: true,
          tableAction: 'shape-of-the-wild-rage-recover',
          itemSlug: null,
          featSlug: null,
          description: 'Gaste Fúria.',
        },
      ],
    },
  });
  const syncCompanion = { execute: jest.fn().mockResolvedValue(undefined) };
  const dataSource = { query: jest.fn() };
  const effectCatalog = {
    load: jest.fn().mockResolvedValue([]),
  };
  let handler: BarbarianActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    effectCatalog.load.mockResolvedValue([]);
    ctx.state.martial.toggleRage.mockImplementation(async (_c, active) => ({
      ...ctx.stateResponse,
      rageActive: active ?? true,
    }));
    handler = new BarbarianActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
      asHandlerDep(syncCompanion),
      asHandlerDep(dataSource),
    );
  });

  it('rejects non-barbarian', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      classSlug: 'fighter',
    });
    await expect(
      handler.useTableAction('user-1', 'barb-1', { actionSlug: 'toggle-rage' }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('toggles rage via toggle_combat_flag effect', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      {
        kind: 'toggle_combat_flag',
        trigger: 'on_table_action',
        actionSlug: 'toggle-rage',
        combatFlag: {
          flag: 'rage',
          spendOnEnter: true,
          forceEnter: false,
        },
        note: null,
      },
    ]);

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'toggle-rage',
    });

    expect(ctx.state.martial.toggleRage).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      true,
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
    effectCatalog.load.mockResolvedValueOnce([
      {
        kind: 'toggle_combat_flag',
        trigger: 'on_table_action',
        actionSlug: 'toggle-rage',
        combatFlag: {
          flag: 'rage',
          spendOnEnter: true,
          forceEnter: false,
        },
        note: null,
      },
      {
        kind: 'temp_hp',
        trigger: 'on_table_action',
        actionSlug: 'toggle-rage',
        numeric: { amountFormula: 'level', flat: null },
        note: null,
      },
    ]);

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'toggle-rage',
    });

    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      expect.objectContaining({ tempHp: 5 }),
    );
    expect(result.note).toContain('PV temporários');
  });

  it('resolves Frenzy via table_roll', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      {
        kind: 'table_roll',
        trigger: 'on_table_action',
        actionSlug: 'frenzy',
        numeric: { amountFormula: 'rage_bonus_d6', flat: null },
        note: {
          note: 'Frenesi: +{total} ({expression})',
        },
      },
    ]);

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'frenzy',
    });

    expect(result.expression).toMatch(/d6/);
    expect(result.total).toBeGreaterThan(0);
    expect(result.note).toContain('Frenesi');
  });

  it('resolves Champion of the Gods with diceCount', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'zealot',
      level: 6,
    });
    effectCatalog.load.mockResolvedValueOnce([
      {
        kind: 'heal_from_dice_pool',
        trigger: 'on_table_action',
        actionSlug: 'champion-of-the-gods',
        resourceSlug: 'divine-fury-dice',
        dice: { die: '1d12', dieAtLevel: null, atLevel: null, damageTypeSlug: null },
        note: {
          note: 'Campeão: {total} ({expression})',
        },
      },
    ]);

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'champion-of-the-gods',
      diceCount: 2,
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      'divine-fury-dice',
      2,
    );
    expect(result.expression).toMatch(/2d12/);
    expect(result.total).toBeGreaterThan(0);
  });

  it('routes note-only retaliation via declared economy', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'berserker',
      level: 10,
    });

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'retaliation',
    });

    expect(result.actionName).toBe('Retaliação');
    expect(result.resourceSpent).toBe(false);
  });

  it('recovers Shape of the Wild by spending Rage', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'pathofthe-primal-spirit',
      level: 14,
    });
    effectCatalog.load.mockResolvedValueOnce([
      {
        kind: 'recover_resource',
        trigger: 'on_table_action',
        actionSlug: 'shape-of-the-wild-rage-recover',
        resourceSlug: 'shape-of-the-wild',
        numeric: { amountFormula: 'fixed', flat: 1 },
        note: { note: 'Restaurou Forma do Selvagem gastando 1 uso de Fúria.' },
      },
    ]);

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'shape-of-the-wild-rage-recover',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      'rage',
      1,
    );
    expect(ctx.state.recoverClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      'shape-of-the-wild',
      1,
    );
    expect(result.note).toMatch(/Restaurou Forma do Selvagem/);
  });
});
