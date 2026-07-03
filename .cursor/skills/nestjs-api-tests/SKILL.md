---
name: nestjs-api-tests
description: Cria testes unitários e E2E para módulos REST do catálogo PHB. Use ao adicionar *.spec.ts, *.e2e-spec.ts ou configurar coverage Jest.
---

# Testes — API REST

Plano: [`docs/api-plan.md`](../../../docs/api-plan.md#testes-e-coverage)

## Referências

- [`unit-service.md`](references/unit-service.md)
- [`e2e-route.md`](references/e2e-route.md)

## Checklist novo módulo

- [ ] `xxx.service.spec.ts`
- [ ] `xxx.e2e-spec.ts` (lista + slug + 404)
- [ ] DTOs com campos assertados
- [ ] `test:cov` ≥ 80% no service
