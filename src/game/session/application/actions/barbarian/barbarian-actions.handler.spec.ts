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
          slug: 'zealous-presence',
          remaining: 1,
          max: 1,
          name: 'Presença Zelosa',
          used: 0,
        },
        {
          slug: 'rage-of-the-gods',
          remaining: 1,
          max: 1,
          name: 'Fúria dos Deuses',
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
          id: 'barbarian-retaliation',
          name: 'Retaliação',
          economy: 'reaction',
          classSlug: 'barbarian',
          subclassSlug: 'berserker',
          minLevel: 10,
          tableAction: 'retaliation',
          itemSlug: null,
          featSlug: null,
          description:
            'Quando sofrer dano de criatura a 1,5 m, Reação para atacar corpo a corpo (arma ou Desarmado).',
        },
        {
          id: 'barbarian-zealous-presence',
          name: 'Presença Zelosa',
          economy: 'bonus',
          classSlug: 'barbarian',
          subclassSlug: 'zealot',
          minLevel: 10,
          resourceSlug: 'zealous-presence',
          alwaysSpendsResource: true,
          tableAction: 'zealous-presence',
          itemSlug: null,
          featSlug: null,
          description:
            'Ação Bônus: até 10 criaturas a 18 m têm Vantagem em ataques e salvaguardas até o início do seu próximo turno. 1×/DL.',
        },
        {
          id: 'barbarian-rage-of-the-gods',
          name: 'Fúria dos Deuses',
          economy: 'free',
          classSlug: 'barbarian',
          subclassSlug: 'zealot',
          minLevel: 14,
          resourceSlug: 'rage-of-the-gods',
          alwaysSpendsResource: true,
          tableAction: 'rage-of-the-gods',
          itemSlug: null,
          featSlug: null,
          description:
            'Ao ativar Fúria, assuma forma divina 1 min: Resistência Necrótico/Psíquico/Radiante; Voo; Reação gasta Fúria para manter aliado com PV = nível.',
        },
        {
          id: 'barbarian-traverse-the-tree',
          name: 'Percorrer a Árvore',
          economy: 'bonus',
          classSlug: 'barbarian',
          subclassSlug: 'world-tree',
          minLevel: 14,
          tableAction: 'traverse-the-tree',
          itemSlug: null,
          featSlug: null,
          description:
            'Ao ativar Fúria ou AB enquanto ativa: teleporte até 18 m. 1×/Fúria: até 45 m e leve até 6 aliados.',
        },
        {
          id: 'barbarian-restore-intimidating-presence',
          name: 'Restaurar Presença Intimidante',
          economy: 'free',
          classSlug: 'barbarian',
          subclassSlug: 'berserker',
          minLevel: 14,
          resourceSlug: 'rage',
          alwaysSpendsResource: true,
          recoverResourceSlug: 'intimidating-presence',
          recoverAmount: 1,
          tableAction: 'restore-intimidating-presence',
          itemSlug: null,
          featSlug: null,
          description:
            'Restaurou Presença Intimidante gastando 1 uso de Fúria.',
        },
        {
          id: 'barbarian-restore-zealous-presence',
          name: 'Restaurar Presença Zelosa',
          economy: 'free',
          classSlug: 'barbarian',
          subclassSlug: 'zealot',
          minLevel: 10,
          resourceSlug: 'rage',
          alwaysSpendsResource: true,
          recoverResourceSlug: 'zealous-presence',
          recoverAmount: 1,
          tableAction: 'restore-zealous-presence',
          itemSlug: null,
          featSlug: null,
          description: 'Restaurou Presença Zelosa gastando 1 uso de Fúria.',
        },
        {
          id: 'gh-barbarian-shape-of-the-wild-rage-recover',
          name: 'Restaurar Forma do Selvagem',
          economy: 'free',
          classSlug: 'barbarian',
          subclassSlug: 'pathofthe-primal-spirit',
          minLevel: 14,
          resourceSlug: 'rage',
          alwaysSpendsResource: true,
          recoverResourceSlug: 'shape-of-the-wild',
          recoverAmount: 1,
          tableAction: 'shape-of-the-wild-rage-recover',
          itemSlug: null,
          featSlug: null,
          description:
            'Restaurou Forma do Selvagem gastando 1 uso de Fúria.',
        },
      ],
    },
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

  it('uses Shape of the Wild: spends resource and restores companion HP', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'pathofthe-primal-spirit',
      level: 14,
    });
    syncCompanion.execute.mockResolvedValueOnce({
      name: 'Espírito Primal',
      variantLabel: 'Striker · Mar',
      hitPointsCurrent: 40,
      hitPointsMax: 40,
      reused: true,
    });

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'shape-of-the-wild',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      'shape-of-the-wild',
      1,
    );
    expect(syncCompanion.execute).toHaveBeenCalledWith('user-1', 'barb-1', {
      restoreHp: true,
    });
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toMatch(/Forma do Selvagem/);
  });

  it('recovers Shape of the Wild by spending Rage', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'pathofthe-primal-spirit',
      level: 14,
    });

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
    expect(result.note).toContain('Reação');
    expect(ctx.state.useClassResource).not.toHaveBeenCalled();
  });

  it('routes zealous-presence spend via declared economy', async () => {
    ctx.mockCharacterOnce({
      ...barbarian,
      subclassSlug: 'zealot',
      level: 10,
    });

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'zealous-presence',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      'zealous-presence',
      1,
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.actionName).toBe('Presença Zelosa');
  });
});
