# Code health — plano de enxugamento

Objetivo: reduzir arquivos gordos, domínios multifuncionais, duplicação SQL/TS e legado, com documentação centralizada.

Skills: `audit-code-health` · `split-large-module`  
Standards: [`../architecture/code-standards.md`](../architecture/code-standards.md)

## Inventário (2026-07-27, reaudit pós-P0)

Contagem: `src/**/*.ts` excluindo `*.spec.ts`. Soft 151–200 · hard >200 · crítico ≥400.

### Crítico (≥ 400 linhas)

Nenhum — ✅ zero críticos após P5.

| Arquivo | ~Linhas | Nota |
|---------|---------|------|
| ~~`character-feats.validator.ts`~~ | ~~466~~ | P1 |
| ~~`character-class-options.validator.ts`~~ | ~~418~~ | P2 |
| ~~`weapon-attack.ts`~~ | ~~428~~ | P4 |
| ~~`character-state.repository.ts`~~ | ~~447~~ | ✅ **P5** — `character-state/` |

**Resultado P1 — split feats:**

| Arquivo | Linhas | Responsabilidade |
|---------|--------|------------------|
| `character-feats.validator.ts` | ~51 | Lista/instâncias + facade `validateFeatOptions` |
| `character-feat-options.validator.ts` | ~157 | Orquestra opções + PB + defs |
| `character-feat-option-value.validator.ts` | ~172 | valueType (fighting_style, catalog, ability, spell) |
| `character-feat-option-rules.ts` | ~115 | ASI / MI / ritual / casting ligado |
| `feat-option-proficiency.ts` | ~55 | Proficiency / skilled / tools |

**Resultado P2 — split class-options:**

| Arquivo | Linhas | Responsabilidade |
|---------|--------|------------------|
| `character-class-options.validator.ts` | ~126 | Facade + fighting styles |
| `character-species-choices.validator.ts` | ~48 | Trait choices de espécie |
| `character-subclass-options.validator.ts` | ~101 | Level rules, unlock, subclass options |
| `character-class-expertise.validator.ts` | ~86 | Expertise de classe |
| `character-weapon-mastery.validator.ts` | ~156 | Weapon mastery + progression |

### Hard (> 200)

| Arquivo | ~Linhas | Split sugerido |
|---------|---------|----------------|
| ~~`campaign/.../campaign.repository.ts`~~ | ~~307~~ | ✅ **P5** — `campaign/` helpers |
| ~~`sheet/.../character-sheet.repository.ts`~~ | ~~291~~ | ✅ **P5** — load/sync |
| ~~`sheet/application/update-character.handler.ts`~~ | ~~288~~ | ✅ **P3** |
| ~~`dice/.../character-rolls.service.ts`~~ | ~~280~~ | ✅ **P4** |
| ~~`sheet/dto/character-response.dto.ts`~~ | ~~244~~ | ✅ **P8** — combat + ability-scores DTOs |
| ~~`sheet/domain/validation/spells/character-spells.validator.ts`~~ | ~~234~~ | ✅ **P8** — quotas / list access / progression |
| `catalog/catalog-lookup.service.ts` | 206 | OK se só asserts |
| ~~`inventory/.../character-inventory.repository.ts`~~ | ~~202~~ | ✅ **P5** — `inventory/inventory-item-ops.ts` |

**Resultado P5 — repositories:**

| Arquivo | Linhas |
|---------|--------|
| `session/.../character-state.repository.ts` | ~189 |
| `session/.../character-state/*` | ≤124 cada |
| `campaign/.../campaign.repository.ts` | ~169 |
| `campaign/.../campaign/{crud,membership,links}.ts` | ≤130 |
| `sheet/.../character-sheet.repository.ts` | ~126 |
| `sheet/.../character-sheet/{load,sync}.ts` | ≤185 |
| `inventory/.../character-inventory.repository.ts` | ~151 |
| `inventory/.../inventory/inventory-item-ops.ts` | ~86 |

**Resultado P3 — update handler + mapper:**

| Arquivo | Linhas | Responsabilidade |
|---------|--------|------------------|
| `application/update-character.handler.ts` | ~183 | Orquestra update |
| `application/update-character/update-sheet-input.ts` | ~56 | Effective options / toSheetInput |
| `application/update-character/merge-update-character-spells.ts` | ~73 | Resync granted spells |
| `application/update-character/apply-background-and-identity-update.ts` | ~75 | Background boosts/tool |
| `application/update-character/clear-stale-sheet-choices.ts` | ~26 | Clears on class/species change |
| `infrastructure/character.mapper.ts` | ~158 | Orquestra toDto |
| `combat/application/resolve-character-combat-slice.ts` | ~90 | CA / ataques / compliance |
| `spellcasting/application/resolve-character-spellcasting-slice.ts` | ~122 | Magias anotadas + DC |

**Resultado P4 — weapon-attack + rolls:**

| Arquivo | Linhas | Responsabilidade |
|---------|--------|------------------|
| `combat/weapon-attack.ts` | ~31 | Barrel estável |
| `combat/weapon-attack.types.ts` | ~59 | Tipos |
| `combat/weapon-attack-predicates.ts` | ~157 | Proficiência / propriedades |
| `combat/dual-wield.ts` | ~72 | Análise TWF |
| `combat/compute-weapon-attacks.ts` | ~179 | Cálculo de ataques |
| `dice/.../character-rolls.service.ts` | ~103 | Facade Nest |
| `dice/.../rolls/roll-*.ts` | ≤68 | Um arquivo por tipo de roll |

**Resultado P6 — granted-spells:**

| Arquivo | Linhas | Responsabilidade |
|---------|--------|------------------|
| `spellcasting/granted-spells.ts` | ~7 | Barrel estável |
| `spellcasting/granted-spells/types.ts` | ~43 | Tipos + merge context |
| `spellcasting/granted-spells/collect-feat-granted-spells.ts` | ~48 | Talentos |
| `spellcasting/granted-spells/collect-species-granted-spells.ts` | ~34 | Espécie |
| `spellcasting/granted-spells/collect-subclass-granted-spells.ts` | ~11 | Subclasse |
| `spellcasting/granted-spells/merge-granted-spells.ts` | ~72 | Sync always_prepared |
| `spellcasting/granted-spells/annotate-spell-sources.ts` | ~28 | Anotação de origem |

**Resultado P8 — spells validator + response DTO:**

| Arquivo | Linhas | Responsabilidade |
|---------|--------|------------------|
| `validation/spells/character-spells.validator.ts` | ~93 | Orquestra validação |
| `validation/spells/validate-spell-list-access.ts` | ~55 | Lista classe/subclasse |
| `validation/spells/assert-spell-quotas.ts` | ~46 | Quotas cantrip/prepared |
| `validation/spells/spell-progression-queries.ts` | ~108 | SQL slots/progression |
| `dto/character-response.dto.ts` | ~153 | Response principal |
| `dto/ability-scores.dto.ts` | ~34 | Atributos |
| `dto/character-combat-response.dto.ts` | ~51 | Ataques + warnings |
| `dto/character-campaign-ref.dto.ts` | ~7 | Ref campanha |

### Soft (151–200) — extrair ao tocar

| Arquivo | ~Linhas |
|---------|---------|
| `sheet/domain/character-check-bonuses.ts` | 196 |
| `progression/domain/level-up.service.ts` | 185 |
| `sheet/dto/character-sheet.dto.ts` | 181 |
| `sheet/domain/character.factory.ts` | 178 |
| `campaign/application/campaign.service.ts` | 166 |
| `session/domain/class-resources.ts` | 163 |
| `session/dto/character-state.dto.ts` | 161 |
| `sheet/domain/character-sheet.validator.ts` | 159 |
| `dice/domain/dice.ts` | 153 |
| `spellcasting/domain/spell-quota.ts` | 153 |

### P0 feito (referência)

| Arquivo | Linhas | Responsabilidade |
|---------|--------|------------------|
| `character-sheet.validator.ts` | ~159 | Orquestrador + API pública |
| `character-create-requirements.validator.ts` | ~120 | Campos obrigatórios no create |
| `character-background.validator.ts` | ~103 | Boosts, skills, tool, origin feat |
| `character-equipment.validator.ts` | ~100 | Equipment, languages, ability gen |
| `character-spells.validator.ts` | ~93 | Facade quotas + list access (P8) |
| `character-class-options.validator.ts` | ~126 | Facade + fighting styles (P2) |
| `character-feats.validator.ts` | ~51 | Lista + facade (P1) |

`CharacterSheetContext` em `character-sheet.types.ts`.

## Fronteiras de PR (ordem sugerida)

1. ~~**P0** — Split `character-sheet.validator.ts`.~~ ✅ FEITO
2. ~~**P1** — `character-feats.validator.ts` (466).~~ ✅ FEITO
3. ~~**P2** — `character-class-options.validator.ts` (418).~~ ✅ FEITO
4. ~~**P3** — `update-character.handler.ts` + `character.mapper.ts`.~~ ✅ FEITO
5. ~~**P4** — `weapon-attack.ts` + rolls (combate).~~ ✅ FEITO
6. ~~**P5** — Repositories session/campaign/sheet/inventory.~~ ✅ FEITO
7. ~~**P6** — `granted-spells.ts`: split por origem + remover `mergeCharacterSpellsWithFeatGrants` `@deprecated`.~~ ✅ FEITO
8. ~~**P7** — Auditoria SQL DRY via `rpg-catalog-model`.~~ ✅ FEITO
9. ~~**P8 (opcional)** — `character-spells.validator.ts` (234) · DTO response se >250.~~ ✅ FEITO

**Próximo (ownership):** [`sheet-submodules-plan.md`](sheet-submodules-plan.md) — M1+M2 feitos; M3 naming use cases opcional.

Cada PR: um concern, specs verdes, sem rename cosmético.

## Legado

- ~~`mergeCharacterSpellsWithFeatGrants` removido (P6) — usar `mergeCharacterSpellsWithGrantedSources`.~~
- Specs usam `choiceKind: 'infernal_legacy'` (slug de catálogo tiefling, não código morto).
- Sem pasta `legacy/` formal.

## SQL / DRY

**Auditoria P7 (2026-07-27)** — doc canônica: [`catalog-patterns.md`](../architecture/catalog-patterns.md) · skill `rpg-catalog-model/references/`.

### Aceito (intencional)

| Padrão | Tabelas | Mitigação |
|--------|---------|-----------|
| `option_def` / `option_value` | species, feat, subclass (×2) | ENUM `option_value_type`; colunas extras por domínio |
| Linhagens espécie | elf, infernal, gnome, dragon, giant | Views `v_phb_species_trait_choices`, `v_phb_species_granted_spell` |
| Flavor | tagline/summary em class/subclass/background/species | Views enriquecidas (`v_phb_class`, etc.) |
| Starting items | class vs background package→item | Views equipment; `gold_amount` só classe |
| Filtros feat spell | colunas em `phb_feat_option_def` | Evita tabelas satélite |

### Riscos / regras

- **Nova linhagem:** estender views de granted spell + trait choices — não copiar UNION no TS.
- **Nova opção de talento:** colunas em `feat_option_def` antes de nova tabela.
- **`v_phb_species_trait_choices`:** evolução incremental (V024→V036); estado = última migration aplicada.
- **`phb_spell_source` ≠ granted spells:** metadado vs concessão mecânica na ficha.

### Fora do escopo SQL

- `catalog-lookup.service.ts` (206) — facade repetitivo OK; split opcional se >250.

## Documentação

- Hub: [`docs/README.md`](../README.md)
- Standards: [`code-standards.md`](../architecture/code-standards.md)
- Rules: `file-size` · `refactor-triggers` · `docs-hub`

## Definition of done (rolling)

- [x] Zero arquivos `src/` (não-spec) ≥ 400 linhas
- [x] Orquestrador da ficha ≤ 200 linhas (~159)
- [x] Hard restantes ≤ 206 (`catalog-lookup.service.ts` — facade asserts, OK)
- [ ] `docs/README.md` lista todos os MD ativos
- [ ] Nenhum `.md` órfão na raiz além de `README.md`

## Changelog do plano

| Data | Nota |
|------|------|
| 2026-07-27 | Criação + inventário inicial + rules/skills |
| 2026-07-27 | P0: split `character-sheet.validator.ts` + create-requirements; orquestrador ~159 |
| 2026-07-27 | Reaudit pós-P0: 4 críticos, 10 hard, 10 soft; PRs reordenados (feats/class-options antes de handler) |
| 2026-07-27 | P1: split feats (466→5 arquivos ≤172); resta 3 críticos |
| 2026-07-27 | P2: split class-options (418→5 arquivos ≤156); resta 2 críticos |
| 2026-07-27 | Reorg: validators + helpers de feat/class-options → `domain/validation/{feats,class-options,…}` |
| 2026-07-27 | Reorg: calcs `domain/` → `core/`, `combat/`, `stats/`, `spellcasting/`, `origin/` (raiz só types) |
| 2026-07-27 | P3: update-handler + mapper → pastas `update-character/` e `mapping/` |
| 2026-07-27 | P4: weapon-attack → combat/*; rolls → `dice/application/rolls/`; resta 1 crítico (state.repo) |
| 2026-07-27 | P6: granted-spells split por origem; deprecated removido |
| 2026-07-27 | P7: auditoria SQL DRY → `catalog-patterns.md` + refs `rpg-catalog-model` |
| 2026-07-27 | P8: spells validator + character-response DTO split; **zero hard >200** (exc. catalog-lookup 206 OK) |
