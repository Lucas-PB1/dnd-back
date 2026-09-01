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

1. Listar `src/**/*.ts` (excluir `*.spec.ts`) ordenado por linhas.
2. Classificar: soft 151–200 · hard >200 · crítico ≥400.
3. Por arquivo hard/crítico: responsabilidade + split sugerido.
4. Legado: `legacy`, `deprecated`, `TODO.*remov`, reexports mortos, `scripts/_*.mjs` órfãos.
5. Barrels: `index.ts` — padrão único? mega-export de DTO?
6. Pastas leaf com **> 4** arquivos `.ts` de produção (exceções: `entities/views`, validators documentados).
7. Arquitetura: domain + TypeORM/Nest; controllers com N handlers; API agregada.
8. Scripts: mortos, deprecated, fora do `package.json`.
9. Migrations: contagem; squash viável pré-prod; README alinhado.
10. Docs: rules/skills/commands desatualizados vs repo.
11. **DRY** (`dry-quality`): inventariar duplicação de conhecimento; aplicar [Condição DRY](../../../docs/plans/code-health-audit.md#condição-dry) e teto de nota.
12. **TypeScript** (`typescript-quality`): `any`, `as never`, `Omit`, magic strings/numbers.
13. **Unificação stats** (`unify-game-stats`): `abilityModifier` único, CA/PV/moedas — checklist §15.
14. SQL DRY: clusters em `database/` — `rpg-catalog-model` / `catalog-patterns.md`.
15. **Plano de melhoria:** fase ativa + critérios Done — [`code-health-audit.md` § Plano de melhoria](../../../docs/plans/code-health-audit.md#plano-de-melhoria).
16. Atualizar [`code-health-audit.md`](../../../docs/plans/code-health-audit.md) e [`backlog.md`](../../../docs/plans/backlog.md) (checkboxes da fase).

## Output (obrigatório)

```markdown
## Code health — YYYY-MM-DD

### Crítico (≥400)
- path — problema — split sugerido

### Hard (>200)
- …

### Legado / morto
- …

### Testes (excesso / duplicação)
- specs >300 linhas, handler boilerplate, espelho de validator

### DRY (condição + teto de nota)
- gates ativos, rubrica, teto global — ver `dry-quality` + § Condição DRY no plano

### TypeScript (any / never / magic / Omit)
- …

### Centralização stats (unify-game-stats)
- CA, PV, moedas, abilityModifier

### SQL / DRY / anti-padrão DB
- matriz: RPC bundle vs raw SQL vs TypeORM — ver `catalog-patterns`

### Plano de melhoria (fase ativa + próximos 3 PRs)
- fase N — itens Done pendentes — ver § Plano de melhoria
```

## Não fazer

- Não refatorar tudo na mesma sessão sem plano.
- Não inventar arquivos — só o que o inventário mostrou.

## Referências

- [file-size](../../rules/file-size.mdc) · [refactor-triggers](../../rules/refactor-triggers.mdc) · [dry-quality](../../rules/dry-quality.mdc) · [typescript-quality](../../rules/typescript-quality.mdc)
- [code-standards.md](../../../docs/architecture/code-standards.md)
- [catalog-patterns.md](../../../docs/architecture/catalog-patterns.md)
- [unify-game-stats](../unify-game-stats/SKILL.md)
