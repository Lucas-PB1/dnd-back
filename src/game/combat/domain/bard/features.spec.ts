import { isBardClass } from './features';

describe('bard-features', () => {
  it('identifies bard class correctly', () => {
    expect(isBardClass('bard')).toBe(true);
    expect(isBardClass('fighter')).toBe(false);
    expect(isBardClass(null)).toBe(false);
  });
});
