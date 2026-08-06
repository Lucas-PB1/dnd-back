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

/** Fallback when species/source_meta omit editionSlug (PHB seeds). */
export const DEFAULT_PHB_EDITION_SLUG = 'phb-2024-pt';

/** Parse `editionSlugs=a,b` or repeated query keys into a string[]. */
export function parseEditionSlugsParam(value: unknown): string[] | undefined {
  if (value == null || value === '') return undefined;
  const parts = Array.isArray(value)
    ? value.flatMap((entry) => String(entry).split(','))
    : String(value).split(',');
  const slugs = parts.map((part) => part.trim()).filter(Boolean);
  return slugs.length > 0 ? slugs : undefined;
}

export class PaginationQueryDto {
  @ApiPropertyOptional({ default: 1, minimum: 1 })
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  page?: number = 1;

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

/** Listagens de catálogo com busca textual `q`. */
export class SearchQueryDto extends PaginationQueryDto {
  @ApiPropertyOptional({
    description: 'Case-insensitive text filter',
  })
  @IsOptional()
  @IsString()
  q?: string;
}

/** Listagens com `q` + filtro `category`. */
export class CategorySearchQueryDto extends SearchQueryDto {
  @ApiPropertyOptional({
    description: 'Category slug filter',
  })
  @IsOptional()
  @IsString()
  category?: string;
}

export class PaginatedMetaDto {
  @ApiPropertyOptional()
  page!: number;

  @ApiPropertyOptional()
  limit!: number;

  @ApiPropertyOptional()
  total!: number;

  @ApiPropertyOptional()
  totalPages!: number;
}

export class PaginatedResponseDto<T> {
  data!: T[];
  meta!: PaginatedMetaDto;
}

export function normalizePagination(page = 1, limit = 20): {
  page: number;
  limit: number;
} {
  return {
    page: Math.max(1, page),
    limit: Math.min(100, Math.max(1, limit)),
  };
}

/** Aplica `OR col ILIKE :q` nas colunas/expressões informadas. */
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

/** Filtra por `editionSlug` (coluna da view ou expressão SQL). */
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

/**
 * Pagina um QueryBuilder (count + page clamp, igual a `paginate` in-memory).
 * Filtros/`orderBy` devem estar aplicados antes.
 */
export async function paginateQb<T extends object>(
  qb: SelectQueryBuilder<T>,
  page = 1,
  limit = 20,
): Promise<{ rows: T[]; meta: PaginatedMetaDto }> {
  const { page: safePage, limit: safeLimit } = normalizePagination(page, limit);
  const total = await qb.getCount();
  const totalPages = Math.max(1, Math.ceil(total / safeLimit) || 1);
  const currentPage = Math.min(safePage, totalPages);
  const rows = await qb
    .skip((currentPage - 1) * safeLimit)
    .take(safeLimit)
    .getMany();

  return {
    rows,
    meta: {
      page: currentPage,
      limit: safeLimit,
      total,
      totalPages,
    },
  };
}

export function paginate<T>(
  items: T[],
  page: number,
  limit: number,
): PaginatedResponseDto<T> {
  const { page: safePage, limit: safeLimit } = normalizePagination(page, limit);
  const total = items.length;
  const totalPages = Math.max(1, Math.ceil(total / safeLimit));
  const currentPage = Math.min(safePage, totalPages);
  const start = (currentPage - 1) * safeLimit;
  return {
    data: items.slice(start, start + safeLimit),
    meta: { page: currentPage, limit: safeLimit, total, totalPages },
  };
}

/** Nested catalog: exige linhas, mapeia e pagina. */
export function paginateOrNotFound<TRow, TDto>(
  rows: TRow[],
  mapFn: (row: TRow) => TDto,
  page: number,
  limit: number,
  emptyMessage: string,
): PaginatedResponseDto<TDto> {
  requireNonEmpty(rows, emptyMessage);
  return paginate(rows.map(mapFn), page, limit);
}
