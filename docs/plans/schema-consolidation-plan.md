# Plano de consolidação de tabelas (schema `rpg`)

Fonte: avaliação do dump `sql.sql` (~100 tabelas).  
Uso: levar como plano de modelo para **outro projeto** (greenfield ou redesign).  
Não depende do código da aplicação.

## Meta

| Hoje | Alvo sugerido |
|------|----------------|
| ~100 tabelas | **~45–60** |

Manter: integridade referencial do catálogo PHB + fronteira **catálogo (`phb_*`) ≠ runtime** (`player_character_*` / `campaign_*`).

---

## O que não fundir

- `phb_edition` + `phb_source_citation`
- `phb_ability` / `phb_skill` / `phb_language` / `phb_alignment`
- `phb_class` + `phb_subclass` + features / progression
- `phb_spell` + `phb_spell_class` + slot pattern / by_level
- `phb_feat` (+ benefit / requirement se a granularidade importar)
- `phb_item` + `phb_weapon` / `phb_armor` / `phb_tool` (herança por extensão)
- `phb_species` + `phb_species_trait` (núcleo)
- `phb_background` (núcleo) + links de skill/language
- Runtime: `player_character` + filhos essenciais; `campaign` + member + character + encounter + combatant

---

## Lotes de redução

### Lote A — Lookups miúdos → ENUM / CHECK / coluna  
**Esforço:** baixo · **Delta:** −8 a −12

Candidatos: `phb_hit_die`, `phb_weapon_proficiency`, `phb_divine_order`, `phb_druid_land_terrain`, `phb_ability_generation_method`, categorias só-label, `phb_condition` (se for só slug+name), `phb_character_level` (progressão pode ser função ou 1 tabela enxuta).

### Lote B — Lineages / ancestries → options genéricas  
**Esforço:** médio · **Delta:** −5 a −6

Hoje: `phb_elf_lineage`, `phb_gnome_lineage`, `phb_infernal_legacy`, `phb_dragon_ancestry`, `phb_giant_ancestry`, `phb_geppettin_construction`, `phb_mandrake_season`.

Alvo: reusar o padrão `species_option_def` / `species_option_value` (já existe) + enum de `choice_kind`. Spells por nível viram valores tipados ou grants (lote E).

### Lote C — Unificar option_def / option_value  
**Esforço:** médio · **Delta:** −4

Hoje: pares em subclass, species e feat (6 tabelas).

Alvo: `option_def` / `option_value` com `scope` (`subclass` | `species` | `feat`) + `owner_id`. No runtime: uma tabela de escolha tipada em vez de 3–4.

### Lote D — Starting packages unificados  
**Esforço:** médio · **Delta:** −2

Hoje: `phb_class_starting_package` / `_item` e `phb_background_starting_package` / `_item`.

Alvo: `phb_starting_package(source, owner_id, slug…)` + `phb_starting_item`. Runtime `package_slug` passa a FK clara.

### Lote E — Spell grants unificados  
**Esforço:** médio · **Delta:** −2 a −3

Hoje: `phb_feat_granted_spell`, `phb_species_granted_spell`, `phb_spell_source` (e overlaps).

Alvo: `phb_spell_grant(origin_type, origin_id, spell_id, …)` com CHECK de origem.

### Lote F — Afinidades de class ✅ DONE  
**Esforço:** alto · **Delta:** −4 (71→67 tabelas T)

Unificado em `phb_class_proficiency` + views compat em V001; seeds e `class-proficiencies.query.ts` atualizados.

### Lote G — Resources / modifiers ✅ DONE  
**Esforço:** alto · **Delta:** −2 a −3

Hoje: `phb_resource_definition` + class/subclass resource, `phb_hp_bonus_source`, `phb_unarmored_defense`.

Alvo: 1–2 tabelas de *modifier/rule* com `scope` + CHECK de exclusividade de ponteiros (evita vários `*_id` nullable sem regra).

---

## Ordem sugerida (novo projeto)

1. Desenhar o modelo alvo (~45–60) com lotes **A → C** primeiro.  
2. Incorporar os **Critical** da avaliação de qualidade (campanha UNIQUE/FK, class↔subclass, combatant XOR).  
3. Migrar / seedar **catálogo**; só depois **runtime**.  
4. Lotes **F / G** por último (maior risco de regressão de queries).  
5. Não trocar FK estável do PHB por JSON “flexível”.

## Estimativa

| Pacote | Redução aproximada |
|--------|-------------------|
| A–E (seguro) | −20 a −28 |
| + F–G | −25 a −40 no total |
| Runtime | quase não encolhe (~15 tabelas) |

Ganho está no **catálogo `phb_*`**, não no runtime.

---

## Relacionado

- Relatório interativo: canvas `schema-review-rpg` (findings + este plano).  
- Findings de qualidade (Critical/Warning) devem entrar no DDL do novo projeto desde o dia 1.

---

## No dnd-api

- ADR: [`../architecture/adr-schema-consolidation.md`](../architecture/adr-schema-consolidation.md) (status: **Aceito**)
- Mapa tabela a tabela: [`../architecture/schema-equivalence-map.md`](../architecture/schema-equivalence-map.md)
- Modelo atual: [`../architecture/data-model.md`](../architecture/data-model.md)
- Padrões atuais (podem conflitar com lotes B/C/E): [`../architecture/catalog-patterns.md`](../architecture/catalog-patterns.md)
