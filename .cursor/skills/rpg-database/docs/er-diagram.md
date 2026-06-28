# Diagrama ER — PostgreSQL v4 (catálogo)

Schema: `rpg` | PK: `BIGSERIAL` + `slug UNIQUE` | Personagens: ver [plano-final.md](plano-final.md) fase 5

## Visão em camadas

```mermaid
flowchart TB
  subgraph edition [Edição]
    phb_edition --> phb_source_citation
  end

  subgraph catalog [Catálogo PHB]
    phb_ability --> phb_skill
    phb_spell_school --> phb_spell
    phb_hit_die --> phb_class
    phb_class --> phb_subclass
    phb_class --> phb_class_progression
    phb_class --> phb_class_feature
    phb_class --> phb_class_skill_pool
    phb_class --> phb_class_fighting_style
    phb_class --> phb_class_spellcasting
    phb_class --> phb_spell_class
    phb_spell --> phb_spell_class
    phb_subclass --> phb_subclass_feature
    phb_subclass --> phb_subclass_prepared_spell
    phb_spell --> phb_subclass_prepared_spell
    phb_species --> phb_species_trait
    phb_species --> phb_species_option_def
    phb_species_option_def --> phb_species_option_value
    phb_background --> phb_background_skill
    phb_background --> phb_background_starting_package
    phb_background_starting_package --> phb_background_starting_item
    phb_class --> phb_class_starting_package
    phb_class_starting_package --> phb_class_starting_item
    phb_item --> phb_weapon
    phb_item --> phb_armor
    phb_item --> phb_tool
    phb_armor_category --> phb_armor
    phb_tool_category --> phb_tool
    phb_weapon_mastery --> phb_weapon
    phb_weapon --> phb_weapon_property_link
    phb_weapon_property --> phb_weapon_property_link
    phb_fighting_style --> phb_class_fighting_style
    phb_feat_category --> phb_feat
    phb_feat --> phb_feat_benefit
    phb_spell_slot_pattern --> phb_spell_slot_by_level
    phb_spell_slot_pattern --> phb_class
    phb_resource_definition
    phb_spell_source
    phb_elf_lineage
    phb_infernal_legacy
    phb_dragon_ancestry
    phb_divine_order
    phb_druid_land_terrain
  end
```

## Entidades principais

| Tabela | PK | Relacionamentos |
|--------|-----|-----------------|
| `phb_edition` | `id` | 1:N → `phb_source_citation` |
| `phb_spell` | `id` | N:M classe; N:1 escola; citação opcional |
| `phb_class` | `id` | hub central — progression, features, spellcasting |
| `phb_subclass` | `id` | N:1 classe; magias preparadas normalizadas |
| `phb_species` | `id` | traços + EAV de opções |
| `phb_background` | `id` | perícias, talento origem, equipamento inicial |
| `phb_item` | `id` | supertipo → weapon / armor / tool |
| `phb_feat` | `id` | N:1 categoria; 1:N benefícios |

## Tipos e opções

| Tabela | Propósito |
|--------|-----------|
| `phb_resource_definition` | Fúria, Canalizar Divindade, etc. (scope species/class) |
| `phb_spell_source` | Origem polimórfica de listas de magia |
| `phb_species_option_def` / `_value` | EAV genérico (lineageId, dragonAncestryId…) |
| `phb_elf_lineage` / `phb_infernal_legacy` / `phb_dragon_ancestry` | Catálogos de escolha de espécie |
| `phb_divine_order` | Opções de clérigo (ad hoc; unificar na fase 4) |
| `phb_class_fighting_style` | Estilos disponíveis por classe |
| `phb_weapon_property_link` | Junction weapon ↔ property (fonte única) |

## Views (API SQL)

| View | Uso |
|------|-----|
| `v_spell_by_class` | Magias por classe |
| `v_phb_spell` | Detalhe de magia + edição |
| `v_phb_class` | Classe + atributos primários |
| `v_phb_subclass` | Subclasse + spell source |
| `v_phb_feat` | Talento + benefícios agregados |
| `v_class_spell_slots` | Slots por nível (jsonb_object_agg) |
| `v_phb_background` | Antecedente + opções de atributo |
| `v_phb_class_equipment` | Equipamento inicial de classe |
| `v_phb_background_equipment` | Equipamento inicial de antecedente |
| `v_phb_armor` | Armadura + categoria |
| `v_phb_class_skill_choice` | Pool de perícias por classe |
| `v_phb_subclass_prepared_spell` | Magias preparadas de subclasse |
| `v_phb_species_trait_choices` | Opções de traços polimórficos |

## Ficha de personagem (fase 5 — não implementada)

Ver especificação completa em [plano-final.md § 5](plano-final.md#fase-5--camada-de-fichas-player_character--redesign).
