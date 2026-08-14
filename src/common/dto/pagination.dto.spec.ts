import {
  applyIlikeSearch,
  decodeCursor,
  encodeCursor,
  normalizeLimit,
  paginateBySlug,
  paginateQbCursor,
} from './pagination.dto';

describe('pagination helpers', () => {
  it('normalizeLimit clamps to 1–100', () => {
    expect(normalizeLimit(0)).toBe(1);
    expect(normalizeLimit(500)).toBe(100);
    expect(normalizeLimit(20)).toBe(20);
  });

  it('encode/decode cursor round-trips', () => {
    const encoded = encodeCursor({ level: 1, slug: 'alarme' });
    expect(decodeCursor(encoded, ['level', 'slug'])).toEqual({
      level: 1,
      slug: 'alarme',
    });
  });

  it('decodeCursor rejects garbage', () => {
    expect(() => decodeCursor('!!!', ['slug'])).toThrow(/Invalid cursor/);
  });

  it('applyIlikeSearch skips blank terms', () => {
    const qb = { andWhere: jest.fn() };
    applyIlikeSearch(qb as never, ['name'], '  ');
    expect(qb.andWhere).not.toHaveBeenCalled();
  });

  it('applyIlikeSearch builds OR ILIKE clause', () => {
    const qb = { andWhere: jest.fn() };
    applyIlikeSearch(qb as never, ['a.name', 'a.slug'], 'sword');
    expect(qb.andWhere).toHaveBeenCalledWith('(a.name ILIKE :q OR a.slug ILIKE :q)', {
      q: '%sword%',
    });
  });

  it('paginateBySlug returns nextCursor when more remain', () => {
    const items = [{ slug: 'a' }, { slug: 'b' }, { slug: 'c' }];
    const first = paginateBySlug(items, undefined, 2);
    expect(first.data.map((row) => row.slug)).toEqual(['a', 'b']);
    expect(first.meta.hasMore).toBe(true);
    expect(first.meta.nextCursor).toBeTruthy();

    const second = paginateBySlug(items, first.meta.nextCursor ?? undefined, 2);
    expect(second.data.map((row) => row.slug)).toEqual(['c']);
    expect(second.meta.hasMore).toBe(false);
    expect(second.meta.nextCursor).toBeNull();
  });

  it('paginateQbCursor takes limit+1 and builds cursor', async () => {
    const rows = [
      { level: 0, slug: 'a' },
      { level: 0, slug: 'b' },
      { level: 1, slug: 'c' },
    ];
    const qb = {
      andWhere: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue(rows.slice(0, 3)),
    };

    const result = await paginateQbCursor(qb as never, {
      limit: 2,
      keys: [
        { expr: 'spell.level', name: 'level' },
        { expr: 'spell.slug', name: 'slug' },
      ],
      encodeRow: (row: { level: number; slug: string }) => ({
        level: row.level,
        slug: row.slug,
      }),
    });

    expect(qb.take).toHaveBeenCalledWith(3);
    expect(result.rows).toHaveLength(2);
    expect(result.meta.hasMore).toBe(true);
    expect(result.meta.nextCursor).toBe(
      encodeCursor({ level: 0, slug: 'b' }),
    );
  });
});
