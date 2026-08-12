import {
  applySpeciesResourceSpendSideEffects,
  proficiencyBonusForLevel,
} from './apply-species-resource-spend-side-effects';

describe('applySpeciesResourceSpendSideEffects', () => {
  const stateResponse = { classResources: [], tempHp: 0 };
  const state = {
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    patch: jest.fn().mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    })),
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('computes proficiency by level band', () => {
    expect(proficiencyBonusForLevel(1)).toBe(2);
    expect(proficiencyBonusForLevel(5)).toBe(3);
    expect(proficiencyBonusForLevel(15)).toBe(5);
  });

  it('applies 2× PB temp HP for werekin shift aspect', async () => {
    const character = {
      id: 'pc-1',
      speciesSlug: 'werekin',
      level: 5,
    };
    const result = await applySpeciesResourceSpendSideEffects({
      state: state as never,
      character: character as never,
      resourceSlug: 'werekin-shift-aspect',
      currentState: stateResponse as never,
    });
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pc-1' }),
      { tempHp: 6 },
    );
    expect(result.note).toMatch(/Força Bestial/);
    expect(result.state.tempHp).toBe(6);
  });

  it('ignores other resources', async () => {
    const result = await applySpeciesResourceSpendSideEffects({
      state: state as never,
      character: {
        id: 'pc-1',
        speciesSlug: 'werekin',
        level: 5,
      } as never,
      resourceSlug: 'bearfolk-apex-predator',
      currentState: stateResponse as never,
    });
    expect(state.patch).not.toHaveBeenCalled();
    expect(result.note).toBeNull();
  });
});
