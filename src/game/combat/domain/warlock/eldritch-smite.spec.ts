import {
  canUseEldritchSmite,
  eldritchSmiteDice,
  ELDRITCH_SMITE_INVOCATION_SLUG,
} from './eldritch-smite';

describe('eldritchSmiteDice', () => {
  it('scales 1d8 per pact slot level', () => {
    expect(eldritchSmiteDice(1)).toBe('1d8');
    expect(eldritchSmiteDice(3)).toBe('3d8');
    expect(eldritchSmiteDice(5)).toBe('5d8');
  });

  it('floors below 1 to 1d8', () => {
    expect(eldritchSmiteDice(0)).toBe('1d8');
  });
});

describe('canUseEldritchSmite', () => {
  it('requires warlock 5+ with the invocation', () => {
    expect(
      canUseEldritchSmite({
        classSlug: 'warlock',
        level: 5,
        invocationSlugs: [ELDRITCH_SMITE_INVOCATION_SLUG],
      }),
    ).toBe(true);
    expect(
      canUseEldritchSmite({
        classSlug: 'warlock',
        level: 4,
        invocationSlugs: [ELDRITCH_SMITE_INVOCATION_SLUG],
      }),
    ).toBe(false);
    expect(
      canUseEldritchSmite({
        classSlug: 'warlock',
        level: 5,
        invocationSlugs: [],
      }),
    ).toBe(false);
    expect(
      canUseEldritchSmite({
        classSlug: 'paladin',
        level: 5,
        invocationSlugs: [ELDRITCH_SMITE_INVOCATION_SLUG],
      }),
    ).toBe(false);
  });
});
