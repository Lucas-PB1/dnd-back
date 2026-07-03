-- ENUMs do catálogo PHB

CREATE TYPE rpg.item_type AS ENUM (
  'weapon','armor','gear','tool','focus','other'
);

CREATE TYPE rpg.resource_scope AS ENUM ('species','class','subclass');

CREATE TYPE rpg.subclass_feature_kind AS ENUM (
  'passive',
  'resource',
  'choice',
  'always_prepared',
  'spellcasting',
  'spellbook_bonus'
);

CREATE TYPE rpg.resource_max_formula AS ENUM (
  'fixed',
  'proficiency_bonus',
  'charisma_mod',
  'wisdom_mod',
  'constitution_mod',
  'intelligence_mod',
  'level',
  'level_plus_one',
  'superiority_dice_count',
  'psi_energy_dice_count',
  'zealot_healing_dice_count'
);

CREATE TYPE rpg.spell_source_origin AS ENUM (
  'class_list','subclass','species','feat'
);

CREATE TYPE rpg.option_value_type AS ENUM (
  'catalog','skill','ability','fighting_style','terrain','skill_list','json'
);

CREATE TYPE rpg.species_choice_kind AS ENUM (
  'elf_lineage',
  'infernal_legacy',
  'dragon_ancestry'
);

CREATE TYPE rpg.weapon_category AS ENUM ('simple', 'martial');

CREATE TYPE rpg.casting_type AS ENUM ('full', 'half', 'pact', 'none');
