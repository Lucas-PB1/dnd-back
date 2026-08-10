# Seeds DMG 2024

Itens mágicos do Cap. 7 (A–Z), extraídos da tradução comunitária do DMG 2024.

| Arquivo | Conteúdo |
|---------|----------|
| `D001_phb_edition_citation.sql` | Edição `dmg-2024-pt` + citação Cap. 7 |
| `D010_phb_item.sql` | 338 itens em `rpg.phb_item` (`properties.magic`, raridade, sintonização) |
| `D011_phb_item_consumable_flag.sql` | Lote §0 #1: `properties.consumable=true` (poção/óleo/pergaminho) |
| `D012_phb_item_permanent_effects.sql` | Lote §0 #2: `properties.permanentEffects` (Anel/Manto de Proteção) |
| `D013_phb_item_coverage_flag.sql` | §3.1: `kind=coverage` + `appliesTo`/`appliesFilter` |
| `D014_fix_lingua_flamejante.sql` | Corrige Língua Flamejante (slug colado + Leque) |
| `D015_phb_item_resource_grant_dawn.sql` | Lote §0 #4: resources 1×/amanhecer |
| `D016_phb_item_resource_grant_dawn_elementals.sql` | Lote §0 #4b: elementais 1×/amanhecer |
| `D017_phb_item_resource_grant_charges.sql` | Lote §0 #5: pools de cargas (1 botão) |
| `D018_phb_item_resource_grant_star_ring.sql` | §0 #6: Anel das Estrelas Cadentes |
| `D019_phb_item_resource_grant_wands.sql` | §0 #7: varinhas multi-magia |
| `D020_phb_item_resource_grant_staves.sql` | §0 #8: cajados multi-magia |
| `D021_phb_item_resource_grant_staff_swarm.sql` | §0 #8b: Cajado do Enxame |
| `D022_phb_item_resource_grant_staves_simple.sql` | §0 #8c: cajados 1-botão + Sortilégios |
| `D023_phb_item_resource_grant_staff_woods.sql` | §0 #8d: Cajado das Matas |
| `D024_phb_item_resource_grant_staves_rest.sql` | §0 #8e: Agravo/Magificado/Trovoada/Píton |
| `D025_phb_item_resource_grant_staves_final.sql` | §0 #8f: Acrobata/Poder/Magi |
| `D026_phb_item_resource_grant_marvelous_simple.sql` | §0 #9a: maravilhosos simples |
| `D027_phb_item_resource_grant_marvelous_simple_b.sql` | §0 #9b: maravilhosos simples lote 2 |
| `D028_phb_item_resource_grant_marvelous_simple_c.sql` | §0 #9c: passivos + cubos/bolsa |
| `D029_phb_item_permanent_effects_marvelous_d.sql` | §0 #9d: Braceletes de Defesa |
| `D030_phb_item_resource_grant_marvelous_simple_f.sql` | §0 #9f: resources densos leves |
| `D031_phb_item_resource_grant_marvelous_rings_g.sql` | §0 #9g: gema/chapéu/poço + anéis |
| `D032_phb_item_resource_grant_rings_wands_h.sql` | §0 #9h: anéis finais + varinhas |
| `D033_phb_item_resource_grant_marvelous_weapons_i.sql` | §0 #9i: utilitários + armas (+ PE) |
| `D034_phb_item_resource_grant_armor_shields_j.sql` | §0 #9j: escudos / armaduras únicas |
| `D035_phb_item_resource_grant_weapons_k.sql` | §0 #9k: armas únicas (+ PE / artefatos) |
| `D036_phb_item_resource_grant_marvelous_dense_l.sql` | §0 #9l: densos finais + Orcus/Maravilhas |

Economy: `C016`–`C038` · `C039` densos finais.  
Taxonomia: `…-staves.yaml` · `…-marvelous-simple.yaml` · `…-rings.yaml` · `…-wands.yaml` · `…-armor-shields.yaml` · `…-weapons.yaml` · `…-marvelous-dense.yaml`.

Cast/link de magia do item → **fase 6** (hoje: spend + texto).  
Overlay coberturas (§3.1 / 2b) → migration `P021` + `POST …/inventory/coverage/attach|detach`.  
Modelo: `docs/architecture/dmg-item-mesa.md`.  
Compêndio: `/equipment?tab=magic` + `GET /items?magic=true`.

```bash
node docs/source/generate-dmg-item-seeds.mjs
node docs/source/generate-dmg-consumable-lote.mjs
node docs/source/generate-dmg-coverage-lote.mjs
```
