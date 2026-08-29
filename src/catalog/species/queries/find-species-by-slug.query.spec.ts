import { NotFoundException } from '@nestjs/common';
import { FindSpeciesBySlugQuery } from './find-species-by-slug.query';

describe('FindSpeciesBySlugQuery', () => {
  it('maps found species', async () => {
    const catalogLookup = {
      findPlayableSpeciesOrFail: jest.fn().mockResolvedValue({ slug: 'human' }),
    };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'human' }) };
    const query = new FindSpeciesBySlugQuery(catalogLookup as never, mapper as never);
    await expect(query.execute('human')).resolves.toEqual({ slug: 'human' });
  });

  it('rejects goliath when Northlands is in catalog scope', async () => {
    const catalogLookup = {
      findPlayableSpeciesOrFail: jest.fn(),
    };
    const query = new FindSpeciesBySlugQuery(
      catalogLookup as never,
      { toDto: jest.fn() } as never,
    );
    await expect(
      query.execute('goliath', ['northlands-heroes-2024-en']),
    ).rejects.toBeInstanceOf(NotFoundException);
    expect(catalogLookup.findPlayableSpeciesOrFail).not.toHaveBeenCalled();
  });

  it('allows goliath when only PHB is selected', async () => {
    const catalogLookup = {
      findPlayableSpeciesOrFail: jest.fn().mockResolvedValue({ slug: 'goliath' }),
    };
    const mapper = { toDto: jest.fn().mockReturnValue({ slug: 'goliath' }) };
    const query = new FindSpeciesBySlugQuery(catalogLookup as never, mapper as never);
    await expect(query.execute('goliath', ['phb-2024-pt'])).resolves.toEqual({
      slug: 'goliath',
    });
  });

  it('propagates lookup failure', async () => {
    const catalogLookup = {
      findPlayableSpeciesOrFail: jest.fn().mockRejectedValue(new Error('not found')),
    };
    const query = new FindSpeciesBySlugQuery(
      catalogLookup as never,
      { toDto: jest.fn() } as never,
    );
    await expect(query.execute('x')).rejects.toThrow('not found');
  });
});
