import { ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsInt, IsOptional, IsString, Max, Min } from 'class-validator';
import { SelectQueryBuilder } from 'typeorm';
import { requireNonEmpty } from '../require-found';

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
