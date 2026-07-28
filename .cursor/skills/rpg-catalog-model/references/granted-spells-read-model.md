# Read model — magias concedidas

## Views

| View | Origem |
|------|--------|
| `v_phb_species_granted_spell` | `phb_species_trait.spell_id` + linhagens (elf, infernal, gnome) |
| `v_phb_feat_granted_spell` | `phb_feat_granted_spell` |
| `v_phb_subclass_prepared_spell` | `phb_subclass_prepared_spell` |

Definição species+feat: `database/migrations/060_views/V039_v_species_feat_granted_spell.sql`

## Runtime

- `LoadGrantedSpellCatalog` → entities das views
- Domain: `spellcasting/granted-spells/*` — merge/annotate; **sem** SQL duplicado
- Application aliases: `mergeGrantedSpells`, `annotateSpellSources`, `resolveSpellcastingStats`

## Ao adicionar espécie/linhagem

1. Tabela catálogo ou colunas em lineage existente
2. Estender `v_phb_species_granted_spell` (UNION ALL)
3. Estender `v_phb_species_trait_choices` se houver escolha de UI
4. Spec em `granted-spells.spec.ts`

## Não confundir

`phb_spell_source` = metadado de origem polimórfica (class/species/feat/subclass).  
Views acima = concessões mecânicas para always_prepared na ficha.
