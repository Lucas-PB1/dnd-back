import { UseClassResourceHandler } from './use-class-resource.handler';

describe('UseClassResourceHandler', () => {
  const stateResponse = { classResources: [], tempHp: 0 };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn(),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    patch: jest.fn().mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
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
    expect(result.note).toBeUndefined();
    expect(result.state).toEqual(stateResponse);
  });
});
