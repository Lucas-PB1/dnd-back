import { UseClassResourceHandler } from './use-class-resource.handler';

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
  const handler = new UseClassResourceHandler(
    access as never,
    state as never,
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

  it('applies werekin Força Bestial temp HP after spend', async () => {
    access.findAccessibleOrFail.mockResolvedValue({
      id: 'pc-1',
      speciesSlug: 'werekin',
      level: 5,
    });

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
