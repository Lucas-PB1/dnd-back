import { classHasFightingStylePick } from './fighting-style-unlock';

describe('fighting-style-unlock', () => {
  it('compares character level to catalog unlock', () => {
    expect(classHasFightingStylePick(1, 1)).toBe(true);
    expect(classHasFightingStylePick(2, 1)).toBe(false);
    expect(classHasFightingStylePick(2, 2)).toBe(true);
    expect(classHasFightingStylePick(null, 20)).toBe(false);
    expect(classHasFightingStylePick(undefined, 1)).toBe(false);
  });
});
