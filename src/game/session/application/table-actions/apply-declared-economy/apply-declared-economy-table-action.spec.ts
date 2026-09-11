import { BadRequestException } from '@nestjs/common';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import { applyDeclaredEconomyTableAction } from './apply-declared-economy-table-action';
import type {
  DeclaredEconomyTableActionDeps,
  DeclaredEconomyTableActionOptions,
} from './types';
import { asDep } from '@common/testing/as-dep';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

async function applyTableAction(
  deps: DeclaredEconomyTableActionDeps,
  character: PlayerCharacter,
  actionSlug: string,
  options?: DeclaredEconomyTableActionOptions,
): Promise<TableActionResponseDto> {
  return applyDeclaredEconomyTableAction(
    deps,
    character,
    actionSlug,
    options,
  ) as Promise<TableActionResponseDto>;
}

describe('applyDeclaredEconomyTableAction', () => {
  const stateResponse = { classResources: [], tempHp: 0 };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    patch: jest.fn().mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    })),
    applyCurrentHitPoints: jest
      .fn()
      .mockImplementation(async (character, hitPointsCurrent) => {
        character.hitPointsCurrent = hitPointsCurrent;
        return {
          ...stateResponse,
          hitPointsCurrent,
        };
      }),
  };

  const economyActions = [
    {
      id: 'rogue-blade-erupting',
      name: 'Lâminas Eruptivas',
      economy: 'free' as const,
      classSlug: 'rogue',
      minLevel: 9,
      subclassSlug: 'blade-of-radiance',
      resourceSlug: 'divine-points',
      alwaysSpendsResource: true,
      spendAmount: 2,
      tableAction: 'erupting-blades',
      description: 'Troca Furtivo por linha radiante (2 PD).',
    },
    {
      id: 'wizard-osteo-armor',
      name: 'Armadura de Osso Frágil',
      economy: 'action' as const,
      classSlug: 'wizard',
      minLevel: 3,
      subclassSlug: 'osteomancer',
      resourceSlug: 'brittle-bone-armor',
      alwaysSpendsResource: true,
      tableAction: 'brittle-bone-armor',
      description: 'PV temp. = 2× nível de Mago.',
    },
    {
      id: 'fighter-viking-reprisal',
      name: 'Represália do Saqueador',
      economy: 'reaction' as const,
      classSlug: 'fighter',
      minLevel: 15,
      subclassSlug: 'viking',
      resourceSlug: 'marauders-reprisal',
      alwaysSpendsResource: true,
      tableAction: 'marauders-reprisal',
      description: 'Reação: crítico + PV temp.',
    },
    {
      id: 'barbarian-lightning-step',
      name: 'Passo Relâmpago',
      economy: 'bonus' as const,
      classSlug: 'barbarian',
      minLevel: 3,
      subclassSlug: 'path-of-the-lightning-vessel',
      alwaysSpendsResource: false,
      tableAction: 'lightning-step',
      summary: 'Mover + dano elétrico',
    },
    {
      id: 'wizard-sangromancer-red-renewal',
      name: 'Renovação Rubra',
      economy: 'free' as const,
      classSlug: 'wizard',
      minLevel: 14,
      subclassSlug: 'sangromancer',
      resourceSlug: 'red-renewal',
      alwaysSpendsResource: true,
      tableAction: 'red-renewal',
      description:
        'Após DC: recupera metade do nível em Dados de Vida e Sangromancia.',
    },
    {
      id: 'barbarian-restore-intimidating-presence',
      name: 'Restaurar Presença Intimidante',
      economy: 'free' as const,
      classSlug: 'barbarian',
      minLevel: 14,
      subclassSlug: 'berserker',
      resourceSlug: 'rage',
      alwaysSpendsResource: true,
      tableAction: 'restore-intimidating-presence',
      description:
        'Sem ação: gaste 1 uso de Fúria para restaurar Presença Intimidante.',
    },
    {
      id: 'fighter-second-wind',
      name: 'Recuperar Fôlego',
      economy: 'bonus' as const,
      classSlug: 'fighter',
      minLevel: 1,
      resourceSlug: 'secondWind',
      alwaysSpendsResource: true,
      tableAction: 'second-wind',
      description: 'Cura 1d10 + nível.',
    },
    {
      id: 'fighter-action-surge',
      name: 'Surto de Ação',
      economy: 'action' as const,
      classSlug: 'fighter',
      minLevel: 2,
      resourceSlug: 'actionSurge',
      alwaysSpendsResource: true,
      tableAction: 'action-surge',
      description: 'Ação adicional.',
    },
  ];

  const mechanicalCatalog = {
    load: async () => ({ economyActions }),
  };

  const blade = {
    id: 'rogue-1',
    classSlug: 'rogue',
    subclassSlug: 'blade-of-radiance',
    level: 9,
  };

  const osteo = {
    id: 'wizard-1',
    classSlug: 'wizard',
    subclassSlug: 'osteomancer',
    level: 5,
  };

  beforeEach(() => {
    jest.clearAllMocks();
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.buildResponse.mockResolvedValue(stateResponse);
    state.recoverClassResource.mockResolvedValue(stateResponse);
    state.patch.mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    }));
    state.applyCurrentHitPoints.mockImplementation(
      async (character, hitPointsCurrent) => {
        character.hitPointsCurrent = hitPointsCurrent;
        return {
          ...stateResponse,
          hitPointsCurrent,
        };
      },
    );
  });

  it('spends spendAmount from economy catalog', async () => {
    const result = await applyTableAction(
      { state: asDep(state), mechanicalCatalog: asDep(mechanicalCatalog) },
      asDep(blade),
      'erupting-blades',
    );
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'rogue-1' }),
      'divine-points',
      2,
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.actionName).toBe('Lâminas Eruptivas');
  });

  it('applies temp HP for brittle-bone-armor', async () => {
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        {
          kind: 'temp_hp',
          trigger: 'on_table_action',
          actionSlug: 'brittle-bone-armor',
          numeric: { amountFormula: 'level_times_2', flat: null },
          note: null,
        },
      ]),
    };
    const result = await applyTableAction(
      {
        state: asDep(state),
        mechanicalCatalog: asDep(mechanicalCatalog),
        effectCatalog: asDep(effectCatalog),
      },
      asDep(osteo),
      'brittle-bone-armor',
    );
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'wizard-1' }),
      'brittle-bone-armor',
      1,
    );
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'wizard-1' }),
      { tempHp: 10 },
    );
    expect(result.total).toBe(10);
    expect(result.note).toContain('PV temporários aplicados: 10');
  });

  it('applies temp HP for marauders-reprisal (half level)', async () => {
    const viking = {
      id: 'fighter-1',
      classSlug: 'fighter',
      subclassSlug: 'viking',
      level: 15,
    };
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        {
          kind: 'temp_hp',
          trigger: 'on_table_action',
          actionSlug: 'marauders-reprisal',
          numeric: { amountFormula: 'level_div_2', flat: null },
          note: null,
        },
      ]),
    };
    const result = await applyTableAction(
      {
        state: asDep(state),
        mechanicalCatalog: asDep(mechanicalCatalog),
        effectCatalog: asDep(effectCatalog),
      },
      asDep(viking),
      'marauders-reprisal',
    );
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'fighter-1' }),
      'marauders-reprisal',
      1,
    );
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'fighter-1' }),
      { tempHp: 7 },
    );
    expect(result.total).toBe(7);
    expect(result.note).toContain('PV temporários aplicados: 7');
  });

  it('returns note without spend when pool is absent', async () => {
    const lightning = {
      id: 'barb-1',
      classSlug: 'barbarian',
      subclassSlug: 'path-of-the-lightning-vessel',
      level: 3,
    };
    const result = await applyTableAction(
      { state: asDep(state), mechanicalCatalog: asDep(mechanicalCatalog) },
      asDep(lightning),
      'lightning-step',
    );
    expect(state.useClassResource).not.toHaveBeenCalled();
    expect(result.resourceSpent).toBe(false);
    expect(result.note).toContain('Mover');
  });

  it('rejects wrong subclass', async () => {
    await expect(
      applyDeclaredEconomyTableAction(
        {
          state: asDep(state),
          mechanicalCatalog: asDep(mechanicalCatalog),
        },
        asDep({ ...blade, subclassSlug: 'soulknife' }),
        'erupting-blades',
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('recovers sangromancy dice on red-renewal', async () => {
    const sangro = {
      id: 'wizard-sangro',
      classSlug: 'wizard',
      subclassSlug: 'sangromancer',
      level: 14,
    };
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        {
          kind: 'recover_resource',
          trigger: 'on_table_action',
          actionSlug: 'red-renewal',
          resourceSlug: 'sangromancy-dice',
          numeric: { amountFormula: 'level_div_2', flat: null },
          note: {
            note: 'Recuperados dados de Sangromancia (metade do nível). Recupere também o mesmo número de Dados de Vida gastos.',
          },
        },
      ]),
    };
    const result = await applyTableAction(
      {
        state: asDep(state),
        mechanicalCatalog: asDep(mechanicalCatalog),
        effectCatalog: asDep(effectCatalog),
      },
      asDep(sangro),
      'red-renewal',
    );
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'wizard-sangro' }),
      'red-renewal',
      1,
    );
    expect(state.recoverClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'wizard-sangro' }),
      'sangromancy-dice',
      7,
    );
    expect(result.total).toBe(7);
    expect(result.note).toContain('Sangromancia');
  });

  it('recovers catalog pool via recover_resource effect', async () => {
    const berserker = {
      id: 'barb-restore',
      classSlug: 'barbarian',
      subclassSlug: 'berserker',
      level: 14,
    };
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        {
          kind: 'recover_resource',
          trigger: 'on_table_action',
          actionSlug: 'restore-intimidating-presence',
          resourceSlug: 'intimidating-presence',
          numeric: { amountFormula: 'fixed', flat: 1 },
          note: {
            note: 'Restaurou Presença Intimidante gastando 1 uso de Fúria.',
          },
        },
      ]),
    };
    const result = await applyTableAction(
      {
        state: asDep(state),
        mechanicalCatalog: asDep(mechanicalCatalog),
        effectCatalog: asDep(effectCatalog),
      },
      asDep(berserker),
      'restore-intimidating-presence',
    );
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-restore' }),
      'rage',
      1,
    );
    expect(state.recoverClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-restore' }),
      'intimidating-presence',
      1,
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Presença Intimidante');
  });

  it('applies heal for second-wind (1d10+level)', async () => {
    const fighter = {
      id: 'fighter-sw',
      classSlug: 'fighter',
      subclassSlug: 'champion',
      level: 5,
      hitPointsCurrent: 20,
      hitPointsMax: 50,
    };
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        {
          kind: 'heal',
          trigger: 'on_table_action',
          actionSlug: 'second-wind',
          unlockLevel: 1,
          ownerKind: 'class',
          ownerSlug: 'fighter',
          numeric: { amountFormula: 'dice_1d10_plus_level', flat: null },
          note: null,
        },
        {
          kind: 'table_note',
          trigger: 'on_table_action',
          actionSlug: 'second-wind',
          unlockLevel: 5,
          ownerKind: 'class',
          ownerSlug: 'fighter',
          note: {
            note: 'Ajuste Tático: mova-se até metade do Deslocamento sem provocar AO.',
          },
        },
      ]),
    };
    const result = await applyTableAction(
      {
        state: asDep(state),
        mechanicalCatalog: asDep(mechanicalCatalog),
        effectCatalog: asDep(effectCatalog),
      },
      asDep(fighter),
      'second-wind',
    );
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'fighter-sw' }),
      'secondWind',
      1,
    );
    expect(state.applyCurrentHitPoints).toHaveBeenCalled();
    expect(result.total).toBeGreaterThan(0);
    expect(result.expression).toContain('d10');
    expect(result.note).toContain('Ajuste Tático');
  });

  it('skips subclass table_note when owner does not match', async () => {
    const fighter = {
      id: 'fighter-surge',
      classSlug: 'fighter',
      subclassSlug: 'champion',
      level: 15,
    };
    const effectCatalog = {
      load: jest.fn().mockResolvedValue([
        {
          kind: 'table_note',
          trigger: 'on_table_action',
          actionSlug: 'action-surge',
          unlockLevel: 2,
          ownerKind: 'class',
          ownerSlug: 'fighter',
          note: { note: 'Surto de Ação: ação adicional.' },
        },
        {
          kind: 'table_note',
          trigger: 'on_table_action',
          actionSlug: 'action-surge',
          unlockLevel: 15,
          ownerKind: 'subclass',
          ownerSlug: 'eldritch-knight',
          note: { note: 'Investida Mística: teleporte até 9 m.' },
        },
      ]),
    };
    const result = await applyTableAction(
      {
        state: asDep(state),
        mechanicalCatalog: asDep(mechanicalCatalog),
        effectCatalog: asDep(effectCatalog),
      },
      asDep(fighter),
      'action-surge',
    );
    expect(result.note).toContain('Surto de Ação');
    expect(result.note).not.toContain('Investida Mística');
  });
});
