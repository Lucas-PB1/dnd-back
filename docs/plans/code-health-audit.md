# Code health — auditoria de qualidade

**Data:** 2026-09-01 (revisão 4 — plano de melhoria faseado)  
**Escopo:** `src/` · `scripts/` · `database/` · `.cursor/` · `docs/`  
**Skills:** `audit-code-health` · `split-large-module` · `unify-game-stats` · shared-ai `dry`  
**Rules:** `dry-quality` · `typescript-quality`  
**Checklist ativo:** [`backlog.md`](backlog.md) (seção Saúde do código) · **Plano:** [§ Plano de melhoria](#plano-de-melhoria)

**Políticas**

- Plano de feature **concluído = apagado** (só `backlog.md` + docs de arquitetura).
- **Sem legado em prod** — pré-prod: pode apagar, squashar migrations e remover código morto sem compat layer.
- Meta de pasta: **≤ 4 arquivos `.ts` de produção** por pasta leaf (exceções documentadas abaixo).
- **DRY = qualidade** — rule [`dry-quality`](../../.cursor/rules/dry-quality.mdc): quanto mais SSOT, maior a nota; duplicação de conhecimento **limita o teto** do veredito (§ [Condição DRY](#condição-dry)).

---

## Condição DRY

**Princípio:** uma fonte por regra, contrato ou fórmula. Mais DRY → mais qualidade; menos DRY → nota menor.

Rule: [`.cursor/rules/dry-quality.mdc`](../../.cursor/rules/dry-quality.mdc) · Skills: shared-ai `dry` · `unify-game-stats`

### Estado atual (2026-09-01)

| Condição | Ativo? | Efeito na nota |
|----------|--------|----------------|
| CA ficha ≠ combate (2 caminhos) | ~~**Sim**~~ **Não** (fase 1.3) | Teto global **B** liberado |
| `abilityMod` local (3 arquivos) | ~~**Sim**~~ **Não** (2026-09-01) | DRY **≤ B−** → parcialmente liberado |
| Validators com `dataSource.query` (~30) | **Sim** | DRY SQL **B** (catálogo A− puxa média) |
| 133 specs com `as never` | **Sim** | Testes **≤ B−** |
| PV / moedas / SSOT `abilityModifier` | Parcial | Não bloqueia — manter |

**Teto efetivo hoje:** **B+** possível (gate CA liberado). Nota calculada **B−** (2,96).

### Rubrica (dimensão DRY isolada)

| Nota | Quando |
|------|--------|
| A | Zero 2º caminho SSOT; runtime SQL só views/RPC/repository; harness de testes |
| A− | Catálogo SQL unificado; ≤2 cópias TS no backlog |
| B | Helpers/mocks duplicados; stats consistentes entre módulos |
| B− | `as never` em massa; lookup slug duplo (`CatalogLookup` + queries) |
| C+ | SQL cru em validators; fórmula fora de `ability-scores` |
| C | Dois valores para o mesmo stat |

### Gate de PR

PR que **copia** fórmula, SQL de leitura, tipo de DTO ou mock de handler já existente em fixture → exige unificação ou item explícito em [`backlog.md`](backlog.md).

---

## Veredito

| Dimensão | Nota | Principal risco |
|----------|------|-----------------|
| Tamanho (≤200) | B | 45 arquivos >200; 5 críticos ≥400 |
| Clean Code | B+ | God handlers mesa; controllers gordos |
| DRY | A− SQL / B TS | Validators duplicam queries; combat-notes por fonte OK |
| SOLID | B− | DIP fraco: 27 domain + TypeORM, 40 + Nest |
| Arquitetura | B | BC respeitados; drift em validation e API mesa |
| Scripts | C+ | 13 `_*.mjs` órfãos; deprecated não removido |
| Migrations | **A−** | Baseline único + forward-only (`database/baseline/`) |
| Docs agente | B− | `scripts/` sem README; skill de testes ausente |
| **Testes** | **B−** | 45% linhas vs prod; specs espelho; handler boilerplate |
| **DB (consistência)** | **C+** | RPC bundle vs raw SQL vs TypeORM espalhados |
| **Centralização TS** | **B−** | Duplicatas de helper e mocks de teste |
| **TypeScript** | **C+** | 551× `as never` em specs; 4× `any` prod; `Omit` subutilizado |
| **Unificação stats** | **B** | PV/moedas/CA via combat slice; sem 2º caminho na ficha |

**Nota final (média ponderada): B− (2,96 / 4,0)** — ver [§ Nota final](#nota-final).

**Testes:** 289 specs · **26 571** linhas spec vs **58 413** prod (**ratio 0,45**) · 1474 `it()` passando.

### Specs grandes (candidatos a enxugar)

| Arquivo | Linhas | `it()` | Problema |
|---------|--------|--------|----------|
| `weapon-attack.spec.ts` | 608 | ~42 | Matriz de casos repetida; virar table-driven + helpers |
| `roll-damage.spec.ts` | 569 | 14 | Mock de attack duplicado por cenário |
| `cast-spell.spec.ts` | 494 | — | Integração pesada; avaliar e2e único |
| `granted-spells.spec.ts` | 459 | — | Sobreposição com spellcasting slice |
| `inventory-item-ops.spec.ts` | 420 | 21 | Muitos casos de wiring de repo |
| `characters.application.spec.ts` | 344 | 6 | Pouco valor por linha |
| `*-actions.handler.spec.ts` (×14) | ~200–265 cada | 4–15 | **Mesmo boilerplate** access/state/domain/catalog |

### Inventário TS (`src/`, excl. specs) — verificado 2026-09-01

| Smell | Valor medido | Meta |
|-------|--------------|------|
| `any` em prod | **4 arquivos** | 0 em código novo |
| `as never` em prod | **2 arquivos** (`cast-notes`, `cast-eldritch-prelude`) | 0 |
| `as never` em specs | **551 ocorrências / 133 arquivos** | harness tipado |
| `Omit` / `Pick` | **3 arquivos** (subutilizado) | DTOs derivados |
| `abilityMod` local (`Math.floor`) | **0 arquivos** (fase 1.1 ✅) | import `abilityModifier` |
| `dataSource.query` em validators | **~30 arquivos** domain validation | views/RPC |

### Tamanho de arquivos (prod)

| Faixa | Qtd | % |
|-------|-----|---|
| OK (≤ 150) | 734 | 87,6% |
| Soft (151–200) | 59 | 7,0% |
| Hard (> 200) | 45 | 5,4% |
| Crítico (≥ 400) | 5 | 0,6% |

---

## 1. Legado e código depreciado

### Runtime `src/`

- **Nenhum** `@deprecated`, `legacy` técnico ou `TODO remov` relevante.
- `infernal_legacy` = regra D&D (tiefling), não legado de código.

### Scripts (limpar)

| Item | Ação |
|------|------|
| `scripts/lib/ghpg-cap5-requirements.mjs` | **Apagar** — só reexporta `ghpg-cap5-catalog.mjs`; zero imports |
| `ghpg-html-utils.mjs` → `findGhpgCap2Html` | Migrar `extract-ghpg-cap2.mjs` para `findGhpgChapterHtml(2, …)` e **remover** wrapper deprecated |
| `ghpg-html-utils.mjs` → `parseMechanicalFields` antigo (L343) | Verificar callers; remover se morto |
| `scripts/_*.mjs` (13 arquivos) | Auditorias one-off — **mover para `scripts/archive/`** ou apagar após confirmar que não entram em pipeline |

Scripts `_audit-*` citados em planos GH ainda úteis como CLI manual — se mantidos, documentar em `scripts/README.md` (hoje inexistente).

---

## 2. Barrels (`index.ts`) — sem padrão único

40 barrels em `src/`. Padrões misturados:

| Estilo | Exemplo | Problema |
|--------|---------|----------|
| `export *` cego | `barbarian/index.ts` | Reexporta tudo; acoplamento oculto |
| Exports nomeados longos | `rogue/index.ts` | OK — explícito |
| ~~Barrel de DTO gigante~~ | ~~`session/dto/index.ts`~~ | **Removido (4.2)** — imports por família `dto/core|fighter|martial|table-actions` |
| Barrel de ops | `character-state/martial/index.ts` | Mistura tipos + 10 funções de facade |

**Padrão alvo:** barrel = **`index.ts` na pasta** (`combat/domain/rogue/index.ts`, `__fixtures__/mechanical-catalog/index.ts`); imports internos diretos ao arquivo; DTOs importados por path (`./fighter/fighter-session.dto`), não mega-barrel.

---

## 3. Pastas com > 4 arquivos TS

Regra do usuário: leaf com mais de 4 arquivos = smell. Inventário (produção, excl. specs):

| Count | Pasta | Veredito |
|-------|-------|----------|
| 40 | `src/entities/views` | OK — TypeORM views |
| 26 | `src/entities` | OK — entidades |
| 24 | `sheet/domain/validation/class-options` | **Aceito** — padrão documentado em `code-standards.md` |
| 15 | `inventory/application` | **Split** — handlers por concern (attach / purchase / artifact) |
| 14 | `session/application/actions` | **Split** — já tem subpastas por classe; tirar handlers soltos da raiz |
| 13 | `catalog/classes/dto` | OK — DTOs finos por query |
| 11 | `dice/application/rolls/damage` | Monitorar — pipeline já separado |
| 9 | `combat/domain` (raiz) | **Split** — mover `*-combat-notes-data.ts` para `combat/domain/notes/` |
| 7+ | `session/application/actions/{wizard,…}` | OK se ≤4 por subpasta leaf |

**Meta:** ao criar arquivo novo, se a pasta leaf passar de 4 → criar subpasta antes de commitar.

---

## 4. Arquivos ≥ 200 linhas

### Crítico (≥ 400)

| Arquivo | Linhas | Split |
|---------|--------|-------|
| `combat/domain/warlock/eldritch-invocations.ts` | 481 | definitions + effects |
| `session/.../monk/subclass-actions.ts` | 407 | por subclasse |

### Hard — clusters

- **Mesa:** bard 338, cleric 312, druid 292 `subclass-actions.ts`
- **DTOs Swagger:** `character-roll.dto.ts` 371, `table-actions-martial.dto.ts` 366, `inventory.dto.ts` 339
- **Application:** `resolve-equipped-weapon-attacks.ts` 377, `attach-coverage.handler.ts` 312
- **Soft→hard:** `compute-one-attack.ts` 212 — não adicionar regras GH inline

DTOs >250: exceção Swagger em `code-standards.md`, mas preferir split por domínio (damage vs attack vs check).

---

## 5. Clean Code · SOLID · DRY

### Pontos fortes

- BC Catalog / Identity / Game respeitados
- Regras D&D em `combat/domain`, `spellcasting/domain`
- SQL catálogo consolidado (ADR A→G)
- Quase zero TODO/FIXME em `src/`

### Dívida

| Princípio | Evidência |
|-----------|-----------|
| **SRP** | `subclass-actions.ts` (7 classes); `TableActionsController` (14 handlers); `CatalogLookupService` (12 repos) |
| **OCP** | Nova fonte GH = novo `*-combat-notes-data.ts` — OK mas infla pastas |
| **DIP** | 27/213 arquivos `domain/` importam TypeORM; 40/213 importam Nest (`BadRequestException`, `@Injectable` validators) |
| **DRY TS** | ~~`spell-progression-queries.ts`~~ · labels de resource em `class-resources.ts` |
| **DRY SQL** | Bom no catálogo; 239 migrations granulares é duplicação de *processo*, não de schema |

### Domain híbrido — decidido (ADR)

Validators em `sheet/domain/validation/` permanecem como **orquestradores Nest**; leitura de catálogo/DB foi extraída para `sheet/infrastructure/queries/` (Fases 3.4–3.5). **Não** criar `sheet/infrastructure/validation/` espelhando validators.

Decisão completa: [`adr-sheet-validation-layers.md`](../architecture/adr-sheet-validation-layers.md).

---

## 6. Fuga de arquitetura

| Desvio | Onde | Severidade |
|--------|------|------------|
| Domain + TypeORM (SQL cru) | ~~`sheet/domain/validation/**`~~ → **0**; restante: `progression/domain/level-up.service.ts` | Resolvido validators (ADR); level-up backlog |
| Domain + `BadRequestException` | ~40 arquivos domain | Média (pragmático) |
| Catalog gordo | `CatalogLookupService` — 12 entidades num service | Média |
| Combat notes na raiz de `combat/domain/` | GH/NL/Steinhardt `*-data.ts` | Baixa — mover para `notes/` |
| `entities/` no mesmo repo que Game | TypeORM entities compartilhadas | OK no monolith |

---

## 7. API acoplada (backend monolith HTTP)

Sinais de “ficha = mini-backend num request”:

| Sinal | Detalhe |
|-------|---------|
| `GET /characters/:id` | `character.mapper` + combat slice + inventory + spellcasting + threads num DTO enorme (`character-response.dto.ts` 241 linhas) |
| `TableActionsController` | 14 handlers injetados; 15+ rotas `POST …/table-action` no mesmo controller |
| Controllers duplicados em `characters` | `FighterSessionController`, `GunslingerBarbarianSessionController`, `TableActionsController`, `CharacterSessionController` — rotas Nest merge, mas superfície difusa |
| Rotas por classe | `/fighter/table-action`, `/rogue/table-action`, … — contrato estável para front, mas API não é REST resource-oriented |

**Não é urgente pré-prod**, mas documentar: front depende de payload agregado; quebrar em BFF menor seria projeto separado.

### Padrões inconsistentes (mesma coisa, jeitos diferentes)

| Área | Variante A | Variante B |
|------|------------|------------|
| Mesa subclass | `subclass-actions.ts` | sorcerer/wizard: `feature-actions.ts` |
| Leitura | `*Query` + `execute()` | `*Handler` sem sufixo uniforme |
| Table-action | Um POST por classe | Gunslinger + Barbarian partilham handler em controllers distintos |
| Listagens mesa | `GET …/maneuvers` (fighter, gunslinger) | Outras classes só POST |

Unificar **só em PR dedicado** — não misturar com feature.

---

## 8. Scripts

| Métrica | Valor |
|---------|-------|
| Total `.mjs` | 138 |
| > 200 linhas | 34 |
| `_*.mjs` one-off | 13 (não no `package.json`) |
| Deprecated não removido | 2 arquivos / 3 símbolos |

Scripts de geração GH (600–850 linhas) são pipeline de conteúdo — critério separado do runtime, mas candidatos a `scripts/gh/` + README.

---

## 9. Migrations (squash + baseline greenfield) — **concluído 2026-09-02**

| Antes | Depois |
|-------|--------|
| 239 SQL granulares em `database/migrations/` | 1 baseline [`database/baseline/001_full_schema.sql`](../../database/baseline/001_full_schema.sql) (~241 KiB) |
| Runner só `migrations/` | Baseline primeiro, depois forward-only em `database/migrations/` |
| `ALTER TYPE` / `ALTER TABLE` evolutivos | Fundidos nos `CREATE TYPE` / `CREATE TABLE`; RLS/FK `auth` permanecem em `DO $$` |

Runner: `run-migrations.mjs` — versão baseline = `baseline/001_full_schema`. Manutenção: editar baseline (pré-prod) ou adicionar SQL em `database/migrations/`.

**Forward:** novos DDL em `database/migrations/` — ver [`database/migrations/README.md`](../../database/migrations/README.md).

---

## 10. Docs rules · skills · commands

| Artefato | Status |
|----------|--------|
| `.cursor/rules/00-orchestrator.mdc` | OK |
| `.cursor/rules/architecture.mdc` | OK — alinhado com `docs/architecture/` |
| `.cursor/rules/docs-hub.mdc` | OK — política plano apagado |
| `.cursor/rules/api-contract.mdc` | OK |
| `.cursor/skills/audit-code-health` | **Estreito** — só tamanho/legado; expandir com esta checklist |
| `docs/README.md` | OK pós-limpeza Cap. 4 |
| `database/migrations/README.md` | OK (contagens corrigidas) |
| `scripts/` | **Sem README** — comandos só no `package.json` |
| `package.json` scripts | OK — 26 comandos npm documentáveis |
| Política de testes | **Ausente** — adicionar em `code-standards.md` |

---

## 11. Testes além da necessidade

**Política canônica (atualizada):** [`code-standards.md` § Testes](../architecture/code-standards.md#testes).

### Diagnóstico

- **289** arquivos spec para **838** prod (0,34 arquivos spec/arquivo — alto em contagem, não só em linhas).
- Muitos testes **espelham implementação** (validator spec com mock SQL idêntico ao validator) em vez de contrato/comportamento.
- **~14** `*-actions.handler.spec.ts` repetem o mesmo setup (`access`, `state`, `domain`, `mechanicalCatalog.load`) — dívida de manutenção quando o handler ganha dependência.
- Catalog `*.queries.spec.ts`: vários só assertam que o mapper não quebra — valor marginal se a view SQL já tem seed smoke.
- `jest.mock` em **~30** specs de application — OK para unidade, mas sem harness compartilhado vira copy-paste.

### Política alvo (pré-prod)

| Testar | Evitar |
|--------|--------|
| Contrato HTTP / handler público (1 happy + 1 erro por `actionSlug`) | Re-testar cada subfunção privada já coberta pelo fluxo |
| Regras D&D puras (`domain/`, dados → resultado) | Duplicar matriz inteira de `weapon-attack` em 600 linhas — usar `it.each` |
| Integração crítica (load sheet bundle, cast spell) | 14 specs de handler com 80% boilerplate igual |
| Views/catálogo: smoke por seed script | Query spec que só verifica `findOne` mockado |

### Centralizar em testes

1. **`table-action-handler.harness.ts`** — factory `createTableActionHandlerTestContext()` para mesa.
2. **`mechanical-catalog/index.ts`** + arquivos por origem — **obrigar** uso em handler/damage specs (hoje só parcial).
3. **`buildMockWeaponAttack(overrides)`** — para `roll-damage.spec.ts` / `roll-attack.spec.ts`.
4. Revisar specs **>300 linhas** — split ou table-driven; meta: nenhum spec >400.

---

## 12. Funções similares não centralizadas (TS)

| Duplicação | Onde | SSOT sugerido |
|------------|------|----------------|
| Modificador de atributo | ~~`abilityMod()` local~~ | ✅ `@game/shared/domain/ability-scores` (fase 1.1) |
| `hasStyleOrFeat` | ~~duplicado armor + predicates~~ | ✅ `feat/has-style-or-feat.ts` (fase 1.2) |
| Mock catálogo mecânico | Cada `*-actions.handler.spec.ts` monta `mechanicalCatalog.load` | Fixture + helper de teste |
| Table-action deps | `monk-action-deps`, `paladin-action-deps`, `cleric-action-deps` | Estender padrão às classes que ainda inline |
| Slug not-found | `requireFound` (404) vs `requireCatalog` (400) | OK — semântica HTTP distinta; **não** unificar |
| Combat notes por fonte | `grim-hollow-*`, `northlands-*`, `aggregate-class-combat` | OK por fonte; falta subpasta `combat/domain/notes/` |
| Catalog lookup | `find-*-by-slug.query` **e** `CatalogLookupService.find*OrFail` | Dois caminhos para o mesmo slug — escolher um para **escrita de ficha** |

---

## 13. Banco de dados — anti-padrão (mesma coisa, jeitos diferentes)

### Matriz de acesso (SSOT desejado)

| Caso de uso | Padrão canônico | Status |
|-------------|-----------------|--------|
| Catálogo PHB leitura API | `catalog/*/queries` + `@ViewEntity` | ✅ |
| Ficha — filhos + PB + boosts | RPC `get_character_sheet_bundle` | ✅ modelo a seguir |
| Combate — inventário + armadura | RPC `get_character_combat_bundle` | ✅ |
| Player `player_character_*` CRUD | TypeORM repository (`CharacterSheetRepository`) | ✅ |
| Estado de sessão (rage, chambers) | `CharacterStateRepository` + entity | ✅ |
| Validação de ficha (spells, feats, options) | ✅ Sem `dataSource.query` no domain — queries em `sheet/infrastructure/queries/` | Fase **3.4–3.5** ✅ |
| Progressão de magia / slots | ✅ `sheet/infrastructure/queries/spell-progression.queries.ts` | Views `v_*` via TypeORM |
| Recursos de classe (dados, labels) | ✅ `session/infrastructure/queries/class-resource-*.queries.ts` | — |
| Propriedade de item (`reload`) | ✅ `session/infrastructure/queries/item-reload-capacity.queries.ts` | TypeORM `PhbItem` |
| Flags de combate no roll | ✅ `session/infrastructure/queries/character-combat-flags.queries.ts` | TypeORM `PlayerCharacterState` |
| Lookup slug em create/update | `CatalogLookupService` (12 repos) | Duplica queries finas do catalog |

### Por que é problema

- **Sem prod**, cada novo validator inventa SQL em vez de reutilizar view/RPC → drift de colunas e performance imprevisível.
- Ficha já provou o caminho certo (bundle RPC); validação e mesa **não seguiram**.
- `CatalogLookupService` + queries catalog = **duas APIs** para “existe este slug?”.

### Remediação (ordem)

1. Inventariar SQL cru em `sheet/domain/validation/**` → listar views/RPCs faltantes.
2. ~~`spell-progression-queries.ts` → views via TypeORM~~ ✅ Fase 3.1
3. ~~`class-resources.ts` → queries dedicadas em `session/infrastructure/`~~ ✅ Fase 2.5
4. ~~`loadReloadCapacity` / `roll-weapon-context` → `session/infrastructure/queries/`~~ ✅ Fase 3.3
5. Documentar matriz em [`catalog-patterns.md` §10](../architecture/catalog-patterns.md#10-runtime-game-reads) ✅ Fase 3.7

---

## Inventário SQL cru — validators (Fase 3.0)

**0 arquivos prod** em `sheet/domain/validation/` com `dataSource.query`. Remediação concluída nas fases 3.4–3.5:

| Módulo infra | Fase | Consumidores |
|--------------|------|--------------|
| `spell-progression.queries.ts` | 3.1 | spells validator |
| `feat-option.queries.ts` | 3.4 | feats + fighting styles |
| `spell-catalog.queries.ts` | 3.5 | signature/spell-mastery, mystic arcanum, species, subclass spells |
| `background-origin.queries.ts` | 3.5 | background, expertise, extra-skill |
| `skill-catalog.queries.ts` | 3.5 | expertise, extra-skill, subclass option value |
| `metamagic-catalog.queries.ts` | 3.5 | metamagic validator |
| `eldritch-invocation.queries.ts` | 3.5 | eldritch invocations |
| `class-meta.queries.ts` | 3.5 | subclass unlock, weapon mastery progression |
| `class-option.queries.ts` | 3.5 | class/subclass options, weapon mastery piece |

Inventário histórico (pré-migração):

| Pasta / arquivo | Queries | Remediação |
|-----------------|---------|------------|
|-----------------|---------|------------|
| `infrastructure/queries/spell-progression.queries.ts` | 0 | ✅ **3.1** — `v_class_spell_slots`, `v_subclass_spell_slots`, `v_phb_class_progression` |
| `infrastructure/queries/feat-option.queries.ts` | 0 | ✅ **3.4** — `VPhbSpell`, `PhbFightingStyle`, `PhbSkill`/`PhbItem`, `ClassProficienciesQuery` |
| `feats/character-feat-option-value.validator.ts` | 0 | ✅ **3.4** |
| `feats/character-feat-options.validator.ts` | 0 | ✅ **3.4** — injeta `ClassProficienciesQuery` |
| `feats/feat-option-proficiency.ts` | 0 | ✅ **3.4** |
| `class-options/character-subclass-option-value.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-subclass-options.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-weapon-mastery.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-species-choices.validator.ts` | 0 | ✅ **3.5** |
| `background/character-background.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-class-options.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-class-extra-skill.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-class-feature-options.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-eldritch-invocations.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-class-expertise.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-spell-mastery.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-signature-spells.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-mystic-arcanum.validator.ts` | 0 | ✅ **3.5** |
| `class-options/character-metamagic.validator.ts` | 0 | ✅ **3.5** |

**Hotspots runtime fora de validation** (já endereçados ou backlog):

| Arquivo | Status |
|---------|--------|
| `class-resource-*.queries.ts` | ✅ Fase 2.5 |
| `feat-option.queries.ts` | ✅ Fase 3.4 |
| `spell-catalog.queries.ts` | ✅ Fase 3.5 |
| `background-origin.queries.ts` | ✅ Fase 3.5 |
| `skill-catalog.queries.ts` | ✅ Fase 3.5 |
| `class-meta.queries.ts` | ✅ Fase 3.5 |
| `class-option.queries.ts` | ✅ Fase 3.5 |
| `metamagic-catalog.queries.ts` | ✅ Fase 3.5 |
| `eldritch-invocation.queries.ts` | ✅ Fase 3.5 |
| `spell-progression.queries.ts` | ✅ Fase 3.1 |
| `item-reload-capacity.queries.ts` | ✅ Fase 3.3 |
| `character-combat-flags.queries.ts` | ✅ Fase 3.3 |
| `level-up.service.ts`, `sorcerer-actions.handler.ts`, … | Backlog — migrar ao tocar |

---

## 14. TypeScript — `any`, `never`, magic values, tipos

### Inventário (produção `src/`, excl. specs)

| Smell | ~Arquivos prod | Nota |
|-------|----------------|------|
| `any` | **4** | Baixo; manter zero em código novo |
| `as never` | **2** | Proibido em código novo |
| `as never` em **specs** | **133 arquivos / 551 ocorrências** | Principal dívida — mocks sem tipo |
| `undefined` | muitos | Aceitável em bordas HTTP; evitar no domain |
| `Omit` / `Pick` | **3** arquivos | Subutilizado vs DTOs duplicados |

### Anti-padrões

- **`as never` em teste** — atalho para não modelar dependência; quebra quando handler ganha parâmetro.
- **Magic strings** — `actionSlug`, `featSlug`, `choiceKind` repetidos sem `const` (ex.: recursos de classe, table-actions).
- **Magic numbers** — limiares de nível, dados de dano, caps de DEX média espalhados em handlers.
- **Tipagem espalhada** — mesmo shape de `abilityScores` / `featOptions` redeclarado em 10+ validators.
- **Sem `Omit`** — `CharacterResponseDto` vs subsets; variantes de update copiam campos.

### Regras novas

- [`.cursor/rules/typescript-quality.mdc`](../../.cursor/rules/typescript-quality.mdc)
- Skill [`unify-game-stats`](../../.cursor/skills/unify-game-stats/SKILL.md)

---

## 15. Unificação de cálculos (CA, PV, moedas)

Objetivo: **um caminho por stat** — facilita entrada de novos dados (feat, espécie, item) sem N cópias.

### Já unificado (manter)

| Stat | SSOT | Status |
|------|------|--------|
| PV máx. | `calculateHitPointsMax` | ✅ usado por `CharacterDomainService` |
| Moedas | `coin-purse.ts` | ✅ parse, total, `EMPTY_COIN_PURSE` |
| Mod. atributo (oficial) | `ability-scores.ts` | ✅ export via `ability-modifier.ts` |
| PV clamp / % | `combat-vitals.ts` | ✅ pequeno, focado |

### Duplicado / divergente (corrigir)

| Problema | Onde | Ação |
|----------|------|------|
| `abilityMod` local | `armor-class.ts`, `weapon-attack-predicates.ts`, `manikin-armor.ts` | Import `abilityModifier` |
| CA ficha simplificada | ~~`character-derived-stats`~~ | ✅ removido — CA só via `resolveCharacterCombatSlice` (1.3) |
| CA combate | `resolve-equipped-armor-class` + slice | SSOT alvo para **toda** exibição de CA |
| `hasStyleOrFeat` | ~~`armor-class.ts` e `weapon-attack-predicates.ts`~~ | ✅ `feat/has-style-or-feat.ts` (fase 1.2) |
| Ouro starting | `resolve-starting-gold.ts` | OK se só delega `coin-purse` — auditar |

### Padrão para nova fonte de dado

```text
Seed/view (catálogo) → row tipada → função SSOT (CA/PV/moeda) → mapper/DTO
```

Não: handler calcula CA inline “só neste caso”.

### PRs sugeridos

1. **abilityMod sweep** — 3 arquivos, zero comportamento novo
2. **AC unificado** — ficha usa `resolve-equipped-armor-class` quando inventário carregado
3. **`hasStyleOrFeat` compartilhado** — `combat/domain/feat/context-slugs.ts` ou similar
4. **Test utils tipados** — substituir `as never` nos handler specs

---

## Plano de melhoria

**Baseline:** B− (2,96) · teto **B** (gate CA duplicada) · 2026-09-01  
**Objetivo:** **B** → **B+** → **A−** antes de prod, sem bloquear features de mesa.

Regras durante execução: `dry-quality` · `typescript-quality` · skills `unify-game-stats` · `audit-code-health`.

### Metas por fase

| Fase | Foco | Nota alvo | Gates DRY liberados | Esforço |
|------|------|-----------|---------------------|---------|
| **0** | Limpeza + docs | — | — | ½–1 dia |
| **1** | SSOT stats + harness | **B** (≥3,0) | CA unificada · `abilityMod` | 2–4 dias |
| **2** | Testes enxutos + splits críticos | **B+** (≥3,3) | harness adotado · specs <400 | 1–2 sem |
| **3** | DB um jeito por caso | **B+** estável | validators sem SQL cru (meta) | 2–3 sem |
| **4** | Estrutura pré-prod | **A−** (≥3,7) | squash · ADR validators · barrels | decisão |

### Fase 0 — Limpeza (sem comportamento)

**Done quando:** scripts mortos fora do caminho; `scripts/README.md` existe; `npm test` verde.

| # | PR / entrega | Arquivos / ação |
|---|--------------|-----------------|
| 0.1 | Apagar reexport morto | `scripts/lib/ghpg-cap5-requirements.mjs` |
| 0.2 | Remover deprecated GHPG | `findGhpgCap2Html` → `findGhpgChapterHtml(2)`; limpar `ghpg-html-utils.mjs` |
| 0.3 | Arquivar one-offs | `scripts/_*.mjs` (13) → `scripts/archive/` ou apagar |
| 0.4 | README scripts | `scripts/README.md` — comandos do `package.json` + archive |

**Métrica:** Scripts **C+ → B** · Docs agente **B− → B**.

---

### Fase 1 — SSOT stats + base de testes (desbloqueia teto B)

**Done quando:** zero `function abilityMod` em combat; CA da ficha = `resolve-equipped-armor-class` quando inventário carregado; harness mesa criado; `npm test` verde.

| # | PR / entrega | Depende | Skill / rule |
|---|--------------|---------|--------------|
| 1.1 | **abilityMod sweep** | — | `unify-game-stats` |
| | `armor-class.ts`, `weapon-attack-predicates.ts`, `manikin-armor.ts` → `abilityModifier` | | |
| 1.2 | **`hasStyleOrFeat` compartilhado** | 1.1 | `dry-quality` |
| | `combat/domain/feat/context-slugs.ts` (ou similar) | | |
| 1.3 | **CA unificado ficha + combate** | 1.1 | `unify-game-stats` |
| | `character-derived-stats` usa resolver completo quando bundle/inventário disponível | | |
| 1.4 | **`table-action-handler.harness.ts`** | — | `dry-quality` |
| | `createTableActionHandlerTestContext()` tipado | | |
| 1.5 | Remover `as never` prod (2 arquivos) | — | `typescript-quality` |
| | `cast-notes.ts`, `cast-eldritch-prelude.ts` | | |

**Métricas de saída:**

| Indicador | Hoje | Meta fase 1 |
|-----------|------|-------------|
| `abilityMod` local | 3 arquivos | **0** ✅ |
| CA 2 caminhos | Sim | **Não** |
| Gate teto global | B | **Liberado → B+** |
| Unificação stats | C+ | **B** |
| DRY TS | B− | **B** |
| Nota final | 2,96 | **≥ 3,0 (B)** |

**Ordem sugerida de merge:** 1.1 → 1.2 → 1.3 (pode ser um PR se diff pequeno) · 1.4 em paralelo · 1.5 quando tocar spell cast.

---

### Fase 2 — Testes + arquivos críticos ✅

**Done quando:** 14 handler specs usam harness; nenhum spec >400 linhas; 5 arquivos críticos ≥400 splitados ou reduzidos <200.

| # | PR / entrega | Depende |
|---|--------------|---------|
| ~~2.1~~ | Migrar **14 `*-actions.handler.spec.ts`** para harness | 1.4 ✅ |
| ~~2.2~~ | **`weapon-attack.spec.ts`** — `it.each` + helpers; meta <300 linhas | — ✅ |
| ~~2.3~~ | **`roll-damage.spec.ts`** — `buildMockWeaponAttack()`; meta <300 | — ✅ |
| ~~2.4~~ | Split fixtures mecânicas → `__fixtures__/mechanical-catalog/index.ts` | — ✅ |
| ~~2.5~~ | Split **`class-resources.ts`** — SQL → `session/infrastructure/queries/` | — ✅ |
| ~~2.6~~ | Split **`barbarian/subclass-actions/index.ts`** (template monk/bard/…) | — ✅ |
| ~~2.7~~ | Política de testes em [`code-standards.md`](../architecture/code-standards.md#testes) | 2.1 ✅ |

Política canônica de testes: [`code-standards.md` § Testes](../architecture/code-standards.md#testes).

**Métricas de saída:**

| Indicador | Hoje | Meta fase 2 |
|-----------|------|-------------|
| `as never` em handler specs | ~14× boilerplate | **0** nesses arquivos |
| Specs >400 linhas | ≥2 | **0** |
| Arquivos prod ≥400 | 5 | **≤2** |
| Ratio spec/prod | 0,45 | **≤0,40** |
| Testes | B− | **B** |
| Nota final | ~3,0 | **≥ 3,3 (B+)** |

---

### Fase 3 — DB: um jeito por caso de uso

**Done quando:** matriz em `catalog-patterns.md`; inventário validators **0 SQL cru**; ADR validators; hotspots (spell-progression, class-resources, roll-weapon) em queries infra.

| # | PR / entrega | Depende |
|---|--------------|---------|
| 3.0 | ~~**Inventário SQL**~~ — [`§ Inventário validators`](#inventário-sql-cru--validators-fase-30) | — ✅ |
| ~~3.1~~ | **`spell-progression.queries.ts`** — views `v_*` via TypeORM | 3.0 ✅ |
| 3.2 | ~~**`class-resources.ts`** — queries em infrastructure~~ | 2.5 ✅ |
| ~~3.3~~ | **`firearm-ops`** + **`roll-weapon-context`** → `session/infrastructure/queries/` | 3.0 ✅ |
| ~~3.4~~ | **Validators fase 1** — spells + feats → `feat-option.queries.ts` + views TypeORM | 3.1 ✅ |
| ~~3.5~~ | **Validators fase 2** — class-options + background → queries infra | 3.4 ✅ |
| ~~3.6~~ | **ADR** — [`adr-sheet-validation-layers.md`](../architecture/adr-sheet-validation-layers.md) | 3.5 ✅ |
| ~~3.7~~ | **Matriz runtime** em [`catalog-patterns.md` §10](../architecture/catalog-patterns.md#10-runtime-game-reads) | 3.0 ✅ |

**Métricas de saída:**

| Indicador | Hoje | Meta fase 3 |
|-----------|------|-------------|
| Validators com `dataSource.query` | **0** | **0** ✅ |
| DB consistência | C+ | **B** |
| DRY SQL | A−/B | **A−** |
| Nota final | ~3,3 | **≥ 3,4 (B+ estável)** |

---

### Fase 4 — Estrutura pré-prod (decisão explícita)

**Done quando:** baseline migration ou decisão documentada de manter granular; barrels policy aplicada; `combat/domain/notes/`; pastas leaf >4 com plano.

| # | PR / entrega | Risco |
|---|--------------|-------|
| 4.1 | ~~Baseline greenfield~~ → [`database/baseline/001_full_schema.sql`](../../database/baseline/001_full_schema.sql) | ✅ 2026-09-02 |
| 4.2 | ~~Barrel policy — `session/dto/index.ts`~~ | ✅ 2026-09-02 |
| 4.3 | Mover `*-combat-notes-data.ts` → `combat/domain/notes/` | Baixo |
| 4.4 | Split `inventory/application` (15 arquivos) | Médio |
| 4.5 | `CatalogLookupService` vs queries — um caminho para escrita ficha | Médio |
| 4.6 | DTOs com `Omit`/`Pick`; slugs em `constants.ts` | Baixo contínuo |

**Meta:** **A−** em catálogo/arquitetura; nota global **≥ 3,7** se fases 1–3 concluídas.

---

### O que não entra neste plano

| Item | Motivo |
|------|--------|
| Unificar rotas mesa / REST resource-oriented | Projeto API separado — §7 |
| Refatorar `TableActionsController` monolítico | Estável para front; só com contrato novo |
| Combate situacional / monstros | Backlog adiado |
| Features GH / Northlands | Paralelo — não bloquear por code-health |

### Cadência

1. **Uma fase por sprint** (ou 2 PRs da fase 1 na mesma semana).
2. Ao fechar fase → re-executar [Como re-executar](#como-re-executar) e atualizar [Veredito](#veredito) + [Condição DRY](#condição-dry).
3. Checkbox no [`backlog.md`](backlog.md) só sai quando critério **Done quando** da fase for atingido.

### Próximo passo imediato

**Fase 1.1** — PR `abilityMod sweep` (3 arquivos, zero regra nova, ~30 min).

---

## Nota final

Escala: A=4,0 · A−=3,7 · B+=3,3 · B=3,0 · B−=2,7 · C+=2,3 · C=2,0.

| Dimensão | Nota | Peso | Contribuição |
|----------|------|------|--------------|
| Tamanho | B | 10% | 0,30 |
| Clean Code | B+ | 10% | 0,33 |
| DRY (SQL/TS) | B | 15% | 0,45 |
| SOLID | B− | 10% | 0,27 |
| Arquitetura | B | 15% | 0,45 |
| Scripts | C+ | 5% | 0,12 |
| Migrations | B | 5% | 0,15 |
| Docs agente | B− | 5% | 0,14 |
| Testes | B− | 10% | 0,27 |
| DB consistência | C+ | 10% | 0,23 |
| TypeScript | C+ | 10% | 0,23 |
| Unificação stats | C+ | 5% | 0,12 |
| **Total** | **B−** | 100% | **2,96** |

Média numérica **2,96** (limiar B = 3,0). Nota **B−** por arredondamento conservador: três eixos em C+ (DB, TS, stats) são dívidas estruturais que afetam todo código novo.

**Condição DRY:** teto global **B** ativo (CA duplicada) — ver [§ Condição DRY](#condição-dry). Subir para **B+** exige zerar gates: AC unificado, `abilityMod` sweep, harness de specs.

### Leitura executiva

- **Fortes:** catálogo SQL enxuto; bundles RPC ficha/combate; 87,6% dos arquivos ≤150 linhas; suite estável.
- **Fracos:** validators com SQL cru; `as never` em massa nos testes; CA calculada por dois caminhos; scripts órfãos.
- **Subir para B:** abilityMod sweep + harness de testes + AC unificado (3 PRs rápidos).
- **Subir para B+:** validators → RPC/views + enxugar specs >300 linhas.

### Checklist `unify-game-stats` (no code-health)

| Stat | SSOT | Status check |
|------|------|--------------|
| Mod. atributo | `ability-scores.ts` | ✅ (fase 1.1) |
| PV máx. | `hit-points.calc.ts` | ✅ |
| PV clamp | `combat-vitals.ts` | ✅ |
| Moedas | `coin-purse.ts` | ✅ |
| CA | `resolve-equipped-armor-class` | ✅ ficha via `combat` slice (fase 1.3) |
| `hasStyleOrFeat` | `feat/has-style-or-feat.ts` | ✅ (fase 1.2) |

---

## Como re-executar

```powershell
# DRY + TS + stats (dry-quality · unify-game-stats · typescript-quality)
rg "function abilityMod|Math\.floor\(\(.*- 10\) / 2\)" src --glob "*.ts" --glob "!*.spec.ts" -l
rg "dataSource\.query" src/game/sheet/domain/validation -l
rg "as never" src --glob "*.ts" --glob "!*.spec.ts" -l
rg "as never" src --glob "*.spec.ts" -c
rg "\bany\b" src --glob "*.ts" --glob "!*.spec.ts" -l
rg "function abilityMod" src --glob "*.ts" --glob "!*.spec.ts" -l
rg "\bOmit<" src --glob "*.ts" -l

# Tamanho TS
Get-ChildItem -Path src -Recurse -Filter "*.ts" |
  Where-Object { $_.Name -notmatch '\.spec\.ts$' } |
  ForEach-Object { [PSCustomObject]@{ Lines = (Get-Content $_.FullName | Measure-Object -Line).Lines; Path = $_.FullName } } |
  Sort-Object Lines -Descending | Select-Object -First 40

# Pastas > 4 arquivos
Get-ChildItem -Path src -Recurse -Directory | ForEach-Object {
  $n = @(Get-ChildItem $_.FullName -File -Filter "*.ts" | Where-Object { $_.Name -notmatch '\.spec\.ts$' }).Count
  if ($n -gt 4) { [PSCustomObject]@{ Count = $n; Path = $_.FullName } }
} | Sort-Object Count -Descending

# Specs grandes
Get-ChildItem -Path src -Recurse -Filter "*.spec.ts" |
  ForEach-Object { [PSCustomObject]@{ Lines = (Get-Content $_.FullName | Measure-Object -Line).Lines; Path = $_.FullName } } |
  Sort-Object Lines -Descending | Select-Object -First 20

# SQL cru no domain (validators)
rg "dataSource\.query" src/game/sheet/domain/validation --count-matches

npm test
```
