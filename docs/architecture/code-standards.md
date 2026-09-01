# Padrões de código — dnd-api

Complementa [`architecture.md`](architecture.md) e as rules `.cursor/rules/file-size.mdc` · `refactor-triggers.mdc`.

## Tamanho

| Faixa | Linhas | Ação |
|-------|--------|------|
| OK | ≤ 150 | Seguir |
| Soft | 151–200 | Extrair ao editar |
| Hard | > 200 | Split antes de crescer |
| Crítico | ≥ 400 | Dívida — extrair com `split-large-module` / registrar em plano ativo se persistir |

Exceções: specs densas, seeds/migrations SQL. DTOs Swagger: preferir split > 250.

## Camadas (Game)

```
application/   → orquestra (handlers)
domain/        → regras D&D por concern (core/combat/stats/…)
  validation/  → validators Nest (feats/, class-options/, …)
infrastructure/→ entities, repos, mappers
dto/           → contrato HTTP
```

### `sheet/domain/`

Raiz só com tipos compartilhados. Resto por concern:

| Pasta | Conteúdo |
|-------|----------|
| `character-sheet.types.ts` | Tipos da ficha (raiz) |
| `core/` | Factory + domain service |
| `stats/` | Modificadores, bônus, HP |
| `origin/` | Background/species origin + ability boosts |
| `validation/` | Validators Nest por concern (ver abaixo) |

Read-models de combate e conjuração vivem em `game/combat/` e `game/spellcasting/` (ver [`game-module-structure.md`](game-module-structure.md)).

### `spellcasting/domain/` (módulo Nest próprio)

| Arquivo / pasta | Conteúdo |
|-----------------|----------|
| `granted-spells/` | Collectors, merge, annotate |
| `spellcasting-stats.ts` | CD / ataque mágico |
| `max-spell-level.ts` / `spell-quota.ts` | Limites de magia |

### `sheet/domain/validation/`

Não acumular validators flat. Agrupar:

| Pasta | Conteúdo |
|-------|----------|
| `validation/` | Orquestrador da ficha + create-requirements |
| `validation/background/` | Background |
| `validation/equipment/` | Equipment / languages / ability gen |
| `validation/spells/` | Magias do personagem |
| `validation/feats/` | Feats, options, helpers de feat |
| `validation/class-options/` | Species / subclass / expertise / mastery / fighting styles |

Catalog permanece **thin**: Query + view + mapper.

## SRP / SOLID (prático)

- Um arquivo = um motivo para mudar.
- Domain não conhece HTTP nem repositório concreto.
- Preferir vários arquivos pequenos a um “utilitário” genérico.

## DRY

**Quanto mais DRY, mais qualidade** — rule `dry-quality`; condição obrigatória no [code-health-audit](../plans/code-health-audit.md#condição-dry).

| OK duplicar | Não duplicar |
|-------------|--------------|
| Wiring Nest (`@Module`) | Regra de HP / CA / magia |
| Boilerplate de controller fino | Shape de coluna PHB (use view/seed) |
| Tabelas `option_def`/`option_value` por domínio | JOIN de granted spell no TS (use views — ver [`catalog-patterns.md`](catalog-patterns.md)) |
| Combat notes por fonte de livro | Segundo caminho para o mesmo stat ou slug |

Mesma razão de mudança em 2 lugares → unificar (rule of three). PR com cópia de conhecimento sem SSOT → bloquear no review.

## TypeScript — menos código, mais qualidade

Rule: `typescript-quality`. Skill: `unify-game-stats`.

| Evitar | Preferir |
|--------|----------|
| `any`, `as never`, `as` para silenciar | Tipos honestos; `satisfies`; mocks tipados |
| `undefined` em cascata no domain | Campos obrigatórios; `null` só quando DB exige |
| Magic string (slug, `actionSlug`) | `const` SSOT / union type |
| Magic number (dado, limiar) | Constante no domain |
| Tipo copiado campo a campo | `Omit` / `Pick` da forma base |
| Segunda fórmula de CA/PV/moeda | Import do SSOT (ver skill) |

### SSOT de stats (runtime)

| Stat | Módulo |
|------|--------|
| Mod. atributo | `@game/shared/domain/ability-scores` |
| PV máx. | `sheet/domain/stats/hit-points.calc.ts` |
| PV clamp / % | `shared/domain/combat-vitals.ts` |
| CA equipada | `combat/domain/equipment/armor-class.ts` + `resolve-equipped-armor-class.ts` |
| Moedas | `inventory/domain/coin-purse.ts` |

**Dívida:** `abilityMod` duplicado em 3 arquivos; CA da ficha (`character-derived-stats`) ≠ combate (`resolve-character-combat-slice`).

## Testes

| Testar | Evitar |
|--------|--------|
| Comportamento público (handler, domain puro, contrato HTTP) | Espelhar implementação linha a linha |
| 1 happy + 1 erro por `actionSlug` / branch crítico | 14 specs com o mesmo boilerplate de mock |
| Regras D&D em `domain/` (entrada → saída) | Spec >300 linhas sem table-driven / helpers |
| Smoke de catálogo via scripts/seeds | Query spec que só mocka `findOne` |

Harness compartilhado para mesa: ver [`code-health-audit.md`](../plans/code-health-audit.md) §11. Fixtures: `mechanical-catalog.fixtures.ts`.

## Legado

- Não expandir caminhos marcados `legacy` / mortos.
- Remover em PR dedicado ou listar no roadmap / plano ativo relevante.
- Reexports “compat” só com data de remoção no plano.

## Skills

| Pedido | Skill |
|--------|-------|
| Inventário de dívidas | `audit-code-health` |
| Quebrar arquivo grande | `split-large-module` |
| Nomes / funções / smells | shared-ai `clean-code` |
| Princípios OOP | shared-ai `solid` |
| Duplicação de regra | shared-ai `dry` |

## Docs

Índice: [`docs/README.md`](../README.md). Rule: `docs-hub`.
