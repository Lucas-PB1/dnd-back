# LEGAC-1 — Inventário + docs stale

**Status:** aberto · **Pai:** [`legac-pattern-backlog.md`](legac-pattern-backlog.md) · **Tam:** S

## Skills / rules

`okf` · `typescript` (só se tocar TSDoc) · `dry`

## Escopo

1. `rg -i 'legacy|legado|legac' docs/ src/ scripts/` — classificar: canônico | dívida | histórico OKF
2. Corrigir docs stale, em especial:
   - [`effect-dictionary.md`](../architecture/effect-dictionary.md) — “mapa legado deprecated” / dual-read se ainda parecer vivo
   - Qualquer doc que diga dual-read grants aberto (ADR já fechou)
3. Log curto em `docs/okf/log.md`

## Fora

- Apagar seeds/scripts (→ LEGAC-2/3)
- Renomear `infernal_legacy`

## DoD

- [ ] Inventário no log OKF
- [ ] Docs de arquitetura sem dual-read/mapa legado como se fossem código vivo
- [ ] Apagar este `.md`
