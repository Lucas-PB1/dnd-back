# Code health — auditoria de qualidade

**Data:** 2026-09-01  
**Escopo:** `src/` (runtime Nest), testes, infra documentada, pipeline `scripts/`  
**Skills:** `audit-code-health` · `split-large-module` · `clean-code` · `dry` · `solid`  
**Complementa:** [`code-standards.md`](../architecture/code-standards.md) · [`architecture.md`](../architecture/architecture.md)

Auditoria estática + `npm test` / `npm run test:cov`. Objetivo: inventariar dívida técnica (tamanho, DRY, SOLID, infra) e priorizar PRs.

---

## Veredito

A infra **não está deteriorando de forma sistêmica**. Guardrails explícitos (BC Catalog / Identity / Game, ADR consolidação SQL A→G, limites 150/200 linhas) mantêm ~88% dos arquivos TS dentro da meta. Dívida é **localizada** (mesa por classe, validators com DB, DTOs Swagger, pipeline GH) e documentada no [`backlog.md`](backlog.md).

| Dimensão | Nota | Tendência |
|----------|------|-----------|
| Clean Code | B+ | Estável; ~5% dos arquivos precisam split |
| DRY | A− (SQL) / B (TS) | SQL consolidado; TS fragmentado por fonte de conteúdo |
| SOLID | B | SRP bom no macro; DIP fraco nos validators |
| Infra | A− | Stack sólida; regressão de testes = alerta imediato |
| Deterioração geral | Baixa–média | Crescimento controlado |

---

## Inventário de tamanho (`src/**/*.ts`, excl. specs)

| Faixa | Qtd | % | Ação (rule `file-size`) |
|-------|-----|---|-------------------------|
| OK (≤ 150) | 732 | 87,7% | Seguir |
| Soft (151–200) | 60 | 7,2% | Extrair ao editar |
| Hard (> 200) | 43 | 5,1% | Split antes de crescer |
| Crítico (≥ 400) | 4 | 0,5% | Dívida — split + plano |

**Total:** 835 arquivos TS de produção.

DTOs: 107 arquivos; 8 > 200 linhas; 4 > 300 (exceção Swagger documentada em `code-standards.md`).

Scripts: 138 `.mjs`, ~22,7k linhas; 34 > 200 linhas (pipeline de extração/seeds — critério separado do runtime).

---

## Crítico (≥ 400)

| Arquivo | Linhas | Problema | Split sugerido |
|---------|--------|----------|------------------|
| `game/combat/domain/__fixtures__/mechanical-catalog.fixtures.ts` | 567 | Fixture monolítica | Partir por origem: class / species / feat / heritage |
| `game/combat/domain/warlock/eldritch-invocations.ts` | 481 | Definições + regras + notas | `invocation-definitions.ts` + `invocation-effects.ts` + index |
| `game/session/infrastructure/character-state/resources/class-resources.ts` | 439 | Query DB + fórmulas + mapeamento DTO | `load-class-resource-schedule.ts` + `map-resource-state.ts` |
| `game/session/application/actions/barbarian/subclass-actions.ts` | 414 | 21 handlers num arquivo | Um arquivo por subclasse ou por feature |

---

## Hard (> 200) — clusters

### Mesa / table-actions

7 arquivos `subclass-actions.ts` (barbarian 414, monk 407, bard 338, cleric 312, druid 292, ranger, rogue). Padrão intencional (uma classe = um motivo de mudança), mas arquivos individuais passaram do teto hard. Helpers comuns já extraídos em `session/application/core/`.

### DTOs Swagger

`table-actions-martial.dto.ts` (366), `character-roll.dto.ts` (363), `inventory.dto.ts` (339), `actor.dto.ts` (309). Contrato HTTP estável; difícil manutenção por volume de `@ApiProperty`.

### Combat domain — notas por fonte

Vários `*-combat-notes-data.ts` (Grim Hollow subclass 276, feat 156, …). Padrão correto (data vs aggregator), porém cada nova fonte adiciona arquivo grande.

### Validação de ficha

`character-subclass-option-value.validator.ts` (277), `character-sheet.validator.ts` (230). Orquestrador existe; sub-validators ainda inline.

### Application / infra

`resolve-equipped-weapon-attacks.ts` (377), `load-combat-mechanical-catalog.ts` (274), `catalog/catalog-lookup.service.ts` (266), `update-character.handler.ts` (261).

---

## Clean Code

### Pontos fortes

- Pastas por concern (`sheet/validation/feats/`, `combat/domain/barbarian/`, …)
- Handlers finos; regras D&D em `domain/`
- Docs de arquitetura vivos
- Quase zero `TODO` / `FIXME` / `HACK` em `src/` — dívida nos planos, não espalhada

### Smells recorrentes

| Smell | Onde | Risco |
|-------|------|-------|
| God handlers | `subclass-actions.ts` (barbarian, monk) | Alto ao adicionar features |
| Service locator de catálogo | `CatalogLookupService` (12 repos) | Acoplamento único |
| Validators como services Nest no `domain/` | `sheet/domain/validation/**` | Mistura regra + persistência |
| `BadRequestException` no domain | ~40 arquivos | Acoplamento Nest pragmático |

---

## DRY

| Área | Status |
|------|--------|
| SQL / catálogo | **Bom** — ADR A→G; `option_def/value`, spell grants unificados, views `v_phb_*` ([`catalog-patterns.md`](../architecture/catalog-patterns.md)) |
| Regras D&D em TS | **Parcial** — combat-notes por fonte (PHB, GH, NL, Steinhardt); agregador em `aggregate-class-combat.ts` |
| Table-actions | **OK** — duplicação estrutural por classe; helpers em `core/` |
| Scripts GH | **Atenção** — prosa/overrides PT duplicada entre cap4/cap6 |
| DTOs | **OK** — boilerplate Swagger; shapes distintos não unificar |

**Duplicação problemática:**

- Queries TypeORM dentro de validators (`spell-progression-queries.ts`, `assert-spell-quotas.ts`) — mesma leitura que views/RPC poderiam cobrir
- `class-resources.ts` mistura SQL raw + regras de die label — extrair para `domain/class-resources/`

---

## SOLID (prático)

| Princípio | Avaliação |
|-----------|-----------|
| **S — SRP** | Bom no macro (sheet/combat/spellcasting/session). Fraco no micro (4 críticos, validators gordos) |
| **O — OCP** | Razoável — nova classe = pasta `actions/<class>/`; nova fonte GH = novo `*-combat-notes-data.ts` |
| **I — ISP** | Fraco em `CatalogLookupService` — interface única para todo lookup PHB |
| **D — DIP** | Parcial — **27/212** arquivos de domain importam TypeORM (~13%); **40/212** importam NestJS (~19%, maioria `@Injectable` + exceções) |

Domain puro existe em `combat/domain/*`, `sheet/domain/stats/`, `dice/domain/`. Padrão híbrido consciente nos validators; principal fonte de deterioração futura se crescer sem ports/adapters.

---

## Legado / morto

- Sem código `legacy` / `deprecated` relevante em `src/` (`infernal_legacy` = regra de jogo, não legado técnico)
- Scripts: `@deprecated` pontual em `ghpg-cap5-requirements.mjs` e helpers HTML — migração em curso
- Backlog documenta escopo **adiado** (combate situacional, temp HP, monstros catálogo) — dívida de produto, não corrupção arquitetural

---

## Infraestrutura

Stack estável ([`infrastructure.md`](../architecture/infrastructure.md)): NestJS + TypeORM + Supabase Postgres + Vercel serverless; pooler 6543 prod; `synchronize: false`; JWT JWKS.

| Sinal | Severidade | Nota |
|-------|------------|------|
| Scripts 22k+ linhas | Média | Pipeline cresce mais rápido que runtime |
| Domain + TypeORM | Média | Tendência de acoplamento em novos validators |
| DTOs 300+ linhas | Baixa | Swagger boilerplate |
| Backlog combate situacional | Baixa (escopo) | Documentado em `backlog.md` |

**Não deteriorando:** BC respeitados; consolidação SQL feita; modular monolith Game (11 submódulos); 98,7% dos testes passando.

---

## Testes

Suite sheet: **288/288** passando (2026-09-01). Mocks atualizados para `validateOriginChoices`, `PhbHeritageTrait` e `heritageChoices`.

---

## Próximos PRs (prioridade)

Ver [`backlog.md`](backlog.md) — item **Testes sheet**; splits e DIP quando retomar refatoração.

---

## Como re-executar

```bash
# Inventário de tamanho (PowerShell)
Get-ChildItem -Path src -Recurse -Filter "*.ts" |
  Where-Object { $_.Name -notmatch '\.spec\.ts$' } |
  ForEach-Object { [PSCustomObject]@{ Lines = (Get-Content $_.FullName | Measure-Object -Line).Lines; Path = $_.FullName } } |
  Sort-Object Lines -Descending | Select-Object -First 40

npm test
npm run test:cov
```

Skill Cursor: **`audit-code-health`**. Atualizar este doc após splits relevantes ou quando críticos ≥ 400 mudarem de lista.
