import { NotFoundException } from '@nestjs/common';
import { requireFound, requireNonEmpty } from './require-found';

describe('common/require-found', () => {
  it('requireFound returns value or NotFound', () => {
    expect(requireFound('ok', 'missing')).toBe('ok');
    expect(() => requireFound(null, 'missing')).toThrow(NotFoundException);
    expect(() => requireFound(undefined, 'missing')).toThrow(NotFoundException);
  });

  it('requireNonEmpty rejects empty arrays', () => {
    expect(requireNonEmpty([1], 'empty')).toEqual([1]);
    expect(() => requireNonEmpty([], 'empty')).toThrow(NotFoundException);
  });
});
