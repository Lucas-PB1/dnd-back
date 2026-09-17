# PVE-10b — /legado + DoD 100%

**Status:** aberto · **Dep:** PVE-10a · **Tam:** M · **Índice:** [`pve-skirmish-index.md`](pve-skirmish-index.md)

## Skills / rules

`nestjs` · `typescript` · `dry` · `testing` · `okf`  
**Command:** [`/legado`](../../.cursor/commands/legado.md) — uma pasta por vez; não misturar feature no mesmo PR

**Relação com LEG-\*:** limpeza repo-wide vive em [`legado-cleanup-backlog.md`](legado-cleanup-backlog.md). Este pacote é o fechamento **pós-PVE** (combat/duel adapters + DoD 100% PVE), não substitui LEG-1…4.

## Escopo

### A — Código / docs mortos (escopo PVE)

- Varredura `/legado`: `src/game/combat`, adapters duel pós-migração, barrels órfãos
- Limpar “mapa legado deprecated” stale (`effect-dictionary`, OKF)
- Confirmar dual-read grants já morto (não reabrir)
- Registrar em `docs/okf/log.md`

### B — Critério 100%

| Critério | Evidência |
|----------|-----------|
| Magia ofensiva PHB tipada | auditoria PVE-2b |
| Zero escape hatch mesa | PVE-9 DoD |
| Deferred só VTT/XP | `combat-real-deferred.md` |
| Índice 0–10 fechado | pacotes apagados |
| `/legado` pastas limpas | log OKF |

## DoD

- [ ] Tabela `/legado` das pastas escopo sem morto
- [ ] `backlog.md` Feature futura: PVE completo **ou** só XP/VTT
- [ ] Apagar este pacote + 10a do índice
