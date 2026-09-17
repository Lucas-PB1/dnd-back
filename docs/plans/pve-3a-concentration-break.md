# PVE-3a — Quebra de concentração

**Status:** aberto · **Dep:** PVE-0 · **Tam:** M · **Índice:** [`pve-skirmish-index.md`](pve-skirmish-index.md)

## Skills / rules

`nestjs` · `typescript` · `domain-driven-design` · `dry` · `testing`  
`game-folder-conventions.mdc` · `file-size.mdc`

## Escopo

- Após dano em quem concentra: CD = max(10, dano/2) → Con save → break
- Break limpa `concentrating_on`, arena ligada, spirits (regras já parciais)

## DoD

- [ ] Specs sucesso/falha
- [ ] Integrado no pipeline `applyCombatantHpDamage` / skirmish
