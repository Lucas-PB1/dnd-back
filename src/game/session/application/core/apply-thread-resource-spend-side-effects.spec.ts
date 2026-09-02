import {
  applyThreadResourceSpendSideEffects,
  DOOM_DELAYED_RESOURCE,
} from './apply-thread-resource-spend-side-effects';

describe('applyThreadResourceSpendSideEffects', () => {
  const character = { id: 'pc-1', hitPointsCurrent: 12 } as never;
  const baseState = {
    conditions: [] as string[],
    deathSaveSuccesses: 0,
    deathSaveFailures: 2,
    hitPointsCurrent: 12,
    tempHp: 0,
    classResources: [],
  };

  it('no-ops for other resource slugs', async () => {
    const state = {
      applyCurrentHitPoints: jest.fn(),
      patch: jest.fn(),
    };

    const result = await applyThreadResourceSpendSideEffects({
      state: state as never,
      character,
      resourceSlug: 'jarls-authority',
      currentState: baseState as never,
    });

    expect(state.applyCurrentHitPoints).not.toHaveBeenCalled();
    expect(state.patch).not.toHaveBeenCalled();
    expect(result.note).toBeNull();
    expect(result.state).toBe(baseState);
  });

  it('sets stable at 0 HP for doom-delayed', async () => {
    const afterHp = {
      ...baseState,
      hitPointsCurrent: 0,
      conditions: [],
    };
    const afterPatch = {
      ...afterHp,
      deathSaveSuccesses: 3,
      deathSaveFailures: 0,
      conditions: ['unconscious'],
    };
    const state = {
      applyCurrentHitPoints: jest.fn().mockResolvedValue(afterHp),
      patch: jest.fn().mockResolvedValue(afterPatch),
    };

    const result = await applyThreadResourceSpendSideEffects({
      state: state as never,
      character,
      resourceSlug: DOOM_DELAYED_RESOURCE,
      currentState: baseState as never,
    });

    expect(state.applyCurrentHitPoints).toHaveBeenCalledWith(character, 0);
    expect(state.patch).toHaveBeenCalledWith(character, {
      deathSaveSuccesses: 3,
      deathSaveFailures: 0,
      conditions: ['unconscious'],
    });
    expect(result.note).toMatch(/Ruína Adiada/);
    expect(result.state).toEqual(afterPatch);
  });

  it('does not duplicate unconscious condition', async () => {
    const afterHp = {
      ...baseState,
      hitPointsCurrent: 0,
      conditions: ['unconscious', 'prone'],
    };
    const state = {
      applyCurrentHitPoints: jest.fn().mockResolvedValue(afterHp),
      patch: jest.fn().mockResolvedValue(afterHp),
    };

    await applyThreadResourceSpendSideEffects({
      state: state as never,
      character,
      resourceSlug: DOOM_DELAYED_RESOURCE,
      currentState: baseState as never,
    });

    expect(state.patch).toHaveBeenCalledWith(character, {
      deathSaveSuccesses: 3,
      deathSaveFailures: 0,
      conditions: ['unconscious', 'prone'],
    });
  });
});
