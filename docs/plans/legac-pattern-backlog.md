# Padrão `legac` / `legacy` — backlog

**Status:** fechado · **Não confundir** com [`legado-cleanup-backlog.md`](legado-cleanup-backlog.md) (código morto `/legado`)

Este backlog ataca o **padrão de nome/stub** `legacy` / `legado` / `legac` ainda espalhado em docs, seeds no-op e scripts — **não** o domínio PHB.

## Canônico (NÃO renomear / NÃO apagar)

| Padrão | Onde | Motivo |
|--------|------|--------|
| `infernal_legacy` / `infernalLegacyId` / slug `infernal-legacy` | enum, seeds, views, species TS | Regra PHB Tiefling |
| `legacy_2014_name_en` | MM conversion table | Mapa 2014→2024 |
| Prosa “Legado Ínfero” / lore “legacy” | seeds texto | Conteúdo jogável |
| Planos `legado-*.md` / command `/legado` | docs/plans, `.cursor/commands` | Trilha de limpeza (somem ao fechar) |

## Dívida (limpar)

| Tipo | Exemplos |
|------|----------|
| Docs stale | “mapa legado deprecated”, dual-read grants ainda citados como vivos |
| Seeds stub | `SELECT 1` / “Grants legado aposentado” ainda no `SEED_ORDER` |
| Scripts `legacy*` | `legacyBaselineDir`, `legacyPacks`, comentários “Basename legado” |
| TODOs SQL | “Remover slugs legados…” em economy/subclass |

## Skills / rules

`postgresql-sql` · `catalog-sql-first` · `typescript` · `dry` · `testing` · `okf`  
Rules: `catalog-sql-first.mdc` · `typescript-docs.mdc`  
Docs: `adr-effect-engine.md` (dual-read **fechado**), `sql-layout.md`, `effect-dictionary.md`

## Fila

| # | Pacote | Doc | Tam. | Dep |
|---|--------|-----|------|-----|
| LEGAC-1 | ~~Docs stale~~ **feito** | — | S | — |
| LEGAC-2 | ~~Seeds stub grants~~ **feito** | — | M | LEGAC-1 |
| LEGAC-3 | ~~Scripts `legacy*`~~ **feito** | — | S | LEGAC-1 |
| LEGAC-4 | ~~TODOs SQL slugs~~ **feito** | — | S–M | LEGAC-2 |

Overlap: texto “mapa legado” / dual-read — PVE-10b fechado no índice; residual docs stale → este backlog (LEGAC-1).

## Anti-padrões

- Renomear `infernal_legacy` → `infernal_heritage` (quebra enum/API/front)
- Renomear coluna `legacy_2014_*` sem migration de produto (e sem necessidade)
- Apagar planos `legado-*.md` antes do DoD da trilha LEG
- Misturar com feature PVE no mesmo PR

## DoD da trilha

- [x] `rg -i 'legado aposent|mapa legado deprecated|dual-read' docs/` limpo em architecture (exceto ADR histórico “DROP” + OKF) — LEGAC-1
- [x] Zero seed stub “Grants legado” no order — LEGAC-2
- [x] Scripts sem identificador `legacy*` **ou** renomeados com comentário claro (anti-pack / baseline) — LEGAC-3 (`rg` scripts/ = 0)
- [x] TODOs SQL “slugs legados” resolvidos ou movidos — LEGAC-4
- [x] Pacotes LEGAC-*.md apagados
