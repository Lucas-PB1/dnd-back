---
name: nestjs-api-tests
description: Overlay Jest do dnd-api — *.queries.spec.ts, handlers Game, e2e PHB. Use ao testar catálogo/game (além da skill global jest).
---

# Testes — dnd-api (Jest)

Genérico → skills **shared-ai** `jest` + `testing`. Este repo usa **Jest** (não Vitest).

Plano: [`docs/api-plan.md`](../../../docs/api-plan.md#testes-e-coverage)

## Deltas deste repo

| Área | Arquivos |
|------|----------|
| Catalog unit | `*.queries.spec.ts` — mock `getRepositoryToken` + `execute()` |
| Game unit | `*.application.spec.ts` |
| E2E | `*.e2e-spec.ts` — lista + slug (`fighter`) + 404 |

## Referências locais

- [`unit-queries.md`](references/unit-queries.md)
- [`e2e-route.md`](references/e2e-route.md)

## Checklist

- [ ] Coverage alinhado à rule `api-testing`
- [ ] Slugs de amostra EN para classes (`fighter`)
