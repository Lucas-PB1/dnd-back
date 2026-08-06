import { resolveSizeCategory, sizeCategoryFromChoices } from './creature-size';

describe('resolveSizeCategory', () => {
  it('returns preferred when provided', () => {
    expect(resolveSizeCategory('Grande', 'tiny')).toBe('tiny');
  });

  it('defaults empty/null text to medium', () => {
    expect(resolveSizeCategory(null)).toBe('medium');
    expect(resolveSizeCategory(undefined)).toBe('medium');
    expect(resolveSizeCategory('')).toBe('medium');
    expect(resolveSizeCategory('   ')).toBe('medium');
  });

  it('prefers medium when dual medium/small', () => {
    expect(resolveSizeCategory('Médio ou Pequeno')).toBe('medium');
  });

  it('detects single size keywords', () => {
    expect(resolveSizeCategory('Pequeno')).toBe('small');
    expect(resolveSizeCategory('Minúsculo')).toBe('tiny');
    expect(resolveSizeCategory('Minusculo')).toBe('tiny');
    expect(resolveSizeCategory('Grande')).toBe('large');
    expect(resolveSizeCategory('Médio')).toBe('medium');
    expect(resolveSizeCategory('Medio')).toBe('medium');
  });

  it('falls back to medium for unknown text', () => {
    expect(resolveSizeCategory('Enorme')).toBe('medium');
  });
});

describe('sizeCategoryFromChoices', () => {
  it('returns null when choices missing or without size', () => {
    expect(sizeCategoryFromChoices(undefined)).toBeNull();
    expect(sizeCategoryFromChoices([])).toBeNull();
    expect(
      sizeCategoryFromChoices([{ choiceKind: 'language', choiceSlug: 'common' }]),
    ).toBeNull();
  });

  it.each([
    ['size', 'small', 'small'],
    ['creature_size', 'pequeno', 'small'],
    ['tamanho', 'medium', 'medium'],
    ['size', 'medio', 'medium'],
    ['size', 'médio', 'medium'],
    ['size', 'tiny', 'tiny'],
    ['size', 'minusculo', 'tiny'],
    ['size', 'minúsculo', 'tiny'],
    ['size', 'large', 'large'],
    ['size', 'grande', 'large'],
    ['size', 'unknown', null],
    ['human_size', 'small', 'small'],
    ['tiefling_size', 'medium', 'medium'],
    ['aasimar_size', 'small', 'small'],
  ] as const)(
    'maps %s/%s → %s',
    (kind, slug, expected) => {
      expect(
        sizeCategoryFromChoices([{ choiceKind: kind, choiceSlug: slug }]),
      ).toBe(expected);
    },
  );
});
