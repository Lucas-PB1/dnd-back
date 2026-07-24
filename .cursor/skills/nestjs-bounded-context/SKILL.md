---
name: nestjs-bounded-context
description: Cria módulos NestJS por bounded context (Catalog, Identity, Game) com layout queries/mapper. Use ao adicionar features, pastas em src/ ou decidir onde colocar código novo.
---

# NestJS — bounded contexts

Doc: [`docs/architecture.md`](../../../docs/architecture.md)

Genérico Nest/DI → skill global `nestjs` (shared-ai).

## Referências

| Situação | Arquivo |
|----------|---------|
| Layout Catalog / Identity / Game | [`module-layout.md`](references/module-layout.md) |
| Dependências entre BC | [`dependency-rules.md`](references/dependency-rules.md) |
| Checklist feature nova | [`new-feature-checklist.md`](references/new-feature-checklist.md) |
| Endpoints GET catálogo | [`read-only-endpoints.md`](references/read-only-endpoints.md) |
| Slugs EN/PT | [`slug-routing.md`](references/slug-routing.md) |
| Response DTOs | [`response-dtos.md`](references/response-dtos.md) |
| Paginação / filtros | [`pagination-filters.md`](references/pagination-filters.md) |

## Onde colocar código novo

| Pergunta | BC | Pasta |
|----------|-----|-------|
| Expõe dado PHB read-only? | Catalog | `src/catalog/<recurso>/` |
| Valida JWT / usuário? | Identity | `src/identity/` |
| Ficha, campanha, inventário? | Game | `src/game/<recurso>/` |

## Workflow

1. Identificar BC → `dependency-rules.md`
2. Catalog: queries + mapper (não service monolítico) → `module-layout.md` + `read-only-endpoints.md`
3. Registrar em `app.module.ts` / módulo pai
4. Checklist → `new-feature-checklist.md`
5. Swagger: `@ApiTags`, `@ApiProperty` — rule `rest-api`
