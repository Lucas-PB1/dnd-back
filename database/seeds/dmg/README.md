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
| `D036_phb_item_resource_grant_marvelous_dense_l.sql` | §0 #9l: densos finais + Orcus/Vecna/Órbes |
| `D037_phb_item_resource_grant_enspelled_weapon.sql` | Fase 6: cargas Arma Magificada |
| `D038_fix_armadura_magificada.sql` | Extrai Armadura Magificada (colada em fumegante) |
| `D039_phb_item_resource_grant_enspelled_armor.sql` | Fase 6: cargas Armadura Magificada |
| `D040_phb_item_resource_grant_weapon_coverages.sql` | Coberturas de arma: resources (Martelo, Garra, Escara, Lâmina, Juramento) |
| `D041_phb_item_resource_grant_recover_dice.sql` | Recover 1dN ao amanhecer (long rest) |
| `D042_phb_item_resource_grant_dmg_artifacts_fix.sql` | Artefatos: pools Kas/Contenção/Trevas + PE Feitos |
| `D043_dmg_artifact_random_property.sql` | Tabelas 1d100 props aleatórias de artefato |
| `D044_dmg_sentient_trait_table.sql` | Tabelas de geração de item senciente |
| `D045_phb_item_artifact_quota_sentience.sql` | Quotas + senciência fixa (11 artefatos + Lunâmina) |
| `D046_phb_item_cast_treasure_props.sql` | Treasure cast: `spellSaveDc` + `itemCastSlotRule(s)` (Relâmpagos/Cuspidora/Onda/Órbes/Orcus) |
| `D047_phb_item_cursed_flag.sql` | `properties.cursed` (Vulnerabilidade, Demoníaca, Escudo Atração, Espada Vingança, Machado-Berserker) |

Economy: `C016`–`C039` · `C040`/`C041` Enspelled · `C042` spell_slug · `C043` weapon coverages · `C044` Magi free cast · `C045` artefatos.  
Cajado Magificado: resource `D024`/`C026` + `bound_spell_slug` (`P023`).  
Artefato 1ª sintonia: `instance_properties` (`P027`) + tabelas `T075`/`T076`.  
Status dos lotes: [`docs/source/extracts/dmg/wiring-status.md`](../../docs/source/extracts/dmg/wiring-status.md).

Cast de item (fase 6): `POST …/spells/cast` + `itemCastResourceSlug` / `itemCastSpendAmount` / `itemCastItemSlug` (Magi 0).  
Recover 1dN: coluna `recover_on_long_dice` (`T073`) + `D041`.  
Enspelled: CD/ataque/raridade via `getEnspelledSpellStats` na nota do cast.  
Sintonia por classe: `attunement-restriction.ts` no patch / attach cobertura.  
Overlay coberturas (§3.1 / 2b) → migration `P021`/`P022`/`P023` + `POST …/inventory/actions` (`attach-coverage` / `detach-coverage`; também charm e `artifact-regen`).  
Modelo: `docs/architecture/dmg-item-mesa.md`.  
Gaps Treasure: `docs/architecture/treasure-rules-vs-sistema.md`.  
Compêndio: `/equipment?tab=magic` + `GET /items?magic=true`.

```bash
node scripts/generate-dmg-item-seeds.mjs
node scripts/generate-dmg-consumable-lote.mjs
node scripts/generate-dmg-coverage-lote.mjs
node scripts/generate-dmg-artifact-sentience-seeds.mjs
```
