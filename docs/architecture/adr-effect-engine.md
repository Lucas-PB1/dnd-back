# ADR: motor de efeitos (`phb_effect`)

| Campo | Valor |
|-------|--------|
| Status | **Aceito** — DROP legado fechado |
| Data | 2026-09-04 |
| Contexto | Catálogo descreve conteúdo; regras de mesa/build repetidas em handlers TS e heurísticas |
| Residual mesa | [`../plans/effect-mesa-checklist.md`](../plans/effect-mesa-checklist.md) · [`../plans/backlog.md`](../plans/backlog.md) |
| Dicionário | [`effect-dictionary.md`](effect-dictionary.md) |
| Read-path (DX) | [`effect-engine-read-path.md`](effect-engine-read-path.md) |

## Contexto

Queremos autorar traços (talento, espécie, classe, item, heritage) como **composição de verbos** tipados: seed declara efeitos; serviços genéricos executam. Migração incremental **concluída** para grants/combat_mod (DROP + limpeza dual-read); handlers irredutíveis e residual de mesa seguem por checklist.

## Decisão

1. Tabela unificada `rpg.phb_effect` (`kind` + `owner` + `trigger` + portões comuns).
2. **Satélites tipados** por família de params (`phb_effect_spell`, `phb_effect_cast_economy`, `phb_effect_numeric`, …) — **sem** JSONB como SSOT mecânico.
3. Dicionário fechado de `kind` (doc vivo); kind novo = satélite + serviço + entrada no dicionário no mesmo PR.
4. Runtime em `src/game/effects/` (loader + executor por kind).
5. Irredutíveis (metamagia, forma selvagem de druida, fluxos com UI especial) permanecem em handlers até existir kind honesto. Toggle de Fúria/Imprudente e companion de mesa usam kinds genéricos (`toggle_combat_flag`, `sync_companion`, `companion_command`).

### Irredutíveis residual (PVE-9b inventário)

`apply-one-effect-*`: **zero** `actionSlug ===` (fechado).

| Local | Entradas | Destino |
|-------|----------|---------|
| `flat-override.ts` | flats por fórmula/classe + outliers (`armor-regen`, `wild-recovery`, `arcane-ward`, `heroic-soul`, `spell-thief`, …) | tipar via `amount_formula` / ability-source no satélite (PVE-10a/LEG) |
| `slug-early-routes.ts` | validação de input (`healing-light`, `bastion-of-law`, `natural-recovery-*`, `recover-risk`) | gates tipados ou DTO refine |
| `structured-kind-catalog-handlers.ts` | kinds structured com branch de slug (`set_tracker`, `resource_fallback_spend`, wild shape, …) | satélite de tracker / opções |
| `run-declared-effects-loop.ts` | `dungeon-precaution`, `spectral-summon` / `fey-reinforcements` | kind dedicado ou PVE-10a |

## Anti-padrões

- JSONB de regra de jogo
- Kind coringa `custom` / `script`
- Migrar handler complexo só para “progresso”
- Endpoint HTTP novo por efeito
- Front recalcular efeito

## Consequências

**Positivas:** menos `case` por slug; novos traços similares = seed; SSOT de economia de cast/gasto.

**Custos:** dicionário é produto contínuo; residual de mesa por categoria. Dual-read / tabelas `phb_resource_grant` + `phb_combat_modifier` — **histórico** (DROP feito; não há convívio no schema vivo).

## DoD Fase 0

- [x] Este ADR + dicionário v0
- [x] DDL `phb_effect` + satélites piloto (+ kinds previstos nas fases seguintes)
- [x] Módulo stub `game/effects` com teste de loader
- [x] DROP `phb_resource_grant` / `phb_combat_modifier` + limpeza dual-read / MV espécie
