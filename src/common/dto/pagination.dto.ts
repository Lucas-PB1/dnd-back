import { ApiPropertyOptional } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import {
  IsArray,
  IsInt,
  IsOptional,
  IsString,
  Max,
  Min,
} from 'class-validator';
import { SelectQueryBuilder } from 'typeorm';
import { requireNonEmpty } from '../require-found';
import {
  isAfterTuple,
  normalizeLimit,
  paginateCursor,
  type CursorPaginatedMeta,
  type CursorValues,
} from './pagination-cursor';

export {
  applyAscendingCursor,
  decodeCursor,
  encodeCursor,
  isAfterTuple,
  normalizeLimit,
  paginateCursor,
  paginateQbCursor,
  type CursorKeyDef,
  type CursorPaginatedMeta,
  type CursorValues,
} from './pagination-cursor';

export const DEFAULT_PHB_EDITION_SLUG = 'phb-2024-pt';

export function parseEditionSlugsParam(value: unknown): string[] | undefined {
  if (value == null || value === '') return undefined;
  const parts = Array.isArray(value)
    ? value.flatMap((entry) => String(entry).split(','))
    : String(value).split(',');
  const slugs = parts.map((part) => part.trim()).filter(Boolean);
  return slugs.length > 0 ? slugs : undefined;
}

export class PaginationQueryDto {
  @ApiPropertyOptional({
    description: 'Cursor opaco da página anterior (`meta.nextCursor`). Omitir na 1ª página.',
  })
  @IsOptional()
  @IsString()
  cursor?: string;

  @ApiPropertyOptional({ default: 20, minimum: 1, maximum: 100 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  limit?: number = 20;

  @ApiPropertyOptional({
    description:
      'Comma-separated edition slugs (e.g. phb-2024-pt,valdas-spire-2024-en). Omit for all.',
    example: 'phb-2024-pt,valdas-spire-2024-en',
  })
  @IsOptional()
  @Transform(({ value }) => parseEditionSlugsParam(value))
  @IsArray()
  @IsString({ each: true })
  editionSlugs?: string[];
}

export class SearchQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description: 'Case-insensitive text filter',
  })
  @IsOptional()
  @IsString()
  q?: string;
}

export class CategorySearchQueryDto extends SearchQueryDto {
  @ApiPropertyOptional({
    description: 'Category slug filter',
  })
  @IsOptional()
  @IsString()
  category?: string;
}

export class PaginatedMetaDto implements CursorPaginatedMeta {
  @ApiPropertyOptional()
  limit!: number;

  @ApiPropertyOptional({ nullable: true })
  nextCursor!: string | null;

  @ApiPropertyOptional()
  hasMore!: boolean;
}

export class PaginatedResponseDto<T> {
  data!: T[];
  meta!: PaginatedMetaDto;
}

export function applyIlikeSearch<T extends object>(
  qb: SelectQueryBuilder<T>,
  columns: string[],
  q?: string,
): void {
  const term = q?.trim();
  if (!term || columns.length === 0) return;
  const clause = columns.map((col) => `${col} ILIKE :q`).join(' OR ');
  qb.andWhere(`(${clause})`, { q: `%${term}%` });
}

export function applyEditionSlugFilter<T extends object>(
  qb: SelectQueryBuilder<T>,
  columnExpr: string,
  editionSlugs?: string[],
): void {
  const slugs = editionSlugs?.map((slug) => slug.trim()).filter(Boolean);
  if (!slugs?.length) return;
  qb.andWhere(`${columnExpr} IN (:...editionSlugs)`, { editionSlugs: slugs });
}

export function filterRowsByEditionSlug<T extends { editionSlug?: string | null }>(
  rows: T[],
  editionSlugs?: string[],
): T[] {
  const slugs = editionSlugs?.map((slug) => slug.trim()).filter(Boolean);
  if (!slugs?.length) return rows;
  const allowed = new Set(slugs);
  return rows.filter((row) => {
    const edition = row.editionSlug ?? DEFAULT_PHB_EDITION_SLUG;
    return allowed.has(edition);
  });
}

export function paginateBySlug<T extends { slug: string }>(
  items: T[],
  cursor?: string,
  limit?: number,
): PaginatedResponseDto<T> {
  const keyNames = ['slug'] as const;
  return paginateCursor(items, {
    cursor,
    limit,
    keyNames,
    encodeRow: (row) => ({ slug: row.slug }),
    isAfter: (row, cur) => isAfterTuple([row.slug], cur, keyNames),
  });
}

export function paginateByKeys<T>(
  items: T[],
  options: {
    cursor?: string;
    limit?: number;
    keyNames: readonly string[];
    encodeRow: (row: T) => CursorValues;
  },
): PaginatedResponseDto<T> {
  return paginateCursor(items, {
    ...options,
    isAfter: (row, cur) => {
      const values = options.keyNames.map((name) => options.encodeRow(row)[name]);
      return isAfterTuple(values, cur, options.keyNames);
    },
  });
}

export function paginateOrNotFound<TRow, TDto extends { slug: string }>(
  rows: TRow[],
  mapFn: (row: TRow) => TDto,
  cursor: string | undefined,
  limit: number | undefined,
  emptyMessage: string,
): PaginatedResponseDto<TDto> {
  requireNonEmpty(rows, emptyMessage);
  return paginateBySlug(rows.map(mapFn), cursor, limit);
}
