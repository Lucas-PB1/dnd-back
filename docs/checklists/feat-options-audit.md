# Auditoria — opções de talentos (S022)

Gerado em 2026-07-21 por `npm run db:audit:feat-options`.

## Resumo

| Métrica | Valor |
| --- | --- |
| Benefícios com texto de escolha (S022) | 27 talentos |
| Com `phb_feat_option_def` (seeds S075+ / D002–D010) | 24 |
| Escolha só em combate/descanso (ignorados) | 3 |
| Lacunas na criação de ficha | 0 |

## Magias em talentos (tipo `spell` / ritual dinâmico)

- **magic-initiate**: `cantrip1`, `cantrip2`, `castingAbility`, `firstLevelSpell`, `spellList`
- **ritual-caster**: `abilityIncrease` (+ slots `ritualSpell*` por BP na API)
- **fey-touched**: `abilityIncrease`, `bonusSpell`, `castingAbility`
- **shadow-touched**: `abilityIncrease`, `bonusSpell`, `castingAbility`
- **telekinetic**: `abilityIncrease`, `castingAbility`
- **telepathic**: `abilityIncrease`, `castingAbility`

## Cobertos

- [x] `ability-score-improvement` — distributionMode, primaryAbility, secondaryAbility
- [x] `artisan` — artisanTool1, artisanTool2, artisanTool3
- [x] `boon-of-combat-prowess` — abilityIncrease
- [x] `boon-of-dimensional-travel` — abilityIncrease
- [x] `boon-of-energy-resistance` — abilityIncrease, resistanceType1, resistanceType2
- [x] `boon-of-fate` — abilityIncrease
- [x] `boon-of-fortitude` — abilityIncrease
- [x] `boon-of-recovery` — abilityIncrease
- [x] `boon-of-skill-proficiency` — abilityIncrease, expertiseSkill
- [x] `boon-of-speed` — abilityIncrease
- [x] `boon-of-the-night-spirit` — abilityIncrease
- [x] `boon-of-truesight` — abilityIncrease
- [x] `elemental-adept` — abilityIncrease, damageType
- [x] `fey-touched` — abilityIncrease, bonusSpell, castingAbility
- [x] `keen-mind` — abilityIncrease, vastKnowledgeSkill
- [x] `magic-initiate` — cantrip1, cantrip2, castingAbility, firstLevelSpell, spellList
- [x] `musician` — musicalInstrument1, musicalInstrument2, musicalInstrument3
- [x] `observant` — abilityIncrease, attentiveSkill
- [x] `resilient` — abilityIncrease
- [x] `ritual-caster` — abilityIncrease
- [x] `shadow-touched` — abilityIncrease, bonusSpell, castingAbility
- [x] `skill-expert` — abilityIncrease, expertiseSkill, newSkill
- [x] `skilled` — proficiency1, proficiency2, proficiency3
- [x] `weapon-master` — abilityIncrease, masteryWeapon

## Ignorados (escolha situacional, sem opção na ficha)

- [ ] `charger` — escolha no momento de uso
- [ ] `inspiring-leader` — escolha no momento de uso
- [ ] `shield-master` — escolha no momento de uso

## Lacunas

_Nenhuma lacuna mecânica na criação._

## Fontes de defs

- Seeds: `S075`–`S078` (S078 espelha D002–D010)
- Migrations: `database/migrations/050_data/D002`–`D010`
- ASI em massa: `D003` (gerado por `npm run db:generate:feat-asi`)
