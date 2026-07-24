# Paginação e filtros

## Lista paginada

`?page=1&limit=20` (max 100). Preferir `PaginationQueryDto` + `class-validator`.

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

## Busca

Filtro `q` (texto) quando o recurso suporte — ver DTOs existentes (`ArmorQueryDto`, etc.).

## Detalhe

Sempre por path param `:slug`, não query `?id=`.
