# Como ler um efeito (caminho feliz)

Guia de DX do motor `phb_effect`. Meta: em ~2 minutos responder “este talento → quais efeitos → onde aparece na ficha/mesa”.

ADR: [`adr-effect-engine.md`](adr-effect-engine.md) · Dicionário: [`effect-dictionary.md`](effect-dictionary.md) · Residual mesa: [`../plans/effect-mesa-checklist.md`](../plans/effect-mesa-checklist.md)

## Porta pública

Código **fora** de `src/game/effects/` importa só:

```ts
import {
  LoadEffectCatalog,
  executeCatalogEffect,
  styleOrFeatNumericBonus,
  // …
} from '@game/effects';
```

Não importe `domain/queries/*` nem `infrastructure/*` de fora deste pacote.

Política: intenção e fluxo deste motor vivem **neste doc** (+ dicionário/ADR) — sem JSDoc/`--` narrativos no TS/SQL do pacote.

| Camada | Onde | Papel |
|--------|------|--------|
| Seed | `database/seeds/effects/E00*.sql` | Verb + satélite no Postgres |
| Load | `LoadEffectCatalog` | Rows → `CatalogEffect[]` |
| Query | `@game/effects` (`domain/queries/`) | Perguntas tipadas (CA, dano, perícia…) |
| Execute | `executeCatalogEffect` | Só kinds allowlisted (heal, temp_hp, …) |
| Schedule | SQL effects-only | Pools / HP / UD via `phb_effect` + satélites (sem dual-read) |

Queries agrupadas por pergunta humana:

| Pasta | Pergunta |
|-------|----------|
| `queries/combat-bonus` | Quanto de ataque/dano este estilo/talento dá? |
| `queries/combat-flags` | CA, propriedades de arma, flags de dado/crítico? |
| `queries/skills` | Quais perícias/expertise o catálogo concede? |
| `queries/sheet` | Iniciativa, speed, notes, desconto, unarmed die? |
| `queries/cast` | Economia de cast / filtros por trigger? |

## Fluxo em 4 passos

```
seed SQL  →  LoadEffectCatalog.execute(...)  →  CatalogEffect[]
                                                    ↓
                              query (sheet/combat/…)  ou  executeCatalogEffect
                                                    ↓
                              DTO ficha / slice combate / spend de mesa
```

1. **Ache o seed** em `database/seeds/effects/` (`E001` PHB, `E002` SEH, …) pelo slug do feat.
2. **Veja `kind` + satélite** (resource, numeric, note, …) e `trigger`.
3. **Ache a query** na tabela kind→consumidor abaixo (ou em `domain/queries/`).
4. **Ache o call site** (combat slice, sheet stats, purchase, session spend).

## Exemplo 1 — Lucky (`lucky`)

**Seed:** [`E001_phb.sql`](../../database/seeds/effects/E001_phb.sql) (bloco `lucky`)

| Campo | Valor |
|-------|--------|
| `kind` | `grant_resource` |
| Satélite | `phb_effect_resource` → `luckPoints`, max = PB, recover LR |
| `trigger` | `on_build` |

**Runtime**

1. `LoadEffectCatalog` com `ownerKind: 'feat'`, slugs dos feats do PC.
2. Schedule effects-only (`feat-resource-schedule.queries`) lê `grant_resource` / `phb_effect_resource`.
3. Na ficha: pool **Pontos de Sorte** (máx = PB). Gasto = botão economy / use-resource (não é query tipada de combate).

**Resposta rápida:** Lucky → 1 efeito `grant_resource` → resource panel da ficha; sem bônus de ataque/CA.

## Exemplo 2 — Dueling (`dueling`)

**Seed:** [`E001_phb.sql`](../../database/seeds/effects/E001_phb.sql) (bloco `dueling`)

| Campo | Valor |
|-------|--------|
| `kind` | `damage_bonus` |
| Satélite | `phb_effect_numeric` flat `2` |
| `trigger` | `on_damage_roll` |

**Runtime**

1. Mesmo load de efeitos de feat (estilos de luta são feats no catálogo).
2. Query: `styleOrFeatNumericBonus({ ownerSlug: 'dueling', kind: 'damage_bonus', … })` em `damage-bonuses.ts`.
3. Gate de “uma arma corpo a corpo na mão” permanece no domínio de combate (não no seed).
4. DTO: bônus de dano do ataque equipado (+2 quando o gate passa).

**Resposta rápida:** Dueling → `damage_bonus` +2 → `styleOrFeatNumericBonus` → linha de dano do ataque.

## Kind → satélite → função TS → call sites

Inventário vivo dos kinds **com wire tipado**. Kinds só-seed/`combat_note` ficam no dicionário sem linha aqui até haver consumidor.

| Kind | Satélite | Função / bridge | Call sites típicos |
|------|----------|-----------------|-------------------|
| `grant_resource` | `phb_effect_resource` | schedule SQL effects-only | feat/class/subclass/item/species resources |
| `combat_mod` | `phb_effect_combat_mod` | views HP/UD + loaders | HP max / unarmored defense |
| `grant_proficiency` / `grant_all_skill_proficiencies` / `grant_expertise` | `phb_effect_proficiency` | `fixedSkillSlugsFromEffects`, `expertiseSkillSlugsFromEffects`, `proficiencyOptionKeysFromEffects` | `collect-skill-slugs` |
| `initiative_pb` | — | `hasInitiativePbFromEffects` | `resolve-initiative-roll` |
| `purchase_discount` | `phb_effect_purchase_discount` | `purchaseDiscountPercentFromEffects` | purchase handler |
| `damage_reroll_choice` | — | `hasDamageRerollChoice` | roll-damage / flags |
| `damage_die_override` | `phb_effect_damage_die` | `unarmedDamageDieFromEffects` | combat slice |
| `attack_bonus` / `damage_bonus` | `phb_effect_numeric` | `styleOrFeatNumericBonus`, `flatDamageBonusFromEffects` | attack/damage-bonuses |
| `scaled_damage_dice` | — (kind) | `scaledDamageDiceFromEffects` | damage extras |
| `ac_bonus` | `phb_effect_numeric` | `acBonusFromEffects` / `styleOrFeatNumericBonus` | armor-class / slice |
| `speed_bonus` | `phb_effect_numeric` | `speedBonusMetersFromEffects` | derived stats |
| `grant_weapon_property` / `override_weapon_range` | `phb_effect_weapon` | `grantedWeaponPropertySlugsFromEffects`, `overrideWeaponRangeFtFromEffects` | weapon attacks |
| `damage_die_floor` / flip / explode / … | — | `hasDamageDie*` / flags assemble | combat slice / dice |
| `grant_spell` / `free_cast` / `grant_spell_by_level` | spell + cast_economy | `resolveFeatCastEconomyFromEffects` / `resolveSpeciesSpellCastEconomyFromEffects` | spellcasting economy |
| espécies passivas | note / sense / resistance / … | `speciesPassiveNotesFromEffects` | combat notes (SSOT effects) |
| `temp_hp` / `heal` / `spend_resource` / `recover_resource` / `recover_resource_to_max` / `toggle_combat_flag` / `sync_companion` / `companion_command` / `table_roll` / `feature_dc` / `heal_from_dice_pool` / `grant_inspiration` | numeric/note/dice/flag/companion | `executeCatalogEffect` + `applyDeclaredEconomyTableAction` | session spend / table-action |

| `combat_note` / `table_note` + note satélite | `phb_effect_note` | `combatNotesFromEffects` | passivas combate |
| `grant_sense` | `phb_effect_sense` | `sensesFromEffects` | sheet / combat notes |
| `damage_resistance` | `phb_effect_damage_type` | `damageResistancesFromEffects` | sheet / combat |
| `grant_language` | `phb_effect_language` | `languageChoiceCountFromEffects` | sheet languages (espécie ×2) |
| `check_advantage` | `phb_effect_check_advantage` | satélite + note | checks / sheet |
| `grant_feat` | `phb_effect_feat` | `featSlugsFromEffects` | create origin / Versátil |
| `save_advantage` | `phb_effect_save_advantage` | satélite | saves |
| `reroll_d20_on_nat1` | — | `hasRerollD20OnNat1` | d20 rolls |
| `reach_bonus` | `phb_effect_reach` | `reachBonusFtFromEffects` | weapon reach |
| `speed_set` | `phb_effect_numeric` (flat = walk_ft) | `speedSetFeetFromEffects` | derived speed |
| `rest_quirk` | `phb_effect_rest_quirk` | `restQuirkFromEffects` | rest rules |
| `environmental_immunity` | `phb_effect_environmental_immunity` | satélite | hazards |
| `grant_inspiration` (`on_rest_long`) | note opcional | long rest SQL | `applyLongRestState` |
| `combat_note` species | `phb_effect_note` | `combatNotesFromOwnerEffects` | assemble combat slice |
| `grant_resource` species | `phb_effect_resource` | `loadSpeciesResourceSchedule` | session resources |
| `combat_mod` species | `phb_effect_combat_mod` | `loadHitPointsBonusSources` + gates | HP max |

Semântica completa: [`effect-dictionary.md`](effect-dictionary.md).

## Freeze de kinds novos

Preferir reuso de kind existente ou `combat_note` / `table_note`. Kind novo no mesmo PR = ENUM + satélite (se params) + linha no dicionário + **linha nesta tabela** + query/call site quando o wire existir.

**Espécie:** migração em andamento — kinds/satélites novos de espécie são OK desde que o trio schema + entity + docs (dicionário + esta tabela) acompanhe o PR.

## Checklist “2 minutos”

- [ ] Seed do slug aberto
- [ ] Kind + satélite anotados
- [ ] Função na tabela acima
- [ ] Um call site aberto (sheet **ou** combat **ou** session)
