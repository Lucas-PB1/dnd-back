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

## Controle de recursos

Pools limitados (usos / DL / SR) devem ser **recursos de verdade**, não contador decorativo no painel.

### Catálogo

1. `phb_resource_definition` + grant (`S002`/`S003`; mago: `C014`).
2. Linha **C009** com `resource_slug` apontando esse pool.
3. `table_action` na mesma linha **quando** o botão Usar deve chamar o handler (gasto + nota). Sem `table_action` = linha só de lembrete / sem Usar.

Referência: Mago (`third-eye`, `magic-missile-free`, …) e Bruxo (`healing-light`, `fey-steps`, …).

### UI na aba Ações (Economia)

| Campo C009 | O que a UI mostra |
|------------|-------------------|
| `resource_slug` + pool no estado da ficha | **Sempre** − / `remaining/max` / + (Gastar / Recuperar) |
| `table_action` preenchido | Botão **Usar** (ou Conjurar / Armar / …) |
| só `resource_slug`, sem `table_action` | Contador ± **ainda aparece**; sem Usar |
| nenhum dos dois | Só nome/summary (lembrete puro) |

**Regra:** o controle de recurso **não** depende de `table_action`. Esconder o ± porque `table_action` é `NULL` é bug (Patrulheiro: Marca/Véu ficavam só com o nome).

Implementação front: `plan-economy-table-use.ts` (`counterSlug` a partir de `resourceSlug` mesmo sem `tableAction`) · `beyond-actions-tab.tsx` (render ± se `counter && plan.counterSlug`).

**C010 / painel:** poderes e controles especiais (Recuperação Arcana, Aspecto Bestial, máscaras, invocações). Pode repetir um botão com `resource_slug` como atalho (ex. Bruxo), mas **não** substitui a Economia como UI de `remaining/max`.

Texto jogável no painel: o loader preenche `panelActions[].description` com o texto mais completo entre C009 (`description`/`summary` quando `table_action` = `slug`) e C010 `title`. Front: `description || title` — sem fallback genérico de “Gasta Foco”.

**Anti-padrão:** `CombatResourceSummary` no Ferramentas do painel espelhando pools da Economia; ou ± só se `table_action` existir.

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
