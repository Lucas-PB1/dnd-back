import { isFeatCastingLinkedToAsi } from './linked-casting-feat-options';

describe('isFeatCastingLinkedToAsi', () => {
  it('includes telekinetic and telepathic', () => {
    expect(isFeatCastingLinkedToAsi('telekinetic')).toBe(true);
    expect(isFeatCastingLinkedToAsi('telepathic')).toBe(true);
    expect(isFeatCastingLinkedToAsi('alert')).toBe(false);
  });
});
