---
name: audit-code-health
description: >-
  Audita saúde do código dnd-api — arquivos >150/200 linhas, god modules,
  regras D&D duplicadas, padrões SQL repetidos e legado. Use when the user asks
  for code health audit, refactor inventory, large files, DRY DB, or legacy cleanup.
---

# Audit code health

## Quando usar

Pedido de auditoria, “arquivos grandes”, “domínio gordo”, “DRY no banco”, “legado”.

## Passos

1. Listar `src/**/*.ts` (excluir `*.spec.ts`, `coverage`) ordenado por linhas.
2. Classificar:
   - soft 151–200 · hard >200 · crítico ≥400
3. Por arquivo hard/crítico: 1 frase da responsabilidade + split sugerido.
4. Grep sinais de legado: `legacy`, `deprecated`, `TODO.*remov`, reexports mortos.
5. SQL: clusters repetidos em `database/` (mesmas colunas/FKs em 3+ tabelas sem view) — anotar em `rpg-catalog-model`.
6. Atualizar ou criar seção em [`docs/plans/code-health-plan.md`](../../../docs/plans/code-health-plan.md).

## Output (obrigatório)

```markdown
## Code health — YYYY-MM-DD

### Crítico (≥400)
- path — problema — split sugerido

### Hard (>200)
- …

### Legado / morto
- …

### SQL / DRY
- …

### Próximos PRs (máx 3)
1. …
```

## Não fazer

- Não refatorar tudo na mesma sessão sem plano.
- Não inventar arquivos — só o que o inventário mostrou.

## Referências

- [file-size](../../rules/file-size.mdc) · [refactor-triggers](../../rules/refactor-triggers.mdc)
- [code-standards.md](../../../docs/architecture/code-standards.md)
- [code-health-plan.md](../../../docs/plans/code-health-plan.md)
