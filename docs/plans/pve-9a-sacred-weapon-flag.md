# PVE-9a — Sacred Weapon → toggle_combat_flag

**Status:** feito · **Dep:** PVE-0 (fraca; pode paralelizar) · **Tam:** M · **Índice:** [`pve-skirmish-index.md`](pve-skirmish-index.md)

## Skills / rules

`catalog-sql-first` · `postgresql-sql` · `typeorm` · `nestjs` · `typescript` · `dry` · `testing`  
`catalog-sql-first.mdc` · `adr-effect-engine.md` · `effect-dictionary.md` · read-path

## Escopo

- Ampliar `phb_effect_combat_flag` além de `rage`/`reckless` → `sacred_weapon`
- Seed + apply genérico; remover branch `oath-channel` em `apply-one-effect-table.ts`
- Remover early-route `end-sacred-weapon` do handler paladino

## DoD

- [x] Sacred Weapon só via `toggle_combat_flag` + coluna
- [x] Specs toggle + regressão Fúria/Reckless
- [x] Dictionary + read-path atualizados

## Entrega

- Schema/entity: `flag IN (…, 'sacred_weapon')`
- Apply: `force_enter=true` liga / `false` desliga
- Seeds: Devoção `oath-channel` + `end-sacred-weapon` (economy/panel/effect)
- Removidos hardcodes em `apply-one-effect-table` e `paladin-actions.handler`
