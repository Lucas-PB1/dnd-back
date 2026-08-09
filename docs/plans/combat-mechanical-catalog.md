# Catálogo mecânico de combate no banco

Skills: `rpg-catalog-model` · `postgres-apply-catalog` · `phb-query-views` · `rpg-class-mesa-api`  
Padrões: [`../architecture/catalog-patterns.md`](../architecture/catalog-patterns.md) · [`../architecture/data-model.md`](../architecture/data-model.md)

## Meta

SSOT no schema `rpg` para listas mecânicas que a engine de mesa/dados consome (manobras, Golpe Astuto, ações de subclasse, máscaras, etc.). O domain TS fica com **fórmulas**, **notas derivadas** e kinds técnicos — sem arrays estáticos de catálogo.

## Decisões

| Tema | Escolha |
|------|---------|
| Modelo | Tabelas tipadas por família + views `v_phb_*` |
| Escopo | Varredura completa de `CATALOG` em `combat/domain` |
| Runtime | Application carrega via views; domain recebe registros |

## Tabelas

| Tabela | Conteúdo |
|--------|----------|
| `phb_gunslinger_maneuver` | Manobras do Pistoleiro (`effect_kind`, `risk_cost`, …) |
| `phb_battle_master_maneuver` | Manobras BM (timing / adds_to_*) — `option_value` continua como escolha da ficha |
| `phb_cunning_strike_effect` | Efeitos de Golpe Astuto |
| `phb_subclass_table_action` | Ações Psi Warrior / Soulknife (+ futuros) |
| `phb_persona_mask` | Máscaras do Colégio das Máscaras |
| `phb_beastborne_aspect_benefit` | Benefícios por nível de aspecto |
| `phb_dungeoneer_slayer_type` | Tipos de Matar Monstro |
| `phb_subclass_precaution_spell` | Allowlist Precaução → `phb_spell` |
| `phb_class_economy_action` | Catálogo da aba Ações (economia de turno) |
| `phb_class_panel_action` | Botões dos painéis de combate por classe |

ENUMs: `maneuver_effect_kind`, `battle_master_maneuver_timing`, `save_ability` (`010_types/003_combat_mechanical_enums.sql`); `action_economy_bucket`, `panel_action_section` (`004_class_action_ui_enums.sql`).

Seeds: `database/seeds/combat/C00*.sql` — base **C009** (economy) + **C010** (panels); patches idempotentes **C014**–**C019** (wizard / warlock / sorcerer / patronos / fighter panel).

HTTP: `GET /combat-mechanical-catalog` inclui `economyActions` + `panelActions`.

## Fica no TS

- Fórmulas (`sneakAttackDiceCount`, rage, superiority, …)
- `*CombatNotes` / notas de ataque
- Predicados de combate / assemble de ataques
- Validação de `weaponCharm.kind` contra JSON do item

## SLUG_MIRROR

Listas `*_SUBCLASS_SLUGS` incompletas: remover ou substituir por leitura de `phb_subclass` / lookup; notas devem usar slug da ficha, não allowlist local.

## Entrega

| Fase | Conteúdo |
|------|----------|
| 0 | Este doc + ENUMs + índice |
| 1 | Manobras GS + BM |
| 2 | Golpe Astuto |
| 3 | Table actions |
| 4 | Máscaras / Beastborne / Dungeoneer |
| 5 | Limpeza SLUG_MIRROR + code-health |

Critério de pronto: **zero** arrays `CATALOG` em `combat/domain` — **atingido** (2026-08-06). Fixtures só em `__fixtures__/` para testes unitários.
