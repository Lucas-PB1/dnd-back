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
  validation/  → orquestradores Nest + helpers de regra (feats/, class-options/, …)
infrastructure/→ entities, repos, mappers, queries/ (leitura DB da ficha)
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

**Leitura de catálogo na validação:** funções em `sheet/infrastructure/queries/*.queries.ts` (TypeORM views/entities). Validators **não** usam `dataSource.query`. ADR: [`adr-sheet-validation-layers.md`](adr-sheet-validation-layers.md).

Catalog permanece **thin**: Query + view + mapper.

## Barrels (`index.ts`)

Todo re-export público de pasta → **`index.ts` na raiz da pasta** — nunca `foo.barrel.ts`, `*.fixtures.ts` ou arquivo irmão com o mesmo nome da pasta.

| OK | Evitar |
|----|--------|
| `mechanical-catalog/index.ts` reexporta `gunslinger-maneuvers.fixtures.ts` | `mechanical-catalog.fixtures.ts` ao lado da pasta |
| `barbarian/subclass-actions/index.ts` + arquivos por subclasse | `subclass-actions.ts` + pasta `subclass-actions/` |
| `combat/domain/rogue/index.ts` na borda do módulo | Barrel no meio da árvore só para esconder split |

**Imports externos:** path da pasta (`…/mechanical-catalog`, `…/subclass-actions`). **Imports internos** da pasta: arquivo concreto (`./berserker-actions`), não o próprio `index.ts`.

**DTOs de sessão:** sem mega-barrel. Importar por família — `@game/session/dto/core/…`, `…/fighter/…`, `…/martial/…`, `…/table-actions/…` (nunca `@game/session/dto` sozinho).

Detalhe histórico: [`code-health-audit.md` §2](../plans/code-health-audit.md#2-barrels-indexts--sem-padrão-único).

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
| `any`, `as never`, `as unknown as T`, `as` para silenciar | Tipos honestos; `satisfies`; mocks tipados |
| `undefined` em cascata no domain | Campos obrigatórios; `null` só quando DB exige |
| Magic string (slug, `actionSlug`) | `const` SSOT (`session/domain/resource-slugs.ts`, `warlock/constants.ts`, …) / union type |
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

**Dívida:** ~~`abilityMod`~~ · ~~CA ficha≠combate~~ · ~~harness specs mesa~~ resolvidos (fases 1–2).

## Testes

Política canônica — detalhe histórico: [`code-health-audit.md` §11](../plans/code-health-audit.md#11-testes-além-da-necessidade).

### O que testar

| Testar | Evitar |
|--------|--------|
| Comportamento público (handler, domain puro, contrato HTTP) | Espelhar implementação linha a linha |
| 1 happy + 1 erro por `actionSlug` / branch crítico | Re-testar subfunção privada já coberta pelo fluxo |
| Regras D&D em `domain/` (entrada → saída) | Duplicar matriz inteira em centenas de linhas |
| Integração crítica (load sheet bundle, cast spell) | 14 specs com o mesmo boilerplate de mock |
| Smoke de catálogo via scripts/seeds | Query spec que só mocka `findOne` |

### Tamanho e forma

| Faixa | Linhas | Ação |
|-------|--------|------|
| OK | ≤ 200 | Seguir |
| Soft | 201–300 | Extrair helpers ou `it.each` ao editar |
| Hard | > 300 | Split obrigatório antes de crescer |
| Crítico | ≥ 400 | Dívida — split imediato |

Padrão de split para specs densos:

```
foo.spec.ts              ← orquestra (describe + it.each)
foo.spec.helpers.ts      ← factories, fixtures locais, expect helpers
foo.<concern>.spec.ts    ← matriz table-driven por concern (ex.: class-rules)
```

Domain com matriz de casos → **`it.each(CASES)`** + runner compartilhado (`runWeaponAttackCase`, …), não um `it()` por linha.

### Mesa — table-action handlers

**Obrigatório** em `*-actions.handler.spec.ts`:

- Importar de `session/application/actions/testing/table-action-handler.harness.ts`
- `createTableActionHandlerTestContext()` para setup (`access`, `state`, `domain`, `sheet`, `mechanicalCatalog`)
- `asHandlerDep(mock)` para injetar no construtor — **não** `as never`
- `createTestCharacter({ classSlug, … })` / `mockCharacter(overrides)` para personagem
- Catálogo mecânico: `@game/combat/domain/__fixtures__/mechanical-catalog` (`index.ts`) — não montar arrays inline duplicados

### Domain / application — helpers compartilhados

| Área | Helper / fixture | Uso |
|------|------------------|-----|
| Mesa handlers | `table-action-handler.harness.ts` | 14 specs de classe |
| Catálogo mecânico | `__fixtures__/mechanical-catalog/index.ts` | Manobras, table-actions, persona masks, … |
| Ataques de arma | `weapon-attack.spec.helpers.ts` | `buildMock…`, `expectWeaponAttack`, `CASES` |
| Rolagem de dano | `roll-damage.spec.helpers.ts` | `buildMockAttack`, `asRollDep`, `createRollDamageTestContext` |

Novos specs de combate/dano: copiar o padrão acima antes de inventar setup local.

### Mocks e tipos em specs

| Evitar | Preferir |
|--------|----------|
| `as never` | `asHandlerDep` / `asRollDep` ou `jest.Mocked<Pick<…>>` |
| `Partial` solto sem factory | `createTestCharacter(overrides)` / `buildMockAttack(overrides)` |
| Duplicar `mechanicalCatalog.load` inline | `createEmptyMechanicalCatalogLoad()` + overrides pontuais |
| Spec >300 linhas monolítico | Split + `it.each` |

`as never` em specs legados: zerar ao tocar o arquivo; **proibido** em specs novos (rule `typescript-quality`).

### Nomenclatura

| Sufixo | Conteúdo |
|--------|----------|
| `*.spec.ts` | Casos e asserts |
| `*.spec.helpers.ts` | Factories, runners, `CASES` — sem `describe` |
| `*.class-rules.spec.ts` | Matriz table-driven de regras de classe/subclasse |
| `*.queries.spec.ts` | Mapper/view — smoke, não re-testar SQL do validator |
| `*.application.spec.ts` | Handler/service Nest com mocks |

### Comandos

```bash
npm test                          # suite completa
npm test -- --testPathPattern=foo # módulo tocado
npm run test:cov                  # cobertura (CI)
```

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
