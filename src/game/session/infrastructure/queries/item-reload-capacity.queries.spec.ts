import { parseItemReloadCapacity } from './item-reload-capacity.queries';

describe('item-reload-capacity.queries', () => {
  describe('parseItemReloadCapacity', () => {
    it('returns reload when numeric', () => {
      expect(parseItemReloadCapacity({ reload: 6 })).toBe(6);
    });

    it('returns 0 when missing or invalid', () => {
      expect(parseItemReloadCapacity(null)).toBe(0);
      expect(parseItemReloadCapacity({ reload: '6' })).toBe(0);
    });
  });
});
