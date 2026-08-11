import {
  bardingSlugForArmor,
  parseBardingBaseArmorSlug,
  scaleCostGpText,
  scaleWeightText,
} from './barding';

describe('barding', () => {
  it('parses and builds slugs', () => {
    expect(parseBardingBaseArmorSlug('barding-plate')).toBe('plate');
    expect(parseBardingBaseArmorSlug('plate')).toBeNull();
    expect(bardingSlugForArmor('leather')).toBe('barding-leather');
  });

  it('scales cost and weight', () => {
    expect(scaleCostGpText('5 PO', 4)).toBe('20 PO');
    expect(scaleCostGpText('1.500 PO', 4)).toBe('6.000 PO');
    expect(scaleWeightText('6,5 kg', 2)).toBe('13 kg');
    expect(scaleWeightText('4 kg', 2)).toBe('8 kg');
  });
});
