# Padrões de código — dnd-api

Complementa [`architecture.md`](architecture.md) e as rules `.cursor/rules/file-size.mdc` · `refactor-triggers.mdc`.

## Tamanho

| Faixa | Linhas | Ação |
|-------|--------|------|
| OK | ≤ 150 | Seguir |
| Soft | 151–200 | Extrair ao editar |
| Hard | > 200 | Split antes de crescer |
| Crítico | ≥ 400 | Entrada obrigatória no [code-health-plan](../plans/code-health-plan.md) |

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

| OK duplicar | Não duplicar |
|-------------|--------------|
| Wiring Nest (`@Module`) | Regra de HP / CA / magia |
| Boilerplate de controller fino | Shape de coluna PHB (use view/seed) |
| Tabelas `option_def`/`option_value` por domínio | JOIN de granted spell no TS (use views — ver [`catalog-patterns.md`](catalog-patterns.md)) |

## Legado

- Não expandir caminhos marcados `legacy` / mortos.
- Remover em PR dedicado ou listar no code-health-plan.
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
