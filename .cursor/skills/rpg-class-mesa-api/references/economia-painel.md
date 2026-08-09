# Economia e painel

Tabelas: `rpg.phb_class_economy_action` · `rpg.phb_class_panel_action`.  
Padrões de catálogo: [`docs/architecture/catalog-patterns.md`](../../../../docs/architecture/catalog-patterns.md) §9.

## Economy (`C009` — SSOT)

Campos críticos:

| Campo | Uso |
|-------|-----|
| `action_id` | PK lógica estável (`sorcerer-tides-of-chaos`) |
| `class_id` / `subclass_id` / `species_id` / `feat_id` / `item_id` | **Owner XOR** — exatamente um dono |
| `economy` | bucket de turno (`action`, `bonus`, `reaction`, `free`, …) |
| `resource_slug` | recurso gasto (se houver) |
| `table_action` | slug do handler **ou** `spend-resource` / especial documentado |
| `spend_amount` | quando o gasto é fixo |
| `always_spends_resource` | UI / expectativa de gasto |

### `table_action`

- Poder com handler de classe → slug igual ao `actionSlug` do `table-action` (ex.: `tides-of-chaos`).
- Só gasta recurso genérico → `spend-resource` (+ `resource_slug`).
- Linha só documental / painel cuida → pode ser `NULL` (ex.: metamagia lista no painel).
- Front: roteia por `classSlug` do catálogo (+ protocolos `cast:` / `arm:` / `psi:`).

## Panel (`C010` — SSOT)

| Campo | Uso |
|-------|-----|
| `panel_key` | único (`sorcerer\|wild-magic\|tides-of-chaos`) |
| `slug` | vira `actionSlug` no botão |
| `section` | `base` \| `subclass` \| … |
| `subclass_id` | **obrigatório** se a ação é de subclasse |

Filtro no front: se `subclassSlug` da ação é `null`, a linha aparece para **todas** as subclasses — bug clássico quando o seed rodou antes da subclasse existir.

## Ordem segura

1. Garantir classe/subclasse/itens no catálogo (PHB / Valdas).
2. Resources + grants (`S002`/`S003`; mago: `C014`).
3. `C009` economy.
4. `C010` panel.
5. Re-seed idempotente se FK estava NULL.
