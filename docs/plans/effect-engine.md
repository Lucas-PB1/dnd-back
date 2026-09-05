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

Completar mesa = categoria + fonte; fechar dual-read = fases abaixo.

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

### Fases (ordem técnica DROP)

1. ~~Migrar grants + combat_mod~~ → **feito** (E008–E014); tabelas **DROP** via `E014` + baseline.
2. No mesmo caminho de cada dono: revisão mesa (economy + apply) — checklist.
3. ~~Espécie: fallback MV~~ → **feito** (`collectSpeciesGrantedSpellSlugs` só `grant_spell`; Alto Elfo / Andari overrides no TS).
4. Residual UI fino → [`backlog.md`](backlog.md) Adiado só se não for gap de apply tipado.

### Feito neste caminho (não reabrir)

| Lote | Entrega |
|------|---------|
| DROP-prep 1 | Transform `J061` → `E008`; class → `E009`; feat + class schedules **effects-only** |
| DROP-prep 2 | Heritage `E010`; thread `E011`; schedules **effects-only** |
| DROP-prep 3 | Species/subclass/item schedules **effects-only**; `E012`/`E013` |
| DROP | `E014` combat_mod residual; views HP/UD/heritage ← efeitos; **DROP** `phb_resource_grant` + `phb_combat_modifier` |
| Magias espécie | Collect + cast-economy **effects-only**; MV `v_phb_species_granted_spell` legado (não lida no merge) |


### DoD do DROP

- ~~100% grants em `phb_effect`~~ · ~~loaders effects-only~~ · ~~views HP/unarmored só efeitos~~ · ~~DROP tabelas~~ · ~~magias espécie collect + cast-economy effects-only~~
- Specs verdes + item sumido do backlog (mesa residual permanece no checklist)

### Legado que permanece (pontuar)

| Item | Motivo |
|------|--------|
| MV/view magias espécie | View ainda no schema; runtime não lê no merge/cast |
| `hasStyleOrFeat` (posse) | Gates de proficiência |
| Prefix skill option keys | Fallback até collector 100% efeitos |
| Heurística cast MI / Freyr | Fallback até `cast_economy` completo |
| Economy `C0*` incompleta / apply faltando | Checklist mesa |
| `feat_benefit` prose | Anti-escopo ADR |

## Anti-escopo

- Big-bang de handlers sem passar pelo [`effect-mesa-checklist.md`](effect-mesa-checklist.md)
- Unificar `feat_benefit` com efeitos
- Kind novo sem linha no dicionário + read-path + call site
