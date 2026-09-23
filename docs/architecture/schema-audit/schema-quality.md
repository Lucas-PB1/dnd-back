# Análise de qualidade — tabelas similares

> Auditoria 2026-09-23 · trilha [`schema-generics-backlog.md`](../../plans/schema-generics-backlog.md).

Revisão com lentes **DRY**, **Clean Code**, **DDD** (contextos) e **SQL-first** sobre `schema.sql`.
Foco: tabelas parecidas, duplicação de conhecimento e falhas estruturais.

## Veredito rápido

O schema é **coerente no domínio**, mas acumula:

1. **Espelhamento intencional** (template → runtime) — ok, com custo de sync.
2. **Famílias quase-iguais** (creature/vehicle; class/subclass gates) — DRY aspiracional.
3. **Dois motores de combate paralelos** (`skirmish` vs `duel`) — risco de divergência.
4. **Enums órfãos** e **PK ausente** — falhas concretas.
5. **God-table de estado** (`player_character_state`) — SRP sob pressão.

---

## 1. Falhas concretas (corrigir / confirmar)

| Severidade | Achado | Detalhe |
|------------|--------|---------|
| **Alta** | `phb_class_proficiency` sem PRIMARY KEY | Só `CHECK` + FKs; sem PK composta `(class_id, kind, ref_id/ref_slug)`. Permite linhas duplicadas. |
| **Média** | Enums declarados e **nunca usados** em coluna | `resource_owner_kind`, `combat_modifier_kind`, `combat_modifier_owner` — só aparecem no `CREATE TYPE` (refs=1). Mortos ou esquecidos após refactor para views/`effect_*`. |
| **Média** | Enums **duplicados em espírito** | `combat_modifier_kind` ≈ `effect_combat_mod_kind` (ambos `hp_bonus` / `unarmored_defense`). Conhecimento em dois lugares. |
| **Baixa** | Estilo `CREATE TABLE` inconsistente | 7× `IF NOT EXISTS`, 170× sem — ruído de evolução. |
| **Baixa** | `INT` vs `INTEGER` misturados | Mesmo tipo, nomenclatura inconsistente (Clean Code / naming). |

---

## 2. Tabelas similares — clusters

### A) Lookup mínimo idêntico (não é bug)

Várias tabelas compartilham o mesmo shape:

- `id, slug, name, sort_order` → ability, spell_school, tool_category, …
- `id, slug, name, description` → fighting_style, weapon_property, weapon_mastery, spell_slot_pattern, …

**Leitura DRY:** unificar numa tabela genérica `phb_term` **não** vale a pena (DDD: bounded languages diferentes). Aqui a “duplicação” é **saudável**.

### B) Creature ↔ Vehicle (DRY real)

| Par | Similaridade de colunas |
|-----|------------------------:|
| `phb_creature_template_action` ↔ `phb_vehicle_template_action` | ~100% |
| `…_speed` ↔ `…_speed` | ~100% |
| `…_trait` ↔ `…_trait` | ~100% |
| templates raiz | ~37% (domínios divergem: CR vs crew/cargo) |

**Falhas potenciais:**

- Qualquer coluna nova em action/speed/trait precisa ser espelhada **duas vezes**.
- FK por `template_slug` TEXT (não UUID/BIGINT) — frágil se slug mudar; comum em catálogo, mas sem `ON UPDATE`.

**Mitigação possível:** tabela polimórfica `phb_stat_block_action(owner_kind, template_slug, …)` — só se a dor de sync justificar.

### C) Template → `game_actor_*` (cópia de runtime)

| Par | Notas |
|-----|--------|
| `game_actor_action` ↔ `creature_template_action` | ~91% — troca `template_slug` por `actor_id` |
| `game_actor_spell` ↔ `creature_template_spell` | ~80% |
| `game_actor_speed` ↔ `creature_template_speed` | similar |

**Isso é padrão snapshot** (spawn copia o template). Não é falha de modelo se a função `spawn_game_actor_from_template` for a única ponte.  
**Risco:** drift se alguém alterar template e esperar actors já spawnados atualizarem.

### D) Class ↔ Subclass (quase-espelhos)

| Par | Diff principal |
|-----|----------------|
| `class_feature_gate` ↔ `subclass_feature_gate` | `class_id` vs `subclass_id` |
| `class_feature` ↔ `subclass_feature` | subclass ainda tem `feature_kind`, `option_key` |
| `class_spellcasting` ↔ `subclass_spellcasting` | subclass ganha `spell_list_class_id`, `spell_slot_pattern_id` |
| `class_progression` ↔ `subclass_progression` | class tem PB/ASI/weapon_mastery; subclass é mais magra |

**Qualidade:** aceitável (OCP por contexto).  
**Cheiro:** nomes/colunas que deveriam ser simétricos às vezes não são (`economy_action` vs `table_action`).

### E) Combate: `skirmish` vs `duel` (alerta DDD)

Dois **bounded contexts de combate** com overlap:

| Conceito | Skirmish | Duel |
|----------|----------|------|
| status | active/finished | open/ready/active/finished/cancelled |
| log / arena | `combat_log`, `arena_effects` | idem |
| turn/attacks | sim | sim |
| multiplayer | não (1 user + actors) | sim (invite_code, members) |
| HP no combatant | no actor/PC state | em `duel_member` |
| winner | `winner_kind` pc/actor | `winner_user_id` / character |

**Falhas potenciais:**

- Regras de turno/log/arena **duplicadas** em duas árvores.
- `status` e `end_reason` como `TEXT` + CHECK em ambos — candidatos a enum compartilhado.
- `user_id` / `created_by` UUID **sem FK** (típico Supabase `auth.users`, mas órfão no schema `rpg`).

### F) Estado: `player_character_state` vs `game_actor_state`

Quase **não** similares (sim ~8%), e isso já é um cheiro:

- `game_actor_state`: magro (conditions, temp_hp, crew/cargo, innate uses).
- `player_character_state`: **god-row** — rage, wild shape, starry form, firearms, persona masks, mesa circumstances, death saves, …

**SRP:** cada feature de classe empurra mais coluna booleana/JSONB na mesma tabela.  
Funciona, mas escala mal (migrations frequentes, nullables semânticos, difícil testar invariantes).

### G) Manobras: Battle Master vs Gunslinger

Mesmo “tipo de coisa” (manobra), **shapes diferentes**:

- BM: `timing`, `mesa_roll_kind`, flags de damage/attack  
- Gunslinger: `effect_kind`, `risk_cost`, `from_level`, `subclass_id`

**Não unificar à força** (mecânicas diferentes), mas o nome `*_maneuver` sugere semelhança que o DDL não entrega — risco de API/dev assumir contrato comum.

### H) Satélites `phb_effect_*` (27 tabelas)

Padrão **extension tables** por `effect_kind` (uma tabela por payload).

**Prós:** tipagem forte, CHECKs por kind.  
**Contras (DRY/manutenção):**

- Explosão de tabelas (27).
- Motor precisa conhecer o mapa kind → tabela.
- Alternativa EAV/JSONB seria pior para integridade — o design atual é trade-off consciente, não acidente.

---

## 3. Polimorfismo sem FK

Tabelas com `scope`/`owner_kind` + `owner_id` (ex.: `phb_option_def`, `phb_effect`):

- **Sem FK** para o dono (impossível FK clássica polimórfica).
- Parte tem `CHECK` de coerência; `phb_option_value` tem checks fracos/ausentes no parse.

**Risco:** `owner_id` órfão se o dono for apagado sem cascata lógica na app.

---

## 4. Slugs TEXT sem FK (31+ colunas)

Exemplos: `resource_slug`, `action_slug`, `damage_type_slug`, `size_slug`, `choice_slug`.

**Motivo comum:** catálogo versionado por slug estável + seeds.  
**Falha:** typo no seed não quebra no INSERT; só em runtime.

Priorizar FK (ou enum) onde já existe tabela canônica (`phb_damage_type`, `phb_skill`, …).

---

## 5. IDs: dois mundos

| Tipo PK | Uso típico | Qtd (aprox.) |
|---------|------------|-------------:|
| `BIGSERIAL` / `BIGINT` | Catálogo `phb_*` | ~64 |
| `UUID` | Runtime (PC, campaign, actor, skirmish, duel) | ~15 |

**Isso é bom DDD** (catálogo denso vs identidade distribuída).  
Não misturar: não use UUID em toda tabela PHB “por moda”.

---

## 6. Checklist de qualidade (próximos passos sugeridos)

1. **PK** em `phb_class_proficiency` (composta coerente com o CHECK de ref).
2. **Remover ou usar** enums órfãos (`resource_owner_kind`, `combat_modifier_*`).
3. **Unificar** `combat_modifier_kind` × `effect_combat_mod_kind` se ambos forem necessários — um só SSOT.
4. Documentar contrato **skirmish vs duel** (quando usar cada) ou extrair colunas/status compartilhados.
5. Avaliar fatiar `player_character_state` (flags de subclass → JSONB versionado ou tabelas satélite).
6. Onde houver tabela canônica, trocar `*_slug` TEXT solto por FK.
7. Padronizar `INTEGER` e `CREATE TABLE` sem `IF NOT EXISTS` no SSOT (baseline greenfield).

---

## 7. O que *não* é falha

- Muitas tabelas `phb_effect_*` — vertical slice tipado.
- Lookups id/slug/name repetidos — vocabulário por conceito.
- Snapshot `game_actor_*` ≠ template — cópia de combate.
- UUID runtime vs BIGINT catálogo — fronteira de contexto correta.
