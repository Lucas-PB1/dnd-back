# Read model — magias concedidas

## Views

| View | Origem |
|------|--------|
| `v_phb_species_granted_spell` | `phb_species_trait.spell_id` + linhagens (elf, infernal, gnome) |
| `v_phb_feat_granted_spell` | `phb_feat_granted_spell` |
| `v_phb_class_granted_spell` | `phb_spell_grant` (`origin_type=class`) |
| `v_phb_subclass_prepared_spell` | `phb_subclass_prepared_spell` |

Definição species+feat: `database/migrations/060_views/V031_v_phb_species_and_feat_granted_spell.sql`  
Classe: `V050_v_phb_class_granted_spell.sql`

## Runtime

- `LoadGrantedSpellCatalog` → entities das views
- Domain: `spellcasting/granted-spells/*` — merge/annotate; **sem** SQL duplicado
- Application aliases: `mergeGrantedSpells`, `annotateSpellSources`, `resolveSpellcastingStats`

## Ao adicionar grant de classe

1. Linha em `phb_spell_grant` (`origin_type=class`, `origin_id` = `phb_class.id`)
2. View `v_phb_class_granted_spell` já cobre
3. Spec de merge em `granted-spells.spec.ts`

## Ao adicionar espécie/linhagem

1. Tabela catálogo ou colunas em lineage existente
2. Estender `v_phb_species_granted_spell` (UNION ALL)
3. Estender `v_phb_species_trait_choices` se houver escolha de UI
4. Spec em `granted-spells.spec.ts`

## Runtime — CD / economia / Alto Elfo

- CD/ataque por magia: `resolve-granted-spellcasting-ability` + `enrich-spells-with-spellcasting-stats` (campos em `CharacterSpellDto`)
- Economia: `resolve-granted-spell-cast-economy`; usos em `player_character_state.granted_spell_uses`; `CastSpellDto.useFreeCast`
- Alto Elfo: choice opcional `high_elf_cantrip`; swap após LD via `high_elf_cantrip_swap_available`

## Não confundir

`phb_spell_source` = metadado de origem polimórfica (class/species/feat/subclass).  
Views acima = concessões mecânicas para always_prepared na ficha.
