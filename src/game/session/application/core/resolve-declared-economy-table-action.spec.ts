import { BadRequestException } from '@nestjs/common';
import { resolveDeclaredEconomyTableAction } from './resolve-declared-economy-table-action';

describe('resolveDeclaredEconomyTableAction', () => {
  const stateResponse = { classResources: [], tempHp: 0 };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    patch: jest.fn().mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    })),
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
    state.patch.mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    }));
  });

  it('spends spendAmount from economy catalog', async () => {
    const result = await resolveDeclaredEconomyTableAction(
      { state: state as never, mechanicalCatalog: mechanicalCatalog as never },
      blade as never,
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
    const result = await resolveDeclaredEconomyTableAction(
      { state: state as never, mechanicalCatalog: mechanicalCatalog as never },
      osteo as never,
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
    const result = await resolveDeclaredEconomyTableAction(
      { state: state as never, mechanicalCatalog: mechanicalCatalog as never },
      viking as never,
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
    const result = await resolveDeclaredEconomyTableAction(
      { state: state as never, mechanicalCatalog: mechanicalCatalog as never },
      lightning as never,
      'lightning-step',
    );
    expect(state.useClassResource).not.toHaveBeenCalled();
    expect(result.resourceSpent).toBe(false);
    expect(result.note).toContain('Mover');
  });

  it('rejects wrong subclass', async () => {
    await expect(
      resolveDeclaredEconomyTableAction(
        {
          state: state as never,
          mechanicalCatalog: mechanicalCatalog as never,
        },
        { ...blade, subclassSlug: 'soulknife' } as never,
        'erupting-blades',
      ),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
