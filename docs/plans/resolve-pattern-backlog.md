# Resolve — backlog de limpeza do padrão

**Status:** aberto · **Não é** mesa ficha · **Não renomear** o verbo canônico `resolve-*` de derive/compute

Índice PVE: [`pve-skirmish-index.md`](pve-skirmish-index.md) · Legado morto: [`legado-cleanup-backlog.md`](legado-cleanup-backlog.md)  
Convenção: [`.cursor/rules/game-folder-conventions.mdc`](../../.cursor/rules/game-folder-conventions.mdc) (`apply-…`, `resolve-…`, `load-…`)

## O que é (e o que não é)

| Tipo | Significado | Ação |
|------|-------------|------|
| **Verbo canônico** `resolve-*` | Derive/compute puro ou Nest thin (`ResolveEquippedArmorClass`, `resolve-spend-plan`, `resolve-effect-amount`, combat slice…) | **Manter** |
| **Resolver de mesa (legado)** | Módulo TS por classe / `switch` de `actionSlug` que a economy+effects substituiu | **Apagar** se morto; migrar se vivo |
| **Resolve hardcode** | `if (slug === …)` disfarçado de resolve (ex. duelo magia) | **Migrar** para catálogo / motor compartilhado |
| **Sufixo Nest** `*.resolver.ts` | Infra (`EquipmentSlotResolver`, `TemplateImageResolver`) | Opcional: alinhar nome; **não** misturar com limpeza de domínio |

~50 arquivos com `resolve` no nome sob `src/game/` — a maioria é **saudável**. Este backlog ataca só o legado / hardcode / duplicata.

## Skills / rules

`nestjs` · `typescript` · `domain-driven-design` · `dry` · `solid` · `testing` · `catalog-sql-first` (se migrar para effect) · `okf`  
Rules: `game-folder-conventions.mdc` · `file-size.mdc` · `typescript-docs.mdc` · `catalog-sql-first.mdc`  
Command `/legado` quando for pasta morta.

## Fila (fácil → difícil)

| # | Pacote | Doc | Tam. | Dep |
|---|--------|-----|------|-----|
| RES-1 | Inventário + docs (canônico vs legado) | [`resolve-1-inventory-docs.md`](resolve-1-inventory-docs.md) | S | — |
| RES-2 | Resolvers de mesa mortos (`session/actions`, `combat/domain/<classe>`) | [`resolve-2-mesa-resolvers.md`](resolve-2-mesa-resolvers.md) | M | RES-1 · overlap [`legado-2`](legado-2-combat-domain.md) |
| RES-3 | ~~Hardcode `duel-spell-resolve` → motor~~ **feito (= PVE-0)** | — | M | = PVE-0 |
| RES-4 | `maneuver-resolve` / BM `resolveBattleMasterTableRoll` → kinds tipados | [`resolve-4-maneuver-catalog.md`](resolve-4-maneuver-catalog.md) | L | PVE-5b / catalog |
| RES-5 | Naming Nest `*.resolver.ts` + barrels órfãos | [`resolve-5-nest-suffix.md`](resolve-5-nest-suffix.md) | S | RES-2 |

## Checklist residual conhecido

- [ ] Zero imports de “class action resolver” em `session/application/actions/**` (confirmar; OKF já removeu vários)
- [ ] `combat/domain/fighter/table-actions.ts` (`resolveBattleMasterTableRoll`) — vivo via `apply-catalog-maneuver`; migrar ou documentar como structured
- [ ] `session/domain/maneuver-resolve.ts` (Gunslinger) — vivo; candidatar catalog/kinds
- [x] `duel/domain/duel-spell-resolve.ts` — hardcode slug removido; reexport + conditions (PVE-0)
- [ ] Reexports finos tipo `campaign/domain/resolve-attack-vs-armor-class.ts` — ok (apontam combat); não apagar sem motivo
- [ ] DTOs HTTP `Resolve*AttackDto` — contrato; **não** são legado de mesa

## Anti-padrões deste backlog

- Renomear em massa `resolve-*` → `compute-*` / `get-*` (quebra convenção do repo)
- Apagar `ResolveEquipped*` / combat slice “porque tem resolve no nome”
- Misturar limpeza de naming com feature PVE no mesmo PR (exceto RES-3 = PVE-0)

## DoD da trilha

- [ ] RES-1…5 fechados (`.md` apagados) ou absorvidos em PVE/LEG com link
- [ ] Docs OKF/backlog distinguem “resolvers de mesa” vs “verbo resolve”
- [ ] Nenhum hardcode slug novo sob nome `resolve*`
