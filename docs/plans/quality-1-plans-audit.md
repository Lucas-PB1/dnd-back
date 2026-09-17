# QA-1 — Auditoria dos planos gerados

**Status:** aberto · **Pai:** [`quality-gate-backlog.md`](quality-gate-backlog.md) · **Dep:** — (pode rodar **já**) · **Tam:** S

## Skills / rules

`okf` · `dry` · [`docs/README.md`](../README.md) · [`style-guide.md`](../style-guide.md)

## Escopo

1. Percorrer [`pve-skirmish-index.md`](pve-skirmish-index.md) — cada link de pacote existe
2. Listar `docs/plans/{pve,db,legado,resolve,legac,quality}-*.md` — órfãos sem entrada no índice?
3. Checar skills/rules + DoD em cada filho
4. Checar conflitos: RES-3 ↔ PVE-0; LEGAC ↔ `infernal_legacy`; LEG ↔ LEGAC naming
5. Corrigir só **docs** (links quebrados, deps, texto); não executar código

## DoD

- [ ] Planilha ou checklist no PR / log OKF: link OK | órfão | corrigido
- [ ] Índice e `backlog.md` / `README` alinhados
- [ ] Apagar este `.md`
