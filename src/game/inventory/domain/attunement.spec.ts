import { itemRequiresAttunement, MAX_ATTUNED_ITEMS } from './attunement';

describe('attunement', () => {
  it('limits to 3 attuned items', () => {
    expect(MAX_ATTUNED_ITEMS).toBe(3);
  });

  it('reads requiresAttunement from catalog properties', () => {
    expect(itemRequiresAttunement({ requiresAttunement: true })).toBe(true);
    expect(itemRequiresAttunement({ requiresAttunement: false })).toBe(false);
    expect(itemRequiresAttunement({})).toBe(false);
    expect(itemRequiresAttunement(null)).toBe(false);
  });
});
