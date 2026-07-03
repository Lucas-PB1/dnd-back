---
name: nestjs-swagger
description: Configura e documenta rotas REST com OpenAPI/Swagger no NestJS. Use ao criar controllers, DTOs, @ApiTags, ou configurar /api docs.
---

# Swagger / OpenAPI

Plano: [`docs/api-plan.md`](../../../docs/api-plan.md#swagger-openapi)

## Setup

- `@nestjs/swagger` + `DocumentBuilder` em `main.ts`
- UI: `/api`

## Por controller

- `@ApiTags('catalog-classes')`
- `@ApiOperation({ summary: '...' })`
- `@ApiOkResponse({ type: XxxResponseDto, isArray: true })`
- `@ApiNotFoundResponse()` em `GET :slug`
- `@ApiQuery` para paginação e filtros

## DTOs

```typescript
export class ClassResponseDto {
  @ApiProperty({ example: 'fighter' })
  slug!: string;
}
```

## Fase 5

- `@ApiBearerAuth()` em rotas `game/*` only
- Catálogo permanece sem bearer
