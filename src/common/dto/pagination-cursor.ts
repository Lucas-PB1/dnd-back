import { BadRequestException } from '@nestjs/common';
import { SelectQueryBuilder } from 'typeorm';

export type CursorValues = Record<string, string | number>;

export type CursorKeyDef = {
  /** Expressão SQL no QB (ex.: `spell.level`). */
  expr: string;
  /** Nome no payload do cursor (ex.: `level`). */
  name: string;
};

export type CursorPaginatedMeta = {
  limit: number;
  nextCursor: string | null;
  hasMore: boolean;
};

export function normalizeLimit(limit = 20): number {
  return Math.min(100, Math.max(1, limit ?? 20));
}

export function encodeCursor(values: CursorValues): string {
  return Buffer.from(JSON.stringify(values), 'utf8').toString('base64url');
}

export function decodeCursor(
  cursor: string,
  expectedKeys: readonly string[],
): CursorValues {
  try {
    const raw = Buffer.from(cursor, 'base64url').toString('utf8');
    const parsed = JSON.parse(raw) as unknown;
    if (!parsed || typeof parsed !== 'object' || Array.isArray(parsed)) {
      throw new Error('invalid shape');
    }
    const values = parsed as CursorValues;
    for (const key of expectedKeys) {
      if (values[key] === undefined || values[key] === null) {
        throw new Error(`missing ${key}`);
      }
    }
    return values;
  } catch {
    throw new BadRequestException('Invalid cursor');
  }
}

/** WHERE composto ASC: (a > ?) OR (a = ? AND b > ?) OR … */
export function applyAscendingCursor(
  qb: SelectQueryBuilder<object>,
  cursor: CursorValues | null,
  keys: readonly CursorKeyDef[],
): void {
  if (!cursor || keys.length === 0) return;

  const parts: string[] = [];
  const params: Record<string, string | number> = {};

  for (let i = 0; i < keys.length; i++) {
    const eqs = keys
      .slice(0, i)
      .map((key, j) => `${key.expr} = :cur_${j}`)
      .join(' AND ');
    const gt = `${keys[i].expr} > :cur_${i}`;
    parts.push(eqs ? `(${eqs} AND ${gt})` : `(${gt})`);
    params[`cur_${i}`] = cursor[keys[i].name];
  }

  qb.andWhere(`(${parts.join(' OR ')})`, params);
}

/**
 * Paginação por cursor (1 query, sem COUNT/OFFSET).
 * `orderBy` do QB deve bater com `keys` (ASC).
 */
export async function paginateQbCursor<T extends object>(
  qb: SelectQueryBuilder<T>,
  options: {
    limit?: number;
    cursor?: string;
    keys: readonly CursorKeyDef[];
    encodeRow: (row: T) => CursorValues;
  },
): Promise<{ rows: T[]; meta: CursorPaginatedMeta }> {
  const limit = normalizeLimit(options.limit);
  const keyNames = options.keys.map((key) => key.name);
  const decoded = options.cursor
    ? decodeCursor(options.cursor, keyNames)
    : null;

  applyAscendingCursor(
    qb as unknown as SelectQueryBuilder<object>,
    decoded,
    options.keys,
  );

  const fetched = await qb.take(limit + 1).getMany();
  const hasMore = fetched.length > limit;
  const rows = hasMore ? fetched.slice(0, limit) : fetched;
  const last = rows[rows.length - 1];

  return {
    rows,
    meta: {
      limit,
      hasMore,
      nextCursor:
        hasMore && last ? encodeCursor(options.encodeRow(last)) : null,
    },
  };
}

/** Cursor sobre lista já ordenada (catálogo pequeno / nested). */
export function paginateCursor<T>(
  items: T[],
  options: {
    limit?: number;
    cursor?: string;
    keyNames: readonly string[];
    encodeRow: (row: T) => CursorValues;
    isAfter: (row: T, cursor: CursorValues) => boolean;
  },
): { data: T[]; meta: CursorPaginatedMeta } {
  const limit = normalizeLimit(options.limit);
  const decoded = options.cursor
    ? decodeCursor(options.cursor, options.keyNames)
    : null;

  const filtered = decoded
    ? items.filter((row) => options.isAfter(row, decoded))
    : items;
  const hasMore = filtered.length > limit;
  const data = hasMore ? filtered.slice(0, limit) : filtered;
  const last = data[data.length - 1];

  return {
    data,
    meta: {
      limit,
      hasMore,
      nextCursor:
        hasMore && last ? encodeCursor(options.encodeRow(last)) : null,
    },
  };
}

/** Compara tuplas ASC (valores na mesma ordem de keyNames). */
export function isAfterTuple(
  rowValues: Array<string | number>,
  cursor: CursorValues,
  keyNames: readonly string[],
): boolean {
  for (let i = 0; i < keyNames.length; i++) {
    const a = rowValues[i];
    const b = cursor[keyNames[i]];
    if (a > b) return true;
    if (a < b) return false;
  }
  return false;
}
