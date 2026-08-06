import {
  assertValidPersonaMasks,
  knownPersonaMaskCount,
  maxEquippedPersonaMasks,
  PERSONA_MASK_SLUGS,
} from './college-of-masks';

describe('college-of-masks', () => {
  it('computes max equipped masks by level', () => {
    expect(maxEquippedPersonaMasks(3)).toBe(1);
    expect(maxEquippedPersonaMasks(13)).toBe(1);
    expect(maxEquippedPersonaMasks(14)).toBe(2);
  });

  it('computes known mask count by level', () => {
    expect(knownPersonaMaskCount(3)).toBe(3);
    expect(knownPersonaMaskCount(5)).toBe(3);
    expect(knownPersonaMaskCount(6)).toBe(4);
    expect(knownPersonaMaskCount(13)).toBe(4);
    expect(knownPersonaMaskCount(14)).toBe(5);
  });

  it('accepts valid equipped masks within limit', () => {
    expect(() =>
      assertValidPersonaMasks([PERSONA_MASK_SLUGS[0]], 3),
    ).not.toThrow();
    expect(() =>
      assertValidPersonaMasks(
        [PERSONA_MASK_SLUGS[0], PERSONA_MASK_SLUGS[1]],
        14,
      ),
    ).not.toThrow();
    expect(() => assertValidPersonaMasks([], 3)).not.toThrow();
  });

  it('rejects too many, unknown, or duplicate masks', () => {
    expect(() =>
      assertValidPersonaMasks(
        [PERSONA_MASK_SLUGS[0], PERSONA_MASK_SLUGS[1]],
        3,
      ),
    ).toThrow(/at most 1/);

    expect(() => assertValidPersonaMasks(['not-a-mask'], 14)).toThrow(
      /Unknown persona mask/,
    );

    expect(() =>
      assertValidPersonaMasks(
        [PERSONA_MASK_SLUGS[0], PERSONA_MASK_SLUGS[0]],
        14,
      ),
    ).toThrow(/Duplicate/);
  });
});
