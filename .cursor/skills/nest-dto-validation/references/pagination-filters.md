# Paginação e filtros

## Lista paginada

```typescript
@Get()
findAll(@Query('page') page = 1, @Query('limit') limit = 20) {
  return this.service.findAll({ page, limit: Math.min(limit, 100) });
}
```

## Filtro por slug prefix (futuro)

```typescript
@Get()
findAll(@Query('q') q?: string) {
  return this.service.search(q);
}
```

## Query params validados

```typescript
export class PaginationQueryDto {
  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  page?: number = 1;

  @IsOptional()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  @Max(100)
  limit?: number = 20;
}
```

## Detalhe

Sempre por path param `:slug`, não query `?id=`.
