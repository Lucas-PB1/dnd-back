import { FIXTURE_PERSONA_MASK_SLUGS } from '../__fixtures__/mechanical-catalog';
import {
  assertValidPersonaMasks,
  knownPersonaMaskCount,
  maxEquippedPersonaMasks,
} from './college-of-masks';
import { fixtureSchedulesFor } from '../feature-schedule.fixtures';

describe('college-of-masks', () => {
  const maskBands = fixtureSchedulesFor('bard', 'college-of-masks');

  it('computes max equipped masks by level', () => {
    expect(maxEquippedPersonaMasks(3, maskBands)).toBe(1);
    expect(maxEquippedPersonaMasks(13, maskBands)).toBe(1);
    expect(maxEquippedPersonaMasks(14, maskBands)).toBe(2);
  });

  it('computes known mask count by level', () => {
    expect(knownPersonaMaskCount(3, maskBands)).toBe(3);
    expect(knownPersonaMaskCount(5, maskBands)).toBe(3);
    expect(knownPersonaMaskCount(6, maskBands)).toBe(4);
    expect(knownPersonaMaskCount(13, maskBands)).toBe(4);
    expect(knownPersonaMaskCount(14, maskBands)).toBe(5);
  });

  it('accepts valid equipped masks within limit', () => {
    expect(() =>
      assertValidPersonaMasks(
        FIXTURE_PERSONA_MASK_SLUGS,
        [FIXTURE_PERSONA_MASK_SLUGS[0]],
        3,
        maskBands,
      ),
    ).not.toThrow();
    expect(() =>
      assertValidPersonaMasks(
        FIXTURE_PERSONA_MASK_SLUGS,
        [FIXTURE_PERSONA_MASK_SLUGS[0], FIXTURE_PERSONA_MASK_SLUGS[1]],
        14,
        maskBands,
      ),
    ).not.toThrow();
    expect(() =>
      assertValidPersonaMasks(FIXTURE_PERSONA_MASK_SLUGS, [], 3, maskBands),
    ).not.toThrow();
  });

  it('rejects too many, unknown, or duplicate masks', () => {
    expect(() =>
      assertValidPersonaMasks(
        FIXTURE_PERSONA_MASK_SLUGS,
        [FIXTURE_PERSONA_MASK_SLUGS[0], FIXTURE_PERSONA_MASK_SLUGS[1]],
        3,
        maskBands,
      ),
    ).toThrow(/at most 1/);

    expect(() =>
      assertValidPersonaMasks(
        FIXTURE_PERSONA_MASK_SLUGS,
        ['not-a-mask'],
        14,
        maskBands,
      ),
    ).toThrow(/Unknown persona mask/);

    expect(() =>
      assertValidPersonaMasks(
        FIXTURE_PERSONA_MASK_SLUGS,
        [FIXTURE_PERSONA_MASK_SLUGS[0], FIXTURE_PERSONA_MASK_SLUGS[0]],
        14,
        maskBands,
      ),
    ).toThrow(/Duplicate/);
  });
});
