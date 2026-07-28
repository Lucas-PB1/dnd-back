import { BadRequestException } from '@nestjs/common';
import { assertUnique, requireCatalog } from './assert';

describe('common/assert', () => {
  it('requireCatalog returns value or BadRequest', () => {
    expect(requireCatalog({ a: 1 }, 'missing')).toEqual({ a: 1 });
    expect(() => requireCatalog(null, 'missing')).toThrow(BadRequestException);
    expect(() => requireCatalog(undefined, 'missing')).toThrow(
      BadRequestException,
    );
  });

  it('assertUnique rejects duplicates', () => {
    expect(() => assertUnique(['a', 'b'], 'dup')).not.toThrow();
    expect(() => assertUnique(['a', 'a'], 'dup')).toThrow(BadRequestException);
  });
});
