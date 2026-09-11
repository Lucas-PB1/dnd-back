# Testes E2E / smoke

## Pré-requisitos

1. **Postgres com catálogo aplicado** — `DATABASE_URL` no `.env` apontando para um banco com `npm run db:setup` (ou migrate+seed) já rodado.
2. **Auth de teste** — os e2e substituem `SupabaseAuthGuard` por `TestAuthGuard` (`test/helpers/test-auth.guard.ts`); não precisam de JWT real.
3. **Node** — preferir a versão em `package.json` → `engines.node`.

Sem catálogo, os **smokes** costumam **pular** casos (warn no console) em vez de falhar o suite inteiro; os e2e “cheios” (`campaign`, `characters`, `catalog`) esperam dados PHB e falham se o schema estiver vazio.

## Como rodar

```bash
# todos os e2e (runInBand — um DB compartilhado)
npm run test:e2e

# um arquivo
npx jest --config ./test/jest-e2e.config.js --runInBand smoke-feat-economy
npx jest --config ./test/jest-e2e.config.js --runInBand campaign
```

Timeout padrão: 60s (`test/jest-e2e.config.js`).

## Arquivos

| Arquivo | Escopo |
| --- | --- |
| `catalog.e2e-spec.ts` | Catálogo HTTP |
| `characters.e2e-spec.ts` | CRUD ficha |
| `campaign.e2e-spec.ts` | Campanha + encontro MVP |
| `smoke-*.e2e-spec.ts` | Economia feat/item/species — skip se dados ausentes |

Helpers: `test/helpers/` (`TestAuthGuard`, `minimal-character`).
