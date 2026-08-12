import {
  assertNotClassGrantedCatalogItem,
  isClassGrantedCatalogItem,
} from './class-granted-catalog-item';

describe('class-granted-catalog-item', () => {
  it('detects subclass-granted items', () => {
    expect(
      isClassGrantedCatalogItem({ grantedBySubclass: 'soulknife' }),
    ).toBe(true);
  });

  it('detects class-granted items', () => {
    expect(isClassGrantedCatalogItem({ grantedByClass: 'monk' })).toBe(true);
  });

  it('ignores regular catalog items', () => {
    expect(isClassGrantedCatalogItem({ magic: true })).toBe(false);
    expect(isClassGrantedCatalogItem(null)).toBe(false);
  });

  it('blocks inventory/purchase for class-granted items', () => {
    expect(() =>
      assertNotClassGrantedCatalogItem('psychic-blade', {
        grantedBySubclass: 'soulknife',
      }),
    ).toThrow(/cannot be purchased or stored/i);
  });
});
