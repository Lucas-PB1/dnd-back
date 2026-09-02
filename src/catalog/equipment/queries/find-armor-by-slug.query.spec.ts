import { NotFoundException } from '@nestjs/common';
import { FindArmorBySlugQuery } from './find-armor-by-slug.query';
import { asDep } from '@common/testing/as-dep';

describe('FindArmorBySlugQuery', () => {
  it('maps found armor', async () => {
    const armorRepo = {
      findOne: jest.fn().mockResolvedValue({ itemSlug: 'chain-mail' }),
    };
    const mapper = { toArmorDto: jest.fn().mockReturnValue({ slug: 'chain-mail' }) };
    const query = new FindArmorBySlugQuery(asDep(armorRepo), asDep(mapper));
    await expect(query.execute('chain-mail')).resolves.toEqual({ slug: 'chain-mail' });
  });

  it('throws when missing', async () => {
    const armorRepo = { findOne: jest.fn().mockResolvedValue(null) };
    const query = new FindArmorBySlugQuery(
      asDep(armorRepo),
      asDep({ toArmorDto: jest.fn() }),
    );
    await expect(query.execute('x')).rejects.toThrow(NotFoundException);
  });
});
