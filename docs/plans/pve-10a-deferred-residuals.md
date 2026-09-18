# PVE-10a — Residuals combat-real-deferred

**Status:** feito · **Dep:** PVE-8 + PVE-9b · **Tam:** L · **Índice:** [`pve-skirmish-index.md`](pve-skirmish-index.md)

## Skills / rules

`nestjs` · `typescript` · `catalog-sql-first` · `domain-driven-design` · `dry` · `testing`  
Docs: [`combat-real-deferred.md`](combat-real-deferred.md) · [`skirmish-residuals-pve-10a.md`](../architecture/skirmish-residuals-pve-10a.md)

## Escopo (checklist)

- [ ] Proteção Arcana: pool própria ≠ temp HP; Proteção Projetada — **defer** (L)
- [ ] Centelha Divina / Auxílio da Terra: dano + save no alvo — **defer**
- [x] PAM: ataque do cabo / reação tipada — **reativo nunca** (sem mapa); cabo **defer**
- [ ] Gunslinger manobras `descriptive` no acerto — **defer**
- [x] Atacante Selvagem: enforcement 1×/turno no servidor
- [x] Parry / redução de dano no hit
- [x] Bloodied gate / craft spawn — gate **defer**; craft **nunca** em combate
- [x] Skirmish: Second Wind / Action Surge via economy genérica (sem endpoint especial)

## DoD

- [x] Itens acima fechados **ou** “nunca”/defer com justificativa no deferred + doc
- [x] Specs dos residuals tipados
