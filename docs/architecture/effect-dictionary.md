# Dicionário de efeitos (v0)

SSOT semântico dos `rpg.effect_kind`. Kind novo → satélite + serviço TS + linha neste arquivo no mesmo PR.

ADR: [`adr-effect-engine.md`](adr-effect-engine.md) · Plano: [`../plans/effect-engine.md`](../plans/effect-engine.md) · **Read-path / kind→consumidor:** [`effect-engine-read-path.md`](effect-engine-read-path.md)

## Freeze (DX)

Preferir reusar kind existente ou `combat_note`/`table_note`. Kind novo exige ENUM + satélite (se params) + linha neste dicionário + linha na tabela kind→consumidor do read-path + call site no mesmo PR.

**Espécie:** migração de traits → `phb_effect` em andamento — kinds/satélites de espécie são permitidos quando o trio schema+entity+dicionário/read-path acompanha o PR.

## Convenções

| Campo | Uso |
|-------|-----|
| `kind` | Verbo |
| `owner_kind` + `owner_id` | Dono (feat, species, class, subclass, item, heritage, character_thread) |
| `trigger` | Quando o runtime considera o efeito |
| Satélite | Params tipados; CHECK amarra ao `kind` |

Triggers: `passive` · `on_build` · `on_table_action` · `on_resource_spend` · `on_cast` · `on_purchase` · `on_damage_roll` · `on_d20_nat1` · `on_bloodied` · `on_rest_short` · `on_rest_long` · `on_death_save`

## Padrões Fase 5

Origens multi-fonte (Steinhardt / Grim Hollow Cap. 4 / Northlands). Seeds: `database/seeds/effects/E002`–`E004`. Plano vivo: [`../plans/effect-engine.md`](../plans/effect-engine.md).

| Padrão | Quando | Como |
|--------|--------|------|
| **Offer + toggle** | Jogador decide gastar uso ou marcar bônus (Fortuna, Syndicate, Norn, Well-versed, …) | Economy / `on_table_action` + flag no roll; não kind nomeado pelo feat |
| **Ações PHB** | Influenciar, Estudar, Procurar, Utilizar | Preferir note + kinds genéricos (`check_advantage`, `choose_ability_for_check`, …); sem endpoint por ação |
| **Circunstância** | Som/olfato, forragear, neve, água, embarque | `check_advantage` com tag/circunstância **ou** `combat_note` até haver satélite |

Verbos **sempre genéricos** — nunca `kind` com nome de talento/fonte.

## Kinds

### `grant_spell` (piloto)

- **Semântica:** concede magia fixa (`spell_id`) e/ou magia escolhida (`option_key`).
- **Satélite:** `phb_effect_spell` (+ opcional `phb_effect_cast_economy` no mesmo `effect_id`).
- **Trigger típico:** `on_build`
- **Serviço:** merge em granted-spells / annotate economy
- **Exemplo:** Iniciado em Magia — `cantrip1`/`cantrip2`/`firstLevelSpell`
- **Não cobre:** magias preparadas de subclasse (`phb_subclass_prepared_spell`)

### `free_cast` (piloto / stub)

- **Semântica:** economia de conjuração sem re-declarar o grant (atalho).
- **Satélite:** `phb_effect_cast_economy` (+ `phb_effect_spell` para escopo)
- **Trigger típico:** `on_cast`
- Preferir economy no próprio `grant_spell` quando for o mesmo traço.

### `grant_resource`

- **Semântica:** concede pool (`resource_definition`) com fórmula de máximo/recuperação.
- **Satélite:** `phb_effect_resource`
- **SSOT:** `phb_effect` + satélite; schedules SQL **effects-only** (sem `phb_resource_grant`)
- **Não cobre:** gasto com efeito colateral (usar `temp_hp`/`heal` com `on_resource_spend`)

### `combat_mod`

- **Semântica:** bônus de PV / defesa sem armadura.
- **Satélite:** `phb_effect_combat_mod`
- **SSOT:** `phb_effect` + satélite; views HP/UD/heritage leem só efeitos (sem `phb_combat_modifier`)
- **Cap. 6:** Bestial Vigor (`gh-transformation-lycanthrope`, gate `stage3Boon=bestial-vigor`) — `hp_bonus` +1/nível via `loadTransformationHitPointsBonus`

### `temp_hp` (Fase 2)

- **Semântica:** aplica PV temporários (ficha) ao disparar.
- **Satélite:** `phb_effect_numeric` (+ opcional `phb_effect_note`)
- **Trigger:** `on_resource_spend` ou `on_table_action`
- **Serviço:** `applyTemporaryHitPoints`

### `heal` (Fase 2)

- **Semântica:** cura PV na ficha.
- **Satélite:** `phb_effect_numeric` (+ note)
- **Trigger:** `on_resource_spend` / `on_table_action`
- **Fórmulas:** `dice_hit_die_plus_pb` (Médico de Combate); `dice_2d4_plus_flat` (Clemência Divina — flat = mod de conjuração via `flatOverride`)

### `spend_resource` (Fase 2)

- **Semântica:** gasta N do pool no clique de mesa.
- **Campos no núcleo:** `resource_slug`; amount em `phb_effect_numeric.flat`
- **Trigger:** `on_table_action`
- **UI:** `phb_class_economy_action` continua sendo o botão; efeito executa o gasto

### `table_note` (Fase 2)

- **Semântica:** só nota para a mesa (declare efeito).
- **Satélite:** `phb_effect_note`; opcional `phb_effect_numeric` quando o declare tem valor tipado (ex.: 10 PV/turno da Cura Profana) — devolve `total` sem apply na ficha
- **Trigger:** `on_table_action`

### `combat_note` (lote origem)

- **Semântica:** texto jogável para Passivas / notas de combate.
- **Satélite:** `phb_effect_note`
- **Trigger:** `passive`
- **Serviço:** merge em `featCombatNotes` (catálogo ∪ mapa legado deprecated)

### `initiative_pb` (lote origem)

- **Semântica:** +PB na iniciativa (Alerta).
- **Satélite:** nenhum
- **Trigger:** `passive` / `on_build`
- **Serviço:** `hasInitiativePbFromEffects` / `initiativeBonus` (sem fallback por slug `alert`)

### `grant_inspiration` (lote origem)

- **Semântica:** liga inspiração no PC (`state.inspiration = true`); nota para aliados.
- **Satélite:** `phb_effect_note` opcional
- **Trigger:** `on_table_action` (Músico) ou **`on_rest_long`** (Humano Eficiente)
- **Exemplo:** Músico — canção; Humano — ao completar DL

### `grant_feat` (espécie)

- **Semântica:** no build, concede feat escolhido (`option_key` ↔ speciesChoice / featOptions); filtro `feat_category` (ex. `origin`).
- **Satélite:** `phb_effect_feat`
- **Trigger:** `on_build`
- **Serviço:** `featSlugsFromEffects` → merge na lista efetiva de feats (Humano Versátil)
- **Não:** inject legado hardcode por slug de espécie

### `save_advantage` (espécie)

- **Semântica:** vantagem em salvaguarda — `ability_slugs[]` e/ou `condition_slug` (poisoned, charmed, frightened, …).
- **Satélite:** `phb_effect_save_advantage`
- **≠** `check_advantage` (teste skill/ação/ferramenta)

### `reroll_d20_on_nat1`

- **Semântica:** em Teste D20 com nat1, rerrola e usa o novo resultado.
- **Trigger:** `on_d20_nat1`
- **Exemplo:** Halfling Sorte
- **≠** `modify_d20_roll` (±dados, Fate)

### `reach_bonus`

- **Semântica:** +N ft de alcance corpo a corpo; `exclude_property_slugs` opcional.
- **Satélite:** `phb_effect_reach`
- **Exemplo:** Geppettin marionete

### `rest_quirk`

- **Semântica:** DL em N horas; flags `no_sleep`, `magic_cannot_force_sleep`, `no_food_drink_air`.
- **Satélite:** `phb_effect_rest_quirk`
- **Exemplos:** Transe élfico; Natureza de Construto

### `environmental_immunity`

- **Semântica:** imune a hazard ambiental (`extreme_cold` / `extreme_heat` / `high_altitude` / …).
- **Satélite:** `phb_effect_environmental_immunity`
- **≠** `damage_resistance`

### `speed_set`

- **Semântica:** define walk absoluto (ft) — sobrescreve bônus relativos quando presente.
- **Satélite:** `phb_effect_numeric` (`fixed` = ft)
- **Exemplo:** Elfo Silvestre 35 ft (10,5 m)

### `grant_proficiency` (lote origem)

- **Semântica:** concede perícia/ferramenta/instrumento a partir de `option_key` (escolha na ficha).
- **Satélite:** `phb_effect_proficiency` (`option_key`, `proficiency_kind`)
- **Trigger:** `on_build`
- **Escolha** continua em `phb_option_def` / `featOptions`; o efeito é o **verbo**.
- **Exemplos:** skilled `proficiency1..3`; artisan `artisanTool*`; musician `musicalInstrument*`

### `purchase_discount` (lote origem)

- **Semântica:** desconto percentual na loja.
- **Satélite:** `phb_effect_purchase_discount` (`percent_off`, `non_magic_only`, `food_drink_only`)
- **Trigger:** `on_purchase` (consultado no checkout)
- **Exemplo:** Artesão — 20% em itens não mágicos; Brewer — 50% em comida/bebida (`food_drink_only`, poções inclusas)
- **Wire:** `purchaseDiscountPercentFromEffects` + `isFoodDrinkPurchaseItem`

### `damage_reroll_choice` (lote origem)

- **Semântica:** ao marcar toggle no dano, rola o pacote de dano da arma **duas vezes**; API devolve ambos; jogador escolhe.
- **Satélite:** nenhum (elegibilidade = presença do efeito)
- **Trigger:** `on_damage_roll` / `passive`
- **DTO:** `savageAttacker` em roll-damage; resposta com `alternateRolls`
- **1×/turno:** honor system (nota); enforcement rígido = backlog

### `damage_die_override` (lote origem)

- **Semântica:** substitui o dado de dano de um escopo (ex. desarmado → 1d4).
- **Satélite:** `phb_effect_damage_die` (`applies_to`, `die`)
- **Trigger:** `passive` (build do ataque)
- **Exemplo:** Briguento de Taverna — `unarmed` / `1d4`

### `check_advantage` (espécie / origem)

- **Semântica:** vantagem em teste sob perícia, atributo e/ou circunstância.
- **Satélite:** `phb_effect_check_advantage` (`skill_slug`, `circumstance_tag`, `ability_slug` — ao menos um)
- **Trigger típico:** `passive`
- **Gate opcional:** `requires_option_key` / `requires_option_value` no núcleo

### `grant_sense`

- **Semântica:** concede sentido tipado com alcance (e duração opcional).
- **Satélite:** `phb_effect_sense` (`sense_slug`, `range_ft`, `duration_minutes`)
- **Trigger típico:** `passive` / `on_build`

### `grant_language`

- **Semântica:** concede idioma fixo e/ou escolha via `option_key` (`choice_count`).
- **Satélite:** `phb_effect_language` (`option_key`, `language_slug`, `choice_count`)
- **Trigger típico:** `on_build`

### `damage_resistance`

- **Semântica:** resistência **passiva** a tipo de dano (fixo ou via opção).
- **Satélite:** `phb_effect_damage_type` (`damage_type_slug` e/ou `option_key`)
- **Trigger típico:** `passive`
- **Não cobre:** resistência por reação (`damage_resistance_reaction`)

### `grant_feat` (espécie)

- **Semântica:** concede talento via escolha (`option_key`) numa categoria (ex. `origin`).
- **Satélite:** `phb_effect_feat` (`option_key`, `feat_category`)
- **Trigger típico:** `on_build`

### `save_advantage` (espécie)

- **Semântica:** vantagem em salvaguarda vs condição e/ou atributos listados.
- **Satélite:** `phb_effect_save_advantage` (`condition_slug` e/ou `ability_slugs[]`)
- **Trigger típico:** `passive`

### `reroll_d20_on_nat1`

- **Semântica:** presença = elegível a rerrolar d20 em nat 1 (honor/wire incremental).
- **Satélite:** nenhum
- **Trigger típico:** `on_d20_nat1` / `passive`

### `reach_bonus`

- **Semântica:** +N ft de alcance de arma corpo a corpo (exclusões opcionais por property).
- **Satélite:** `phb_effect_reach` (`bonus_ft`, `exclude_property_slugs`)
- **Trigger típico:** `passive`

### `speed_set`

- **Semântica:** define deslocamento de caminhada (walk) em ft — não é bônus relativo.
- **Satélite:** `phb_effect_numeric.flat` = walk_ft (`amount_formula = fixed`)
- **Trigger típico:** `passive` / `on_build`

### `rest_quirk`

- **Semântica:** quirks de descanso (horas de DL, sem sono/comida, magia não força sono).
- **Satélite:** `phb_effect_rest_quirk`
- **Trigger típico:** `passive` / `on_rest_long`

### `environmental_immunity`

- **Semântica:** imunidade a hazard ambiental tipado.
- **Satélite:** `phb_effect_environmental_immunity` (`hazard_slug`)
- **Trigger típico:** `passive`

### Stubs Fase 5 (seed/wire incremental)

Status de todos abaixo: **Fase 5 — seed/wire incremental**. Satélite + serviço no mesmo PR que o primeiro seed.

| Kind | Semântica (resumo) | Trigger típico | Exemplos (inventário) |
|------|--------------------|----------------|------------------------|
| `check_advantage` | Vantagem em teste (`phb_effect_check_advantage`) | `passive` / offer | Bloodhound, Survivor, Sobreviver, Volund, Well-versed |
| `damage_bonus` | Flat/PB extra no dano (`phb_effect_numeric`) | `passive` / `on_damage_roll` | GWM, Dueling, canais NL |
| `scaled_damage_dice` | Dados extras por nível (1d4 → 2d4@9 → 4d4@16) | `on_damage_roll` | Syndicate Golpe Rápido |
| `add_proficiency_bonus` | Soma PB (ou PB extra) a um Teste d20 / atributo | offer / `on_table_action` | Sif, Thor, Norn favor |
| `death_save_advantage` | Vantagem em Salvaguardas contra Morte sob condição | `on_death_save` | Deathbound |
| `hit_die_roll_twice_keep_high` | Ao gastar DV no descanso, rola 2× e fica com o maior | `on_rest_short` | Deathbound |
| `reduce_exhaustion_on_rest` | Reduz nível(is) de Exaustão no DC/DL | `on_rest_short` / `on_rest_long` | Survivor |
| `grant_expertise` | Expertise na perícia/ferramenta se já proficiente (ou via opção) | `on_build` | Loki, Wotan |
| `grant_language` | Concede idioma (`phb_effect_language`) | `on_build` | Jormungandr / espécies |
| `spellcasting_ability` | Fixa atributo de conjuração dos grants do owner | `on_build` | Bênçãos NL |
| `grant_spell_by_level` | Concede magia escolhida de um nível (lista/escola livre) | `on_build` | Wotan (1º) |
| `damage_resistance_reaction` | Reação: Resistência a tipo de dano por janela | reação / resource | Boreas, Jormungandr |
| `damage_reduce_reaction` | Reação: reduz dano flat/fórmula (PB+mod) | reação | Baldur |
| `stabilize_on_death_save` | Estabiliza (ou evita morte) gastando resource | `on_resource_spend` | Eir |
| `grant_magic_item_choice` | No build: escolha de item mágico (raridade) | `on_build` | Collector |
| `identify_magic_item` | Estudar item → propriedades (regras de erro) | `on_table_action` | Collector |
| `vehicle_check_advantage` | Vantagem em Testes d20 de operação de veículo (escopo) | `passive` | Fisher |
| `advantage_until_consumed` | Vantagem em ataques/testes até consumir (janela de turno) | `passive` / toggle | Northern Raider |
| `extra_melee_attack_on_crit` | Crítico corpo a corpo → ataque corpo a corpo extra | `passive` | Sea wolf |
| `craft_item_on_long_rest` | Após DL: produz item/consumível (hidromel, …) | `on_rest_long` | Brewer |
| `choose_ability_for_check` | Permite qualquer atributo em teste/ação escopada | `passive` / `on_build` | Inquisitor |
| `initiative_advantage_vs_target` | Vantagem em iniciativa vs alvo marcado (duração) | `passive` | Inquisitor |

## Fase 6 — generals (stubs / seed parcial)

Kinds adicionados no baseline (`effect_kind`). Seeds: `database/seeds/effects/E001`–`E005`. Residual UI → [`../plans/backlog.md`](../plans/backlog.md).

| Kind | Semântica (resumo) | Status |
|------|--------------------|--------|
| `increase_ability_score` | ASI / meio-talento (+fixed/choice/asi_distribution) | stub — build ainda via options |
| `speed_bonus` | +N ft walk (UI métrica) | wire ficha |
| `grant_climb_speed` / `grant_swim_speed` | Desloc. escalada/natação | seed+note |
| `dash_speed_bonus` | +N no Dash | seed Charger |
| `ac_bonus` | Bônus CA (toggle/gate) | `featAcBonus` + UI sticky |
| `succeed_failed_save` | Falha→sucesso gastando resource | seed Mage Slayer |
| `extra_melee_attack` | Ataque C/C extra | seed+note |
| `grant_sense` | Sentido tipado + alcance (`phb_effect_sense`) | seed Skulker / espécies |
| `grant_weapon_property` | Prop. na peça (`phb_effect_weapon.property_slug`) | merge `light`/`returning` |
| `override_weapon_range` | Alcance normal/longo ft (`phb_effect_weapon.range_*`) | Spear Expert 30/90 |
| `damage_die_floor` | 1→2 no dano | DTO `damageDieFloor` |
| Demais T004 (flip, explode, Flex, bind, …) | Flags/`featEffectFlags` + residual UI | ver multi.md |

## Fase 6b — fighting-style / epic-boon

Seeds: `database/seeds/effects/E001`/`E003`/`E004`. ENUM no baseline. Residual gates/UI → [`../plans/backlog.md`](../plans/backlog.md).

| Kind | Semântica (resumo) | Status |
|------|--------------------|--------|
| `grant_fly_speed` | Desloc. de Voo (+hover na note) | seed Perfect Flight |
| `damage_resistance` | Resistência **passiva** (`phb_effect_damage_type`) | seed Energy / Night Spirit / espécies |
| `grant_all_skill_proficiencies` | Todas as perícias | seed Skill Proficiency |
| `miss_becomes_hit` | Erro→acerto; offer+toggle | seed Combat Prowess |
| `heal_bonus` | Extra PV ao recuperar | seed Fortitude |
| `slot_refund_on_die_match` | dX = círculo → não gasta slot | seed Spell Recall |
| `survive_at_zero` | A 0: 1 PV + cura tipada | seed Recovery |
| `teleport_after_action` | Teleporte após Atacar/Magia | seed Dimensional |
| `modify_d20_roll` | ±dados no Teste D20 | seed Fate |
| `redirect_damage_reaction` | Reação redireciona dano | seed Energy |
| `bonus_action_disengage` | BA Desengajar (+fim Imobilizado) | seed Speed |
| `slow_fall` | Cap taxa de queda | seed Perfect Flight |
| `extra_damage_on_nat20` | Nat20 → +dano (fórmula attr) | seed Irresistible |
| `heal_from_dice_pool` | Gastar N dados do pool → cura = soma | seed Recovery; reuso Zelote / Celestial |
| `damage_die_floor` + `flat` | Piso de face (GWF = 3) | seed GWF; wire DTO ainda 1→2 |

FS: **sem** kind novo exclusivo — reuso `attack_bonus` / `ac_bonus` / `light_bonus_ability_mod` / …

## Irredutíveis (sem kind)

Metamagia, forma selvagem, toggle de fúria, fluxos com UI especial — handler dedicado até haver verbo honesto.

## Regra de evolução

1. Três ocorrências da mesma regra → candidato a kind.
2. Kind sem serviço + linha no read-path (kind→consumidor) no mesmo PR → bloqueia merge.
3. Preferir reuso / `combat_note` quando couber; kinds de espécie OK com trio schema+entity+docs (ver read-path).
4. Tabelas legadas `phb_resource_grant` / `phb_combat_modifier` já **DROP** — novo grant/mod só via `phb_effect` + satélite.
