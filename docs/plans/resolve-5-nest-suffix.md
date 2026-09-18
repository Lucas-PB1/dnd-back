# RES-5 — Sufixo Nest `*.resolver.ts`

**Status:** aberto · **Pai:** [`resolve-pattern-backlog.md`](resolve-pattern-backlog.md) · **Dep:** RES-2 (feito) · **Tam:** S

## Skills / rules

`nestjs` · `typescript` · `dry` · `testing` · `game-folder-conventions.mdc`

## Escopo

- Inventariar `*.resolver.ts` (`equipment-slot-resolver`, `template-image.resolver`, …)
- Decisão: manter sufixo Nest **ou** renomear para `*.service.ts` / helper de application se gerar confusão com verbo `resolve-*`
- Não quebrar DI; um PR cosmético no máximo

## DoD

- [ ] Decisão documentada no backlog pai ou OKF
- [ ] Se renomear: imports + specs verdes
- [ ] Apagar este `.md`
