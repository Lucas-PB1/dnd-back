import {
  advantageModeFromManual,
  resolveNetAdvantageMode,
} from './resolve-net-advantage-mode';

describe('resolveNetAdvantageMode', () => {
  it('returns normal when no contributions', () => {
    expect(resolveNetAdvantageMode([])).toBe('normal');
  });

  it('returns advantage or disadvantage alone', () => {
    expect(resolveNetAdvantageMode(['advantage'])).toBe('advantage');
    expect(resolveNetAdvantageMode(['disadvantage'])).toBe('disadvantage');
  });

  it('cancels advantage and disadvantage to normal', () => {
    expect(resolveNetAdvantageMode(['advantage', 'disadvantage'])).toBe(
      'normal',
    );
    expect(
      resolveNetAdvantageMode(['advantage', 'advantage', 'disadvantage']),
    ).toBe('normal');
  });

  it('maps manual toggle to contributions', () => {
    expect(advantageModeFromManual('advantage')).toEqual(['advantage']);
    expect(advantageModeFromManual('disadvantage')).toEqual(['disadvantage']);
    expect(advantageModeFromManual('normal')).toEqual([]);
  });
});
