# Plano — motor de efeitos

ADR: [`../architecture/adr-effect-engine.md`](../architecture/adr-effect-engine.md) · Dicionário: [`../architecture/effect-dictionary.md`](../architecture/effect-dictionary.md) · Read-path: [`../architecture/effect-engine-read-path.md`](../architecture/effect-engine-read-path.md) · Residual: [`backlog.md`](backlog.md)

## Meta

Catálogo orientado a verbos: `phb_effect` + satélites; runtime `@game/effects`; migração incremental.

**Três eixos (não misturar):**

| Eixo | Doc |
|------|-----|
| **Categoria** (o quê) | [`effect-mesa-checklist.md`](effect-mesa-checklist.md) |
| **Fonte** (qual livro) | [`effect-mesa-por-fonte.md`](effect-mesa-por-fonte.md) |
| **Fase** (ordem DROP) | **este arquivo** (§ Aberto / DoD) |

Completar mesa = categoria + fonte; fases DROP / dual-read **fechadas** (abaixo).

## Feito (não reabrir)

| Lote | Entrega |
|------|---------|
| Fases 0–3 | DDL, loader/executor, dual-read, piloto MI |
| Fase 4 | Origem PHB (`effects/E001`); legado feat limpo (exceto transform `J061`) |
| Fase 5 | Origem multi-fonte — `E002`/`E003`/`E004` + wire mínimo |
| Fase 6 | General multi-fonte — `T004` no baseline + `E001`…`E005` + wire tipado |
| Fase 6b | Fighting-style + epic-boon — no baseline + mesmos `E00*` |
| Gate DX | Read-path + porta `@game/effects` + freeze de kinds novos |

Inventários docs-first das fases 5–6b foram **apagados** (política plano concluído). Seeds em `database/seeds/effects/` + dicionário são o SSOT. Schema no baseline (sem forward migrations do motor).

## Aberto

Checklist por **categoria**: [`effect-mesa-checklist.md`](effect-mesa-checklist.md) · por **fonte**: [`effect-mesa-por-fonte.md`](effect-mesa-por-fonte.md).

### Fases (ordem técnica DROP) — **fechadas**

1. ~~Migrar grants + combat_mod~~ → **feito** (E008–E014); tabelas **DROP** via `E014` + baseline.
2. No mesmo caminho de cada dono: revisão mesa (economy + apply) — checklist (aberto por categoria).
3. ~~Espécie: fallback MV~~ → **feito** (`collectSpeciesGrantedSpellSlugs` só `grant_spell`; escolha Alto Elfo / Andari via `option_key`).
4. Residual UI fino → [`backlog.md`](backlog.md) Adiado só se não for gap de apply tipado.

### Feito neste caminho (não reabrir)

| Lote | Entrega |
|------|---------|
| DROP-prep 1 | Transform `J061` → `E008`; class → `E009`; feat + class schedules **effects-only** |
| DROP-prep 2 | Heritage `E010`; thread `E011`; schedules **effects-only** |
| DROP-prep 3 | Species/subclass/item schedules **effects-only**; `E012`/`E013` |
| DROP | `E014` combat_mod residual; views HP/UD/heritage ← efeitos; **DROP** `phb_resource_grant` + `phb_combat_modifier` |
| Magias espécie | Collect + cast-economy **effects-only**; removidos dual-read, MV/view `*_species_granted_spell`, seed species grant legado |
| Limpeza mole | Heurística cast + Freyr + dual-path runtime + `hasStyleOrFeat` + truques Alto Elfo/Andari tipados → só `phb_effect` / `ownedStyleOrFeatSlugs` |


### DoD do DROP

- [x] 100% grants em `phb_effect` · loaders effects-only · views HP/unarmored só efeitos · **DROP** tabelas
- [x] Magias espécie collect + cast-economy effects-only · dual-read / MV espécie removidos
- [x] Cast economy só via `phb_effect_cast_economy` (sem heurística MI/Freyr)
- Specs verdes + mesa residual permanece no checklist por categoria

### Legado que permanece (pontuar)

| Item | Motivo |
|------|--------|
| Economy `C0*` incompleta / apply faltando | Checklist mesa |
| `feat_benefit` prose | Anti-escopo ADR |
| `resolve-sheet-meta` bundle vs query | Meta P032 incompleta → PB/boosts por query; **não** é motor de efeitos |

## Anti-escopo

- Big-bang de handlers sem passar pelo [`effect-mesa-checklist.md`](effect-mesa-checklist.md)
- Unificar `feat_benefit` com efeitos
- Kind novo sem linha no dicionário + read-path + call site
