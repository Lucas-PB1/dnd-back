import {
  isDruidClass,
  moonWildShapeTempHp,
  starryFormDice,
} from './features';

describe('druid-features', () => {
  it('identifies druid class correctly', () => {
    expect(isDruidClass('druid')).toBe(true);
    expect(isDruidClass('cleric')).toBe(false);
  });

  it('computes moon wild shape temp hp', () => {
    expect(moonWildShapeTempHp(3)).toBe(9);
    expect(moonWildShapeTempHp(10)).toBe(30);
  });

  it('computes starry form dice', () => {
    expect(starryFormDice(3)).toBe('1d8');
    expect(starryFormDice(10)).toBe('2d8');
  });
});
