import { UseClassResourceHandler } from './use-class-resource.handler';
import { asDep } from '@common/testing/as-dep';

describe('UseClassResourceHandler', () => {
  const stateResponse = {
    classResources: [],
    tempHp: 0,
    conditions: [] as string[],
    deathSaveSuccesses: 0,
    deathSaveFailures: 0,
    hitPointsCurrent: 10,
  };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn(),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    applyCurrentHitPoints: jest.fn(),
    patch: jest.fn().mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
      conditions: dto.conditions ?? stateResponse.conditions,
      tempHp: dto.tempHp ?? stateResponse.tempHp,
      hitPointsCurrent:
        dto.hitPointsCurrent ?? stateResponse.hitPointsCurrent,
    })),
  };
  const effectCatalog = {
    load: jest.fn().mockResolvedValue([]),
  };
  const dataSource = {
    query: jest.fn().mockImplementation(async (_sql: string, params?: unknown[]) => {
      const slug = Array.isArray(params) ? String(params[0] ?? '') : '';
      if (slug === 'doom-delayed') {
        return [{ note: 'Ruína Adiada: estável a 0 PV (1/DL).' }];
      }
      if (slug === 'last-act-of-fate') {
        return [
          {
            note: 'Último Ato: 1 PV, condições limpas. Neste turno: imunidade + vantagem + dano +nível. Após o turno: morte permanente (mesa). Fim Glorioso: aliados testemunhas — vantagem em d20 por 24h.',
          },
        ];
      }
      return [];
    }),
  };
  const handler = new UseClassResourceHandler(
    asDep(access),
    asDep(state),
    asDep(effectCatalog),
    asDep(dataSource),
  );

  beforeEach(() => {
    jest.clearAllMocks();
    state.useClassResource.mockResolvedValue({
      state: stateResponse,
      roll: null,
    });
    state.buildResponse.mockResolvedValue(stateResponse);
    state.applyCurrentHitPoints.mockImplementation(async (_c, hp) => ({
      ...stateResponse,
      hitPointsCurrent: hp,
      conditions: [],
    }));
  });

  it('applies orc Adrenaline Surge temp HP after spend', async () => {
    access.findAccessibleOrFail.mockResolvedValue({
      id: 'pc-1',
      speciesSlug: 'orc',
      level: 5,
    });
    effectCatalog.load.mockResolvedValue([
      {
        kind: 'temp_hp',
        resourceSlug: 'adrenalineSurge',
        trigger: 'on_resource_spend',
        numeric: { amountFormula: 'proficiency_bonus', flat: null },
        note: { note: 'Pico de Adrenalina: PV temp. (PB) aplicados na ficha.' },
        label: 'Pico de Adrenalina',
      },
    ]);

    const result = await handler.execute('user-1', 'pc-1', {
      resourceSlug: 'adrenalineSurge',
      amount: 1,
    });

    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      { tempHp: 3 },
    );
    expect(result.note).toMatch(/Pico de Adrenalina/);
    expect(result.state.tempHp).toBe(3);
  });

  it('applies werekin Força Bestial temp HP after spend', async () => {
    access.findAccessibleOrFail.mockResolvedValue({
      id: 'pc-1',
      speciesSlug: 'werekin',
      level: 5,
    });
    effectCatalog.load.mockResolvedValue([
      {
        kind: 'temp_hp',
        resourceSlug: 'werekin-shift-aspect',
        trigger: 'on_resource_spend',
        numeric: { amountFormula: 'proficiency_bonus_times_2', flat: null },
        note: { note: 'Mudar Aspecto — Força Bestial: PV temp. (2× PB).' },
        label: 'Mudar Aspecto — Força Bestial',
      },
    ]);

    const result = await handler.execute('user-1', 'pc-1', {
      resourceSlug: 'werekin-shift-aspect',
      amount: 1,
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      'werekin-shift-aspect',
      1,
    );
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      { tempHp: 6 },
    );
    expect(result.note).toMatch(/Força Bestial/);
    expect(result.state.tempHp).toBe(6);
  });

  it('applies Fatebound Doom Delayed stable at 0 HP', async () => {
    access.findAccessibleOrFail.mockResolvedValue({
      id: 'pc-1',
      speciesSlug: 'human',
      level: 8,
    });

    const result = await handler.execute('user-1', 'pc-1', {
      resourceSlug: 'doom-delayed',
      amount: 1,
    });

    expect(state.applyCurrentHitPoints).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      0,
    );
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      {
        deathSaveSuccesses: 3,
        deathSaveFailures: 0,
        conditions: ['unconscious'],
      },
    );
    expect(result.note).toMatch(/Ruína Adiada/);
    expect(result.state.deathSaveSuccesses).toBe(3);
    expect(result.state.deathSaveFailures).toBe(0);
  });

  it('applies Fatebound Last Act of Fate at 1 HP', async () => {
    access.findAccessibleOrFail.mockResolvedValue({
      id: 'pc-1',
      speciesSlug: 'human',
      level: 17,
    });

    const result = await handler.execute('user-1', 'pc-1', {
      resourceSlug: 'last-act-of-fate',
      amount: 1,
    });

    expect(state.applyCurrentHitPoints).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      1,
    );
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      {
        deathSaveSuccesses: 0,
        deathSaveFailures: 0,
        conditions: [],
      },
    );
    expect(result.note).toMatch(/Último Ato/);
    expect(result.state.conditions).toEqual([]);
  });

  it('passes through without note for other resources', async () => {
    access.findAccessibleOrFail.mockResolvedValue({
      id: 'pc-1',
      speciesSlug: 'werekin',
      level: 5,
    });

    const result = await handler.execute('user-1', 'pc-1', {
      resourceSlug: 'bardicInspiration',
      amount: 1,
    });

    expect(state.patch).not.toHaveBeenCalled();
    expect(state.applyCurrentHitPoints).not.toHaveBeenCalled();
    expect(result.note).toBeUndefined();
    expect(result.state).toEqual(stateResponse);
  });
});
