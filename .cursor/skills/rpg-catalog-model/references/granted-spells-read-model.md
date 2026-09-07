# Read model — magias concedidas

## Paths canônicos

| Origem | SSOT | Read path |
|--------|------|-----------|
| Espécie + linhagem | `phb_effect` (`grant_spell` + cast_economy) | `collectSpeciesGrantedSpellSlugs` / effects — **sem** `v_`/`mv_phb_species_granted_spell` |
| Talentos | `phb_spell_grant` / effects feat | `mv_phb_feat_granted_spell` (`v_phb_feat_granted_spell`) |
| Classe | `phb_spell_grant` (`origin_type=class`) | `v_phb_class_granted_spell` / MV |
| Subclasse | `phb_subclass_prepared_spell` | `v_phb_subclass_prepared_spell` |

Classe: `V050_v_phb_class_granted_spell.sql` · Feat MV: refresh pós-seed.

## Runtime

- Domain: `spellcasting/granted-spells/*` — merge/annotate; espécie via effects
- Application aliases: `mergeGrantedSpells`, `annotateSpellSources`, `resolveSpellcastingStats`
- Economia: `resolve-granted-spell-cast-economy` lê só `phb_effect` `cast_economy` (sem heurística `optionKey` MI/Freyr)

## Ao adicionar grant de classe

1. Linha em `phb_spell_grant` (`origin_type=class`, `origin_id` = `phb_class.id`)
2. View `v_phb_class_granted_spell` já cobre
3. Spec de merge em `granted-spells.spec.ts`

## Ao adicionar espécie/linhagem

1. Seed `phb_effect` (`grant_spell` + satélite spell / cast_economy se couber)
2. Estender `v_phb_species_trait_choices` se houver escolha de UI
3. Spec em `granted-spells.spec.ts` / collect species

## Runtime — CD / economia / Alto Elfo

- CD/ataque por magia: `resolve-granted-spellcasting-ability` + `enrich-spells-with-spellcasting-stats` (campos em `CharacterSpellDto`)
- Economia: `resolve-granted-spell-cast-economy`; usos em `player_character_state.granted_spell_uses`; `CastSpellDto.useFreeCast`
- Alto Elfo: choice opcional `high_elf_cantrip`; swap após LD via `high_elf_cantrip_swap_available` (override TS — não dual-read)

## Não confundir

`phb_spell_source` = metadado de origem polimórfica (class/species/feat/subclass).  
Concessões mecânicas de espécie = effects; feat ainda usa MV `mv_phb_feat_granted_spell`.
