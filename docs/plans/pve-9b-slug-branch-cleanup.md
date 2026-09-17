# PVE-9b — Zerar slug branches (apply / flat-override)

**Status:** aberto · **Dep:** PVE-9a · **Tam:** L · **Índice:** [`pve-skirmish-index.md`](pve-skirmish-index.md)

## Skills / rules

`catalog-sql-first` · `nestjs` · `typescript` · `dry` · `solid` · `testing`  
`game-folder-conventions.mdc` · `file-size.mdc` · `adr-effect-engine.md`

## Escopo

- Tipar ou remover: `feral-howl`, `psychic-teleport`, `psychic-whispers`, `arcane-ward-recharge`
- Inventariar `flat-override.ts` / `slug-early-routes.ts` / structured slug branches
- Cada entrada → kind genérico, structured kind, ou irredutível documentado no ADR

## DoD

- [ ] `rg "actionSlug ===" apply-declared-economy` → zero em apply-one-effect-\* **ou** lista ≤N irredutíveis no ADR
- [ ] Specs das features tipadas
