-- ENUMs do catálogo PHB (baseline canônico)

CREATE TYPE rpg.item_type AS ENUM (
  'weapon','armor','gear','tool','focus','other'
);

CREATE TYPE rpg.resource_scope AS ENUM ('species','class','subclass','feat','item');

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

CREATE TYPE rpg.spell_grant_origin AS ENUM ('feat', 'species');

CREATE TYPE rpg.option_value_type AS ENUM (
  'catalog',
  'skill',
  'ability',
  'fighting_style',
  'terrain',
  'skill_list',
  'json',
  'spell',
  'proficiency'
);

CREATE TYPE rpg.species_choice_kind AS ENUM (
  'elf_lineage',
  'infernal_legacy',
  'dragon_ancestry',
  'human_skill',
  'human_origin_feat',
  'human_size',
  'gnome_lineage',
  'giant_ancestry',
  'elf_keen_senses',
  'elf_casting_ability',
  'gnome_casting_ability',
  'infernal_casting_ability',
  'aasimar_size',
  'tiefling_size',
  'high_elf_cantrip',
  'geppettin_skill',
  'geppettin_construction',
  'geppettin_size',
  'mandrake_skill',
  'mandrake_casting_ability',
  'mandrake_season'
);

CREATE TYPE rpg.weapon_category AS ENUM ('simple', 'martial');

CREATE TYPE rpg.casting_type AS ENUM ('full', 'half', 'pact', 'third', 'none');

-- Lote A: small lookup tables consolidated to ENUMs

CREATE TYPE rpg.hit_die AS ENUM ('d6', 'd8', 'd10', 'd12');

CREATE TYPE rpg.druid_land_terrain AS ENUM ('arid', 'polar', 'temperate', 'tropical');

CREATE TYPE rpg.feat_category AS ENUM ('origin', 'general', 'fighting-style', 'epic-boon');

CREATE TYPE rpg.ability_generation_method AS ENUM ('standard-array', 'roll', 'point-buy');

CREATE TYPE rpg.condition_slug AS ENUM (
  'blinded', 'charmed', 'deafened', 'exhaustion', 'frightened',
  'grappled', 'incapacitated', 'invisible', 'paralyzed', 'petrified',
  'poisoned', 'prone', 'restrained', 'stunned', 'unconscious'
);

-- Lote C: option families unificadas (+ class para runtime)
CREATE TYPE rpg.option_scope AS ENUM ('subclass', 'species', 'feat', 'class');

-- Lote D: pacotes de equipamento inicial (classe + antecedente)
CREATE TYPE rpg.starting_package_source AS ENUM ('class', 'background');

-- Lote F: afinidades de classe unificadas
CREATE TYPE rpg.class_proficiency_kind AS ENUM (
  'saving_throw',
  'primary_ability',
  'armor_training',
  'weapon',
  'fighting_style'
);

-- Lote G: recursos e modificadores de combate unificados
CREATE TYPE rpg.resource_owner_kind AS ENUM ('class', 'subclass', 'species', 'feat', 'item');

CREATE TYPE rpg.combat_modifier_kind AS ENUM ('hp_bonus', 'unarmored_defense');

CREATE TYPE rpg.combat_modifier_owner AS ENUM ('species', 'class', 'subclass', 'feat');
