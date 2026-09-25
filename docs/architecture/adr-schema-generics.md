# ADR: schema por primitivas (trilha GEN — onda 2 da consolidação)

| Campo | Valor |
|-------|--------|
| Status | **Aceito** — implementado (GEN-0…10, rewrite in-place; sem produção — `db:setup`) |
| Data | 2026-09-23 → 2026-09-25 |
| Antecede | [`adr-schema-consolidation.md`](adr-schema-consolidation.md) (onda 1, lotes A→G) |
| Auditoria | [`schema-audit/`](schema-audit/) — inventário, qualidade, consolidação (2026-09-23) |
| Escopo | Modelo de dados + seeds + entities TypeORM; contratos TS de consumo preservados |

## Contexto

Após a onda 1, o schema ainda tinha ~177 tabelas e crescia **por feature do livro**: tabela nova por subclasse (máscaras, aspectos, tipos de presa), satélite de efeito por verbo, coluna nova no estado do PC por poder, três runtimes de combate com o mesmo formato.

## Decisão

**Norte:** o banco modela **primitivas**; feature do livro é **dado** (`kind` + payload), não DDL nova.

| Primitiva | Substitui |
|-----------|-----------|
| Effect + payload por shape | explosão de `phb_effect_*`; flags de feature no state |
| Option def/value | catálogos miúdos de subclasse |
| Class feature schedule | faixas por nível em tabela própria |
| Choice runtime única | `species_choice` / `transformation_choice` |
| Stat-block child polimórfico | filhos creature ↔ vehicle espelhados |
| Combat session + participant | skirmish / duel / encounter |
| Requirement clause | 7× `feat_requirement_*` |
| Combat note | 3× `*_combat_note` |
| `feature_state` esparso | coluna por poder em `player_character_state` |

### Resultado por pacote

| # | Mudança | Δ |
|---|---------|---|
| GEN-1 | PK `phb_class_proficiency`; enums órfãos removidos; CHECKs repetidos → enums compartilhados | 0 |
| GEN-2 | `player_character_choice(domain)` | −1 tabela |
| GEN-3 | `phb_combat_note(source_kind)` | −2 |
| GEN-4 | `phb_feat_requirement_clause` polimórfica | −5 |
| GEN-5 | `phb_feature_gate(owner_kind class\|subclass)` | −1 |
| GEN-6 | `phb_stat_block_{speed,action,spell,trait}` com FK dupla + `owner_kind`/`template_slug` gerados; `game_actor_*` segue snapshot no spawn | −3 |
| GEN-7 | Masks/Beastborne/Slayer → `phb_option_*`; faixas de Forma Selvagem → `phb_class_feature_schedule` | −5 |
| GEN-8 | `combat_session` + `combat_participant` | −3 |
| GEN-9 | 15 satélites de effect → 5 tabelas por shape | −10 |
| GEN-10 | 17 colunas de feature → `player_character_state.feature_state` | −17 colunas |

**KEEP documentados (GEN-7):** `phb_battle_master_maneuver` / `phb_gunslinger_maneuver` (contratos runtime distintos); `phb_cunning_strike_effect` (shape ≠ option); `phb_subclass_precaution_spell` / `phb_spell_spirit*` (junction / spawn).

### GEN-8 — sessão de combate única

- `rpg.combat_session(mode combat_session_mode)` + `rpg.combat_participant(session_mode)`; FK composta `(session_id, session_mode) → (id, mode)` impede participante de modo errado.
- Colunas de modo são nullable e travadas por `CHECK combat_session_shape_by_mode` / `combat_participant_shape_by_mode`; status validado por modo (`open|ready|active|finished|cancelled` duel; `active|finished` skirmish; `active|closed` encounter).
- Unicidade: `invite_code`; 1 encounter ativo por campanha; 1 skirmish ativa por `created_by`; `(session_id, character_id|actor_id)`; `(session_id, user_id)` em duel.
- Renomes: `duel_id|skirmish_id|encounter_id → session_id`; skirmish `user_id → created_by`; duel `initiative → initiative_total`; `current_combatant_id → current_participant_id`.
- RLS por modo na mesma tabela (políticas permissivas somam por OR). Sem views de compatibilidade.

### GEN-9 — satélites de effect agrupados por shape (G2)

- **G3 (JSONB) rejeitado:** perde CHECK/FK por kind e exigiria reescrever o runner.
- Grupos: `phb_effect_grant_ref(grant_kind)` = spell/feat/language/proficiency/damage_type; `phb_effect_scalar(scalar_kind)` = numeric/reach/companion/purchase_discount; `phb_effect_advantage(advantage_kind)` = check/save; `phb_effect_sense_env(sense_env_kind)` = sense/environmental_immunity; `phb_effect_dice(dice_kind)` = dice/damage_die.
- PK segue `effect_id` (1 payload por grupo por effect). CHECK por kind obriga as colunas do payload e zera as dos outros (sem defaults; seeds explícitos).
- Mantidos 1:1 (shape próprio): cast_economy, resource, combat_mod, note, weapon, rest_quirk, condition, save, forced_movement, combat_flag, table_roll, temp_hp. Fundir só se surgir shape comum real.
- Mapa lógico → físico: [`effect-dictionary.md`](effect-dictionary.md#satélite-lógico--tabela-física-gen-9).

### GEN-10 — `feature_state` esparso

- `player_character_state.feature_state JSONB` (chave ausente = default) em vez de tabela `player_character_flag`: estado é 1:1 com o PC e lido/escrito junto da row.
- Chaves e defaults: `src/game/session/domain/character-feature-state.ts` (`CharacterFeatureState`, `readFeature` / `writeFeature`); escrita remove a chave ao voltar ao default. Sem versão no JSON.
- Continuam coluna: estado genérico de ficha (slots, recursos, condições, PV temp., DV, death saves, inspiração, `granted_spell_uses`, `mesa_circumstances`) e **FKs** para `game_actor` (`wild_shape_actor_id`, `boarded_actor_id`, `skinrider_actor_id`) — JSONB perderia `ON DELETE SET NULL`.
- DB: CHECK `jsonb_typeof = 'object'` + faixa de `bestialAspectLevel`.

### Padrão TypeORM comum (GEN-8 / GEN-9 / GEN-10)

Unificar a tabela **sem** reescrever consumidores:

- **Tabela com discriminador → Single Table Inheritance.** Pai `@Entity` + `@TableInheritance({ column: { type: 'text', name: '<disc>' } })`; cada tipo antigo vira `@ChildEntity('<valor>')` com as próprias colunas (irmãs podem mapear a mesma coluna com nomes de propriedade diferentes). O TypeORM grava o discriminador no INSERT, filtra `IN (...)` no SELECT e — no JOIN `OneToOne` do lado inverso — acrescenta `AND <disc>='<valor>'`. Registrar o pai no `forFeature`.
- **Colunas → JSONB:** getters/setters com os nomes antigos sobre a coluna JSONB. Limites: `select`/`where` do TypeORM precisam usar a coluna real; spread / `Object.assign` de instância não copia getters.

## Consequências

- ~−30 tabelas e −17 colunas; schema para de crescer por feature.
- Feature nova = seed (option, schedule, effect) ou chave em `CharacterFeatureState`; tabela nova exige justificativa neste ADR ou em sucessor.
- Seeds de satélite agrupado declaram o discriminador: `INSERT INTO rpg.phb_effect_scalar (scalar_kind, effect_id, …) SELECT 'numeric', …`.
- Ver padrões operacionais em [`catalog-patterns.md`](catalog-patterns.md) §13–§14.

## Anti-padrões

- Nova tabela porque "saiu no suplemento X".
- Fundir lookups `id/slug/name` num `phb_term` genérico (quebra FKs/DDD).
- JSONB total nos effects (G3) sem novo ADR.
- Coluna nova em `player_character_state` para poder de classe/subclasse.
- Cascata de ALTER quando wipe é opção — preferir `db:setup` local ([`database/migrations/README.md`](../../database/migrations/README.md)).
