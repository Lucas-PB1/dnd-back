-- Baseline schema `rpg` — greenfield DDL (schema + runtime)

-- Schema rpg + extensão pg_trgm

CREATE SCHEMA IF NOT EXISTS rpg;

CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- ENUMs do catálogo PHB (baseline canônico)

CREATE TYPE rpg.item_type AS ENUM (
  'weapon','armor','gear','tool','focus','other'
);

CREATE TYPE rpg.resource_scope AS ENUM ('species','class','subclass','feat','item','heritage');

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

CREATE TYPE rpg.spell_grant_origin AS ENUM ('feat', 'species', 'class');

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
  'mandrake_season',
  'manikin_size',
  'manikin_armor',
  'manikin_service_model',
  'scourgeborne_madness',
  'scourgeborne_lineage',
  'bearfolk_lineage',
  'beastkin_adaptation',
  'beastkin_size',
  'giantkin_ancestry',
  'trollkin_ancestry',
  'andari_druid_cantrip',
  'dwarf_culture',
  'feathren_avian_ancestry',
  'feathren_feline_ancestry',
  'feathren_casting_ability',
  'gh_heritage_trait_1',
  'gh_heritage_trait_2',
  'gh_heritage_trait_3',
  'gh_heritage_trait_4',
  'gh_heritage_trait_5',
  'gh_heritage_trait_6',
  'gh_heritage_trait_7',
  'gh_heritage_trait_8',
  'gh_heritage_trait_9',
  'gh_heritage_speed_trade',
  'gh_heritage_size'
);

CREATE TYPE rpg.weapon_category AS ENUM ('simple', 'martial', 'advanced');

CREATE TYPE rpg.casting_type AS ENUM ('full', 'half', 'pact', 'third', 'none');

CREATE TYPE rpg.hit_die AS ENUM ('d6', 'd8', 'd10', 'd12');

CREATE TYPE rpg.druid_land_terrain AS ENUM ('arid', 'polar', 'temperate', 'tropical');

CREATE TYPE rpg.feat_category AS ENUM ('origin', 'general', 'fighting-style', 'epic-boon', 'gh-transformation');

CREATE TYPE rpg.ability_generation_method AS ENUM ('standard-array', 'roll', 'point-buy');

CREATE TYPE rpg.condition_slug AS ENUM (
  'blinded', 'charmed', 'deafened', 'exhaustion', 'frightened',
  'grappled', 'incapacitated', 'invisible', 'paralyzed', 'petrified',
  'poisoned', 'prone', 'restrained', 'stunned', 'unconscious'
);

CREATE TYPE rpg.option_scope AS ENUM ('subclass', 'species', 'feat', 'class');

CREATE TYPE rpg.starting_package_source AS ENUM ('class', 'background');

CREATE TYPE rpg.class_proficiency_kind AS ENUM (
  'saving_throw',
  'primary_ability',
  'armor_training',
  'weapon',
  'fighting_style'
);

CREATE TYPE rpg.resource_owner_kind AS ENUM ('class', 'subclass', 'species', 'feat', 'item', 'heritage');

CREATE TYPE rpg.combat_modifier_kind AS ENUM ('hp_bonus', 'unarmored_defense');

CREATE TYPE rpg.combat_modifier_owner AS ENUM ('species', 'class', 'subclass', 'feat', 'heritage');

-- Combat mechanical enums for subclass features

CREATE TYPE rpg.maneuver_effect_kind AS ENUM (
  'temp_hp',
  'miss_damage',
  'ac_bonus',
  'ability_check_bonus',
  'descriptive',
  'reload_move'
);

CREATE TYPE rpg.battle_master_maneuver_timing AS ENUM (
  'on_hit',
  'on_miss',
  'reaction',
  'bonus_action',
  'other'
);

CREATE TYPE rpg.save_ability AS ENUM (
  'strength',
  'dexterity',
  'constitution',
  'intelligence',
  'wisdom',
  'charisma'
);

-- Action economy bucket for class economy catalog (UI Actions tab)

CREATE TYPE rpg.action_economy_bucket AS ENUM (
  'action',
  'bonus',
  'reaction',
  'free'
);

CREATE TYPE rpg.panel_action_section AS ENUM (
  'base',
  'subclass',
  'metamagic',
  'channel'
);

-- Runtime game_actor: tipos de ficha e conjuração inata

CREATE TYPE rpg.actor_kind AS ENUM (
  'creature',
  'mount',
  'vehicle',
  'companion'
);

CREATE TYPE rpg.innate_spell_usage AS ENUM (
  'at_will',
  'per_day',
  'recharge',
  'slot'
);

CREATE TYPE rpg.actor_action_bucket AS ENUM (
  'action',
  'bonus',
  'reaction',
  'legendary',
  'other'
);

CREATE TYPE rpg.eldritch_invocation_kind AS ENUM (
  'passive',
  'note',
  'free_cast',
  'bonus',
  'action',
  'reaction'
);

-- Grim Hollow — tipos de herança e traços modulares

CREATE TYPE rpg.heritage_category AS ENUM ('common', 'rare', 'eldritch');

CREATE TYPE rpg.heritage_trait_category AS ENUM ('combat', 'exploration', 'roleplaying');

CREATE TYPE rpg.heritage_trait_take_mode AS ENUM ('stack', 'choice_each_take');

-- Grim Hollow — identidade de herança (17 jogáveis)

CREATE TABLE rpg.phb_heritage (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  category rpg.heritage_category NOT NULL,
  creature_type TEXT NOT NULL,
  size_rule TEXT NOT NULL,
  speed_rule TEXT NOT NULL,
  allows_speed_trade BOOLEAN NOT NULL DEFAULT FALSE,
  allows_size_choice BOOLEAN NOT NULL DEFAULT FALSE,
  description TEXT NOT NULL,
  tagline TEXT,
  summary TEXT,
  image_url TEXT,
  source_meta JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_phb_heritage_category ON rpg.phb_heritage(category);

COMMENT ON TABLE rpg.phb_heritage IS
  'Heranças Grim Hollow — identidade racial (Anão, Elfo, …) com 8 traços modulares do pool global.';

COMMENT ON COLUMN rpg.phb_heritage.image_url IS
  'Caminho público da ilustração (ex. /catalog/heritages/dwarf.png).';

-- Grim Hollow — pool global de traços modulares (~107)

CREATE TABLE rpg.phb_heritage_trait (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  anchor_id TEXT NOT NULL,
  category rpg.heritage_trait_category NOT NULL,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  benefit_base TEXT NOT NULL,
  benefit_improved TEXT,
  improved_name TEXT,
  max_takes INTEGER CHECK (max_takes IS NULL OR max_takes >= 1),
  take_mode rpg.heritage_trait_take_mode NOT NULL DEFAULT 'stack',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_phb_heritage_trait_category ON rpg.phb_heritage_trait(category);
CREATE INDEX idx_phb_heritage_trait_anchor ON rpg.phb_heritage_trait(anchor_id);

COMMENT ON TABLE rpg.phb_heritage_trait IS
  'Traços modulares GH — pool global; repetição aplica benefit_improved conforme max_takes/take_mode.';


CREATE TABLE rpg.phb_edition (
  id           BIGSERIAL PRIMARY KEY,
  slug         TEXT NOT NULL UNIQUE,
  label        TEXT NOT NULL,
  book         TEXT NOT NULL DEFAULT 'Livro do Jogador 2024',
  language     TEXT NOT NULL DEFAULT 'pt-BR',
  extracted_at TIMESTAMPTZ,
  notes        TEXT
);


CREATE TABLE rpg.phb_source_citation (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  edition_id BIGINT NOT NULL REFERENCES rpg.phb_edition(id),
  chapter INTEGER NOT NULL,
  chapter_title TEXT,
  pdf_path TEXT,
  pdf_pages INTEGER[],
  extracted_at TIMESTAMPTZ
);


CREATE TABLE rpg.phb_ability (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0
);


CREATE TABLE rpg.phb_alignment (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  abbreviation TEXT,
  description TEXT
);


CREATE TABLE rpg.phb_language (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  script TEXT,
  typical_speakers TEXT,
  is_rare BOOLEAN NOT NULL DEFAULT FALSE
);


CREATE TABLE rpg.phb_skill (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  ability_id BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  description TEXT
);


CREATE TABLE rpg.phb_fighting_style (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);


CREATE TABLE rpg.phb_weapon_property (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);


CREATE TABLE rpg.phb_feat (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  category rpg.feat_category NOT NULL,
  repeatable BOOLEAN NOT NULL DEFAULT FALSE,
  prerequisite TEXT,
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE rpg.phb_feat_benefit (
  id BIGSERIAL PRIMARY KEY,
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  sort_order INTEGER NOT NULL CHECK (sort_order >= 1),
  name TEXT,
  description TEXT NOT NULL,
  UNIQUE (feat_id, sort_order)
);


CREATE TABLE rpg.phb_spell_school (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0
);


CREATE TABLE rpg.phb_spell (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  level INTEGER NOT NULL CHECK (level BETWEEN 0 AND 9),
  level_label TEXT NOT NULL,
  school_id BIGINT NOT NULL REFERENCES rpg.phb_spell_school(id),
  casting_time TEXT NOT NULL,
  range TEXT NOT NULL,
  has_verbal BOOLEAN NOT NULL DEFAULT FALSE,
  has_somatic BOOLEAN NOT NULL DEFAULT FALSE,
  has_material BOOLEAN NOT NULL DEFAULT FALSE,
  material_description TEXT,
  components_label TEXT NOT NULL,
  duration TEXT NOT NULL,
  concentration BOOLEAN NOT NULL DEFAULT FALSE,
  ritual BOOLEAN NOT NULL DEFAULT FALSE,
  description TEXT NOT NULL,
  higher_levels TEXT,
  save_ability_id BIGINT REFERENCES rpg.phb_ability(id),
  requires_attack_roll BOOLEAN NOT NULL DEFAULT FALSE,
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE rpg.phb_spell_slot_pattern (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT
);


CREATE TABLE rpg.phb_spell_slot_by_level (
  pattern_id BIGINT NOT NULL REFERENCES rpg.phb_spell_slot_pattern(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  circle INTEGER NOT NULL CHECK (circle BETWEEN 1 AND 9),
  slot_count INTEGER NOT NULL CHECK (slot_count >= 1),
  PRIMARY KEY (pattern_id, level, circle)
);


CREATE TABLE rpg.phb_class (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  tagline TEXT,
  summary TEXT,
  description TEXT,
  primary_ability_label TEXT,
  primary_ability_operator TEXT CHECK (primary_ability_operator IN ('or', 'and')),
  hit_die rpg.hit_die NOT NULL,
  hp_level1_die_value INTEGER CHECK (hp_level1_die_value >= 0),
  hp_fixed_per_level INTEGER CHECK (hp_fixed_per_level >= 0),
  hp_minimum_gain_per_level INTEGER CHECK (hp_minimum_gain_per_level >= 1),
  hp_constitution_mod_applies BOOLEAN NOT NULL DEFAULT TRUE,
  subclass_unlock_level INTEGER NOT NULL DEFAULT 3 CHECK (subclass_unlock_level >= 1),
  subclass_label TEXT,
  skill_choice_count INTEGER CHECK (skill_choice_count >= 1),
  skill_choice_from TEXT CHECK (skill_choice_from IN ('any')),
  spell_slot_pattern_id BIGINT REFERENCES rpg.phb_spell_slot_pattern(id),
  weapon_mastery_eligibility TEXT,
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT phb_class_weapon_mastery_eligibility_check CHECK (
    weapon_mastery_eligibility IS NULL
    OR weapon_mastery_eligibility IN ('any', 'melee', 'ranged')
  )
);


CREATE TABLE rpg.phb_subclass (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  tagline TEXT,
  summary TEXT,
  description TEXT,
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  image_url TEXT,
  UNIQUE (class_id, id)
);


CREATE TABLE rpg.phb_subclass_feature (
  id BIGSERIAL PRIMARY KEY,
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level >= 1),
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  feature_kind rpg.subclass_feature_kind NOT NULL DEFAULT 'passive',
  option_key TEXT,
  UNIQUE (subclass_id, level, name)
);


CREATE TABLE rpg.phb_species (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  creature_type TEXT NOT NULL,
  size TEXT NOT NULL,
  speed TEXT NOT NULL,
  description TEXT NOT NULL,
  tagline TEXT,
  summary TEXT,
  source_meta JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  image_url TEXT
);


CREATE TABLE rpg.phb_item (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  item_type rpg.item_type NOT NULL,
  name TEXT NOT NULL,
  cost JSONB,
  weight TEXT,
  description TEXT,
  properties JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  image_url TEXT
);


CREATE TABLE rpg.phb_tool_category (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0
);


CREATE TABLE rpg.phb_background (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  tagline TEXT,
  summary TEXT,
  feat_id BIGINT REFERENCES rpg.phb_feat(id),
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  equipment_gold_option INTEGER CHECK (equipment_gold_option >= 0),
  tool_proficiency_description TEXT,
  tool_proficiency_kind TEXT CHECK (tool_proficiency_kind IN ('fixed', 'choice')),
  tool_item_id BIGINT REFERENCES rpg.phb_item(id),
  tool_category_id BIGINT REFERENCES rpg.phb_tool_category(id),
  language_choice_count INT NOT NULL DEFAULT 0 CHECK (language_choice_count >= 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


CREATE TABLE rpg.phb_armor_category (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  don_doff TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0
);


CREATE TABLE rpg.phb_background_boost_option (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  label TEXT NOT NULL
);


CREATE TABLE rpg.phb_resource_definition (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  scope rpg.resource_scope NOT NULL,
  species_id BIGINT REFERENCES rpg.phb_species(id),
  class_id BIGINT REFERENCES rpg.phb_class(id),
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  feat_id BIGINT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  item_id BIGINT NULL REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  heritage_trait_id BIGINT NULL REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE,
  min_level INTEGER NOT NULL DEFAULT 1 CHECK (min_level BETWEEN 1 AND 20),
  CONSTRAINT prd_scope_fk CHECK (
    (scope = 'species' AND species_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (scope = 'class' AND class_id IS NOT NULL AND species_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (scope = 'subclass' AND subclass_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (scope = 'feat' AND feat_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (scope = 'item' AND item_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND heritage_trait_id IS NULL)
    OR (scope = 'heritage' AND heritage_trait_id IS NOT NULL AND species_id IS NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL AND item_id IS NULL)
  )
);

-- owner_id = subclass_id | species_id | feat_id conforme scope (sem FK polimórfica)

CREATE TABLE rpg.phb_option_def (
  scope rpg.option_scope NOT NULL,
  owner_id BIGINT NOT NULL,
  option_key TEXT NOT NULL,
  value_type rpg.option_value_type NOT NULL DEFAULT 'catalog',
  label TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  unlock_level INTEGER CHECK (unlock_level IS NULL OR unlock_level BETWEEN 1 AND 20),
  depends_on_option_key TEXT,
  spell_max_level INTEGER CHECK (spell_max_level IS NULL OR spell_max_level BETWEEN 0 AND 9),
  spell_school_slugs TEXT[],
  spell_ritual_only BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (scope, owner_id, option_key),
  CONSTRAINT phb_option_def_subclass_unlock CHECK (
    scope <> 'subclass' OR unlock_level IS NOT NULL
  )
);

CREATE INDEX idx_phb_option_def_scope_owner
  ON rpg.phb_option_def(scope, owner_id);


CREATE TABLE rpg.phb_option_value (
  scope rpg.option_scope NOT NULL,
  owner_id BIGINT NOT NULL,
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  label TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  benefit TEXT,
  level1_benefit TEXT,
  damage_type TEXT,
  spell_level1_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_level3_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_level5_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_1_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_2_id BIGINT REFERENCES rpg.phb_spell(id),
  edition_slug TEXT,
  PRIMARY KEY (scope, owner_id, option_key, value_id),
  FOREIGN KEY (scope, owner_id, option_key)
    REFERENCES rpg.phb_option_def(scope, owner_id, option_key) ON DELETE CASCADE
);

CREATE INDEX idx_phb_option_value_scope_owner
  ON rpg.phb_option_value(scope, owner_id);


CREATE TABLE rpg.phb_resource_grant (
  owner_kind rpg.resource_owner_kind NOT NULL,
  owner_id BIGINT NOT NULL,
  resource_id BIGINT NOT NULL REFERENCES rpg.phb_resource_definition(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  max_formula rpg.resource_max_formula NOT NULL,
  fixed_max INTEGER CHECK (fixed_max IS NULL OR fixed_max >= 0),
  feature_id BIGINT REFERENCES rpg.phb_subclass_feature(id) ON DELETE SET NULL,
  recover_one_on_short BOOLEAN NOT NULL DEFAULT FALSE,
  recover_all_on_short BOOLEAN NOT NULL DEFAULT FALSE,
  recover_all_on_long BOOLEAN NOT NULL DEFAULT TRUE,
  recover_on_long_dice TEXT NULL,
  min_trait_takes INTEGER NOT NULL DEFAULT 1 CHECK (min_trait_takes >= 1),
  PRIMARY KEY (owner_kind, owner_id, resource_id, unlock_level),
  CONSTRAINT prg_formula_fixed CHECK (
    (max_formula = 'fixed' AND fixed_max IS NOT NULL)
    OR (max_formula <> 'fixed' AND fixed_max IS NULL)
  ),
  CONSTRAINT prg_feature_owner CHECK (
    feature_id IS NULL OR owner_kind = 'subclass'::rpg.resource_owner_kind
  )
);

CREATE INDEX idx_phb_resource_grant_owner
  ON rpg.phb_resource_grant(owner_kind, owner_id);


CREATE TABLE rpg.phb_spell_source (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  label TEXT NOT NULL,
  origin_type rpg.spell_source_origin NOT NULL,
  class_id BIGINT REFERENCES rpg.phb_class(id),
  subclass_id BIGINT,
  species_id BIGINT REFERENCES rpg.phb_species(id),
  feat_id BIGINT REFERENCES rpg.phb_feat(id),
  CONSTRAINT spell_source_origin_fk CHECK (
    (origin_type = 'class_list' AND class_id IS NULL AND subclass_id IS NULL AND species_id IS NULL AND feat_id IS NULL)
    OR (origin_type = 'subclass' AND subclass_id IS NOT NULL AND class_id IS NOT NULL AND species_id IS NULL AND feat_id IS NULL)
    OR (origin_type = 'species' AND species_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND feat_id IS NULL)
    OR (origin_type = 'feat' AND feat_id IS NOT NULL AND class_id IS NULL AND subclass_id IS NULL AND species_id IS NULL)
  ),
  CONSTRAINT spell_source_subclass_fk
    FOREIGN KEY (class_id, subclass_id) REFERENCES rpg.phb_subclass(class_id, id)
);


CREATE TABLE rpg.phb_class_progression (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  proficiency_bonus INTEGER NOT NULL CHECK (proficiency_bonus BETWEEN 2 AND 6),
  cantrips INTEGER CHECK (cantrips >= 0),
  prepared_spells INTEGER CHECK (prepared_spells >= 0),
  channel_divinity INTEGER CHECK (channel_divinity >= 0),
  weapon_mastery INTEGER CHECK (weapon_mastery IS NULL OR weapon_mastery >= 0),
  PRIMARY KEY (class_id, level)
);


CREATE TABLE rpg.phb_class_feature (
  id BIGSERIAL PRIMARY KEY,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level >= 1),
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  UNIQUE (class_id, level, name)
);


CREATE TABLE rpg.phb_class_skill_pool (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  skill_id BIGINT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (class_id, skill_id)
);


CREATE TABLE rpg.phb_spell_class (
  spell_id BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  PRIMARY KEY (spell_id, class_id)
);

CREATE TABLE rpg.phb_subclass_prepared_spell (
  id BIGSERIAL PRIMARY KEY,
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level >= 1),
  spell_id BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  terrain rpg.druid_land_terrain,
  CONSTRAINT uq_subclass_prepared_spell
    UNIQUE NULLS NOT DISTINCT (subclass_id, unlock_level, spell_id, terrain)
);


CREATE TABLE rpg.phb_species_trait (
  id BIGSERIAL PRIMARY KEY,
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  choice_kind rpg.species_choice_kind,
  spell_id BIGINT REFERENCES rpg.phb_spell(id),
  UNIQUE (species_id, name)
);


CREATE TABLE rpg.phb_background_skill (
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  skill_id BIGINT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (background_id, skill_id)
);


CREATE TABLE rpg.phb_background_ability_option (
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  ability_id BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (background_id, ability_id)
);

-- Pacotes de equipamento inicial (classe ou antecedente)

CREATE TABLE rpg.phb_starting_package (
  id BIGSERIAL PRIMARY KEY,
  source rpg.starting_package_source NOT NULL,
  owner_id BIGINT NOT NULL,
  slug TEXT NOT NULL,
  label TEXT NOT NULL,
  gold INTEGER CHECK (gold IS NULL OR gold >= 0),
  sort_order INTEGER NOT NULL DEFAULT 0,
  UNIQUE (source, owner_id, slug)
);

CREATE INDEX idx_phb_starting_package_source_owner ON rpg.phb_starting_package(source, owner_id);

-- Itens de pacote de equipamento inicial

CREATE TABLE rpg.phb_starting_item (
  id BIGSERIAL PRIMARY KEY,
  package_id BIGINT NOT NULL REFERENCES rpg.phb_starting_package(id) ON DELETE CASCADE,
  item_id BIGINT REFERENCES rpg.phb_item(id),
  choice_text TEXT,
  gold_amount INTEGER CHECK (gold_amount IS NULL OR gold_amount >= 0),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  sort_order INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT psi_has_content CHECK (
    item_id IS NOT NULL OR choice_text IS NOT NULL OR gold_amount IS NOT NULL
  )
);

CREATE TABLE rpg.phb_class_proficiency (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  kind rpg.class_proficiency_kind NOT NULL,
  ref_id BIGINT,
  ref_slug TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT phb_class_proficiency_ref CHECK (
    (kind IN ('saving_throw'::rpg.class_proficiency_kind, 'primary_ability'::rpg.class_proficiency_kind)
      AND ref_id IS NOT NULL AND ref_slug IS NULL)
    OR (kind = 'armor_training'::rpg.class_proficiency_kind AND ref_id IS NOT NULL AND ref_slug IS NULL)
    OR (kind = 'weapon'::rpg.class_proficiency_kind AND ref_slug IS NOT NULL AND ref_id IS NULL)
    OR (kind = 'fighting_style'::rpg.class_proficiency_kind AND ref_id IS NOT NULL AND ref_slug IS NULL)
  )
);

CREATE UNIQUE INDEX uq_phb_class_prof_id
  ON rpg.phb_class_proficiency (class_id, kind, ref_id) WHERE ref_id IS NOT NULL;
CREATE UNIQUE INDEX uq_phb_class_prof_slug
  ON rpg.phb_class_proficiency (class_id, kind, ref_slug) WHERE ref_slug IS NOT NULL;
CREATE INDEX idx_phb_class_proficiency_class ON rpg.phb_class_proficiency(class_id, kind);


CREATE TABLE rpg.phb_class_spellcasting (
  class_id BIGINT PRIMARY KEY REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  casting_type rpg.casting_type NOT NULL,
  ability_id BIGINT REFERENCES rpg.phb_ability(id),
  focus_label TEXT,
  focus_item_id BIGINT REFERENCES rpg.phb_item(id),
  ritual BOOLEAN NOT NULL DEFAULT FALSE
);


CREATE TABLE rpg.phb_weapon_mastery (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);


CREATE TABLE rpg.phb_weapon (
  item_id BIGINT PRIMARY KEY REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  category rpg.weapon_category,
  damage TEXT,
  damage_type TEXT,
  mastery_id BIGINT REFERENCES rpg.phb_weapon_mastery(id)
);


CREATE TABLE rpg.phb_armor (
  item_id BIGINT PRIMARY KEY REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  category_id BIGINT NOT NULL REFERENCES rpg.phb_armor_category(id),
  ac_base INTEGER CHECK (ac_base >= 0),
  ac_formula TEXT,
  strength_req INTEGER CHECK (strength_req >= 0),
  stealth_disadvantage BOOLEAN NOT NULL DEFAULT FALSE
);


CREATE TABLE rpg.phb_tool (
  item_id BIGINT PRIMARY KEY REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  category_id BIGINT NOT NULL REFERENCES rpg.phb_tool_category(id),
  use_description TEXT
);


CREATE TABLE rpg.phb_character_level (
  level INTEGER PRIMARY KEY CHECK (level BETWEEN 1 AND 20),
  proficiency_bonus INTEGER NOT NULL CHECK (proficiency_bonus BETWEEN 2 AND 6),
  xp_threshold INTEGER CHECK (xp_threshold >= 0)
);


CREATE TABLE rpg.phb_weapon_property_link (
  weapon_id BIGINT NOT NULL REFERENCES rpg.phb_weapon(item_id) ON DELETE CASCADE,
  property_id BIGINT NOT NULL REFERENCES rpg.phb_weapon_property(id) ON DELETE CASCADE,
  PRIMARY KEY (weapon_id, property_id)
);

-- Whitelist de ferramentas por antecedente (substitui “toda a categoria”)

CREATE TABLE rpg.phb_background_tool_option (
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  item_id BIGINT NOT NULL REFERENCES rpg.phb_item(id),
  PRIMARY KEY (background_id, item_id)
);

CREATE INDEX idx_phb_background_tool_option_item
  ON rpg.phb_background_tool_option(item_id);

-- Magias concedidas por talento ou espécie (unificado; linhagens via option_value + traits)

CREATE TABLE rpg.phb_spell_grant (
  origin_type rpg.spell_grant_origin NOT NULL,
  origin_id BIGINT NOT NULL,
  spell_id BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  unlock_level INT NOT NULL DEFAULT 1,
  PRIMARY KEY (origin_type, origin_id, spell_id, unlock_level)
);

CREATE INDEX idx_phb_spell_grant_origin ON rpg.phb_spell_grant(origin_type, origin_id);

CREATE TABLE rpg.phb_combat_modifier (
  id BIGSERIAL PRIMARY KEY,
  kind rpg.combat_modifier_kind NOT NULL,
  owner_kind rpg.combat_modifier_owner NOT NULL,
  owner_id BIGINT NOT NULL,
  label TEXT NOT NULL,
  flat_bonus INTEGER NOT NULL DEFAULT 0,
  per_level_bonus INTEGER NOT NULL DEFAULT 0,
  from_level INTEGER NOT NULL DEFAULT 1 CHECK (from_level >= 1),
  second_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  allows_shield BOOLEAN NOT NULL DEFAULT FALSE,
  min_trait_takes INTEGER NOT NULL DEFAULT 1 CHECK (min_trait_takes >= 1),
  heritage_trait_id BIGINT NULL REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE,
  CONSTRAINT pcm_kind_fields CHECK (
    (kind = 'hp_bonus' AND second_ability_slug IS NULL
      AND owner_kind IN ('species', 'subclass', 'feat', 'heritage'))
    OR (kind = 'unarmored_defense' AND second_ability_slug IS NOT NULL
      AND flat_bonus = 0 AND per_level_bonus = 0
      AND owner_kind IN ('class', 'subclass'))
  ),
  CONSTRAINT pcm_heritage_trait_owner CHECK (
    (owner_kind = 'heritage' AND heritage_trait_id IS NOT NULL AND owner_id = heritage_trait_id)
    OR (owner_kind <> 'heritage' AND heritage_trait_id IS NULL)
  )
);

CREATE INDEX idx_phb_combat_modifier_owner
  ON rpg.phb_combat_modifier(kind, owner_kind, owner_id);

CREATE INDEX idx_phb_combat_modifier_heritage_trait
  ON rpg.phb_combat_modifier(heritage_trait_id)
  WHERE heritage_trait_id IS NOT NULL;

-- Class economy actions (Actions tab catalog)

CREATE TABLE rpg.phb_class_economy_action (
  id                      BIGSERIAL PRIMARY KEY,
  action_id               TEXT UNIQUE NOT NULL,
  class_id                BIGINT REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id             BIGINT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  name                    TEXT NOT NULL,
  economy                 rpg.action_economy_bucket NOT NULL,
  unlock_level            INT NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  resource_slug           TEXT NULL,
  free_resource_slug      TEXT NULL,
  always_spends_resource  BOOLEAN NOT NULL DEFAULT false,
  summary                 TEXT NULL,
  description             TEXT NULL,
  table_action            TEXT NULL,
  spend_amount            INT NULL CHECK (spend_amount IS NULL OR spend_amount >= 1),
  sort_order              INT NOT NULL DEFAULT 0,
  species_id BIGINT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  requires_option_key TEXT NULL,
  requires_option_value TEXT NULL,
  feat_id BIGINT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  item_id BIGINT NULL REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  spell_slug TEXT NULL REFERENCES rpg.phb_spell(slug),
  min_trait_takes INTEGER NOT NULL DEFAULT 1 CHECK (min_trait_takes >= 1),
  heritage_trait_id BIGINT NULL REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE,
  CONSTRAINT phb_class_economy_action_owner_xor CHECK (
    (class_id IS NOT NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (class_id IS NULL AND species_id IS NOT NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NOT NULL AND item_id IS NULL AND heritage_trait_id IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NOT NULL AND heritage_trait_id IS NULL)
    OR (class_id IS NULL AND species_id IS NULL AND feat_id IS NULL AND item_id IS NULL AND heritage_trait_id IS NOT NULL)
  )
);

CREATE INDEX idx_class_economy_action_class ON rpg.phb_class_economy_action(class_id);
CREATE INDEX idx_class_economy_action_subclass ON rpg.phb_class_economy_action(subclass_id);
CREATE INDEX idx_class_economy_action_heritage_trait
  ON rpg.phb_class_economy_action(heritage_trait_id)
  WHERE heritage_trait_id IS NOT NULL;

-- Battle Master (Fighter) maneuvers catalog

CREATE TABLE rpg.phb_battle_master_maneuver (
  id                BIGSERIAL PRIMARY KEY,
  slug              TEXT UNIQUE NOT NULL,
  name              TEXT NOT NULL,
  description       TEXT NOT NULL,
  timing            rpg.battle_master_maneuver_timing NOT NULL,
  adds_to_damage    BOOLEAN NOT NULL DEFAULT false,
  adds_to_attack    BOOLEAN NOT NULL DEFAULT false
);

CREATE INDEX idx_battle_master_maneuver_slug ON rpg.phb_battle_master_maneuver(slug);

-- Idiomas fixos concedidos por antecedente (PHB 2024)

CREATE TABLE rpg.phb_background_language (
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  language_id BIGINT NOT NULL REFERENCES rpg.phb_language(id),
  PRIMARY KEY (background_id, language_id)
);

-- Conjuração por subclasse (Spellslinger etc.)

CREATE TABLE rpg.phb_subclass_spellcasting (
  subclass_id BIGINT PRIMARY KEY REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  casting_type rpg.casting_type NOT NULL,
  ability_id BIGINT REFERENCES rpg.phb_ability(id),
  focus_label TEXT,
  focus_item_id BIGINT REFERENCES rpg.phb_item(id),
  spell_list_class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id),
  spell_slot_pattern_id BIGINT NOT NULL REFERENCES rpg.phb_spell_slot_pattern(id),
  ritual BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_subclass_spellcasting_list
  ON rpg.phb_subclass_spellcasting(spell_list_class_id);

-- Cotas de truques / magias preparadas por nível (subclasse conjuradora)

CREATE TABLE rpg.phb_subclass_progression (
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  cantrips INTEGER CHECK (cantrips IS NULL OR cantrips >= 0),
  prepared_spells INTEGER CHECK (prepared_spells IS NULL OR prepared_spells >= 0),
  PRIMARY KEY (subclass_id, level)
);

CREATE INDEX idx_subclass_progression_subclass
  ON rpg.phb_subclass_progression(subclass_id);

-- Cunning Strike effects (Rogue) catalog

CREATE TABLE rpg.phb_cunning_strike_effect (
  id              BIGSERIAL PRIMARY KEY,
  slug            TEXT UNIQUE NOT NULL,
  name            TEXT NOT NULL,
  cost            INT NOT NULL CHECK (cost >= 1),
  unlock_level    INT NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  save_ability    rpg.save_ability NULL,
  subclass_id     BIGINT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  note            TEXT NOT NULL
);

CREATE INDEX idx_cunning_strike_effect_slug ON rpg.phb_cunning_strike_effect(slug);
CREATE INDEX idx_cunning_strike_effect_subclass ON rpg.phb_cunning_strike_effect(subclass_id);

-- Subclass precaution spells (Dungeoneer Fighter)

CREATE TABLE rpg.phb_subclass_precaution_spell (
  subclass_id   BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  spell_id      BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  PRIMARY KEY (subclass_id, spell_id)
);

CREATE INDEX idx_subclass_precaution_spell_subclass ON rpg.phb_subclass_precaution_spell(subclass_id);
CREATE INDEX idx_subclass_precaution_spell_spell ON rpg.phb_subclass_precaution_spell(spell_id);

-- Pré-requisitos estruturados de talentos.

CREATE TABLE rpg.phb_feat_requirement (
  feat_id BIGINT PRIMARY KEY REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  minimum_level INTEGER CHECK (minimum_level BETWEEN 1 AND 20),
  requires_spellcasting BOOLEAN NOT NULL DEFAULT FALSE,
  required_armor_category_id BIGINT REFERENCES rpg.phb_armor_category(id),
  requires_fighting_style BOOLEAN NOT NULL DEFAULT FALSE,
  requires_weapon_mastery BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE rpg.phb_feat_requirement_ability (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  ability_id BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  minimum_score INTEGER NOT NULL CHECK (minimum_score BETWEEN 1 AND 30),
  PRIMARY KEY (feat_id, ability_id)
);

-- Aumentos de atributo concedidos por capacidade de classe em um nível fixo
-- (ex.: Bárbaro "Campeão Primitivo" e Monge "Corpo e Mente" no nível 20),
-- que elevam atributos acima do teto normal de 20 até um teto próprio.
CREATE TABLE rpg.phb_class_ability_boost (
  id BIGSERIAL PRIMARY KEY,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  ability_slug TEXT NOT NULL REFERENCES rpg.phb_ability(slug),
  label TEXT NOT NULL,
  bonus INTEGER NOT NULL CHECK (bonus > 0),
  score_max INTEGER NOT NULL CHECK (score_max BETWEEN 20 AND 30),
  from_level INTEGER NOT NULL DEFAULT 1 CHECK (from_level BETWEEN 1 AND 20),
  UNIQUE (class_id, ability_slug, from_level)
);

-- Permite elegibilidade de maestria só para armas à distância (Pistoleiro Valdas).
-- Gunslinger (Valdas) maneuvers catalog

CREATE TABLE rpg.phb_gunslinger_maneuver (
  id              BIGSERIAL PRIMARY KEY,
  slug            TEXT UNIQUE NOT NULL,
  name            TEXT NOT NULL,
  description     TEXT NOT NULL,
  effect_kind     rpg.maneuver_effect_kind NOT NULL,
  risk_cost       INT NOT NULL DEFAULT 1 CHECK (risk_cost >= 1),
  from_level      INT NOT NULL CHECK (from_level BETWEEN 1 AND 20),
  subclass_id     BIGINT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE
);

CREATE INDEX idx_gunslinger_maneuver_slug ON rpg.phb_gunslinger_maneuver(slug);
CREATE INDEX idx_gunslinger_maneuver_subclass ON rpg.phb_gunslinger_maneuver(subclass_id);

-- Beastborne Aspect benefits by level (Barbarian)

CREATE TABLE rpg.phb_beastborne_aspect_benefit (
  aspect_level  INT PRIMARY KEY CHECK (aspect_level BETWEEN 1 AND 5),
  note          TEXT NOT NULL
);

-- Dungeoneer slayer types (Fighter subclass)

CREATE TABLE rpg.phb_dungeoneer_slayer_type (
  id          BIGSERIAL PRIMARY KEY,
  slug        TEXT UNIQUE NOT NULL,
  label       TEXT NOT NULL,
  sort_order  INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_dungeoneer_slayer_type_slug ON rpg.phb_dungeoneer_slayer_type(slug);

-- Subclass table actions (Psi Warrior, Soulknife, etc.)

CREATE TABLE rpg.phb_subclass_table_action (
  id                      BIGSERIAL PRIMARY KEY,
  subclass_id             BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  slug                    TEXT NOT NULL,
  name                    TEXT NOT NULL,
  unlock_level            INT NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  free_resource_slug      TEXT NULL,
  always_spends_pool      BOOLEAN NOT NULL DEFAULT false,
  rolls_pool_die          BOOLEAN NOT NULL DEFAULT false,
  spends_only_on_success  BOOLEAN NOT NULL DEFAULT false,
  always_pool_cost        INT NULL CHECK (always_pool_cost IS NULL OR always_pool_cost >= 1),
  repeat_pool_cost        INT NULL CHECK (repeat_pool_cost IS NULL OR repeat_pool_cost >= 1),
  UNIQUE(subclass_id, slug)
);

CREATE INDEX idx_subclass_table_action_subclass ON rpg.phb_subclass_table_action(subclass_id);

-- Persona masks for College of Masks (Bard)

CREATE TABLE rpg.phb_persona_mask (
  id            BIGSERIAL PRIMARY KEY,
  slug          TEXT UNIQUE NOT NULL,
  name          TEXT NOT NULL,
  subclass_id   BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE
);

CREATE INDEX idx_persona_mask_slug ON rpg.phb_persona_mask(slug);
CREATE INDEX idx_persona_mask_subclass ON rpg.phb_persona_mask(subclass_id);

-- Class panel actions (combat class panel buttons)

CREATE TABLE rpg.phb_class_panel_action (
  id              BIGSERIAL PRIMARY KEY,
  panel_key       TEXT UNIQUE NOT NULL,
  class_id        BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id     BIGINT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  slug            TEXT NOT NULL,
  name            TEXT NOT NULL,
  title           TEXT NULL,
  unlock_level    INT NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  resource_slug   TEXT NULL,
  section         rpg.panel_action_section NOT NULL,
  spends_focus    BOOLEAN NOT NULL DEFAULT false,
  sort_order      INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_class_panel_action_class ON rpg.phb_class_panel_action(class_id);
CREATE INDEX idx_class_panel_action_subclass ON rpg.phb_class_panel_action(subclass_id);

-- Economy actions: class XOR species; filtro opcional por escolha de espécie.









CREATE INDEX idx_class_economy_action_species
  ON rpg.phb_class_economy_action(species_id);

-- Recursos com dono talento (scope = feat).







CREATE UNIQUE INDEX uq_resource_feat
  ON rpg.phb_resource_definition (feat_id, slug)
  WHERE scope = 'feat';

-- Economy actions: class XOR species XOR feat.







CREATE INDEX idx_class_economy_action_feat
  ON rpg.phb_class_economy_action(feat_id);

-- Recursos com dono item (scope = item).







CREATE UNIQUE INDEX uq_resource_item
  ON rpg.phb_resource_definition (item_id, slug)
  WHERE scope = 'item';

-- Economy actions: class XOR species XOR feat XOR item.







CREATE INDEX idx_class_economy_action_item
  ON rpg.phb_class_economy_action(item_id);

-- Tipos + tabela de Invocações Místicas (Bruxo PHB 2024)

CREATE TABLE rpg.phb_eldritch_invocation (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  min_level INTEGER NOT NULL DEFAULT 1 CHECK (min_level BETWEEN 1 AND 20),
  requires_pact_slug TEXT CHECK (
    requires_pact_slug IS NULL
    OR requires_pact_slug IN (
      'pact-of-the-tome',
      'pact-of-the-blade',
      'pact-of-the-chain'
    )
  ),
  requires_invocation_slug TEXT REFERENCES rpg.phb_eldritch_invocation(slug),
  repeatable BOOLEAN NOT NULL DEFAULT FALSE,
  kind rpg.eldritch_invocation_kind NOT NULL DEFAULT 'passive',
  granted_spell_slug TEXT REFERENCES rpg.phb_spell(slug),
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_phb_eldritch_invocation_min_level
  ON rpg.phb_eldritch_invocation(min_level);

-- Catálogo de Metamagia (Feiticeiro PHB 2024)

CREATE TABLE rpg.phb_metamagic (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  cost SMALLINT NOT NULL CHECK (cost IN (1, 2)),
  stacks_with_other BOOLEAN NOT NULL DEFAULT FALSE,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_phb_metamagic_sort
  ON rpg.phb_metamagic(sort_order);

-- Recover 1dN ao Descanso Longo (amanhecer) para pools de cargas de item.


COMMENT ON COLUMN rpg.phb_resource_grant.recover_on_long_dice IS
  'Expressão NdM[+K] recuperada no long rest (ex. 1d6+1). NULL = usa recover_all_on_long.';

-- Fase 6: liga economy action → magia do catálogo (cast de item).


CREATE INDEX idx_class_economy_action_spell
  ON rpg.phb_class_economy_action(spell_slug)
  WHERE spell_slug IS NOT NULL;

-- Tabelas 1d100 de propriedades aleatórias de Artefato (DMG Treasure).
CREATE TABLE rpg.dmg_artifact_random_property (
  id          BIGSERIAL PRIMARY KEY,
  kind        TEXT NOT NULL CHECK (
    kind IN (
      'minor_beneficial',
      'major_beneficial',
      'minor_detrimental',
      'major_detrimental'
    )
  ),
  roll_min    SMALLINT NOT NULL CHECK (roll_min BETWEEN 1 AND 100),
  roll_max    SMALLINT NOT NULL CHECK (roll_max BETWEEN 1 AND 100),
  slug        TEXT NOT NULL,
  summary_pt  TEXT NOT NULL,
  effect      JSONB NOT NULL DEFAULT '{}'::jsonb,
  CONSTRAINT dmg_artifact_random_property_range_check CHECK (roll_min <= roll_max),
  CONSTRAINT dmg_artifact_random_property_kind_slug_unique UNIQUE (kind, slug)
);

CREATE INDEX idx_dmg_artifact_random_property_kind
  ON rpg.dmg_artifact_random_property (kind);

CREATE INDEX idx_dmg_artifact_random_property_roll
  ON rpg.dmg_artifact_random_property (kind, roll_min, roll_max);

COMMENT ON TABLE rpg.dmg_artifact_random_property IS
  'Faixas 1d100 de propriedades aleatórias de artefato (benéfica/prejudicial × menor/maior).';

-- Tabelas de geração de item senciente (DMG Treasure — Sentient Magic Items).
CREATE TABLE rpg.dmg_sentient_trait_table (
  id          BIGSERIAL PRIMARY KEY,
  kind        TEXT NOT NULL CHECK (
    kind IN (
      'alignment',
      'communication',
      'senses',
      'special_purpose',
      'ability_scores'
    )
  ),
  roll_min    SMALLINT NOT NULL CHECK (roll_min >= 1),
  roll_max    SMALLINT NOT NULL CHECK (roll_max >= 1),
  slug        TEXT NOT NULL,
  summary_pt  TEXT NOT NULL,
  payload     JSONB NOT NULL DEFAULT '{}'::jsonb,
  CONSTRAINT dmg_sentient_trait_table_range_check CHECK (roll_min <= roll_max),
  CONSTRAINT dmg_sentient_trait_table_kind_slug_unique UNIQUE (kind, slug)
);

CREATE INDEX idx_dmg_sentient_trait_table_kind
  ON rpg.dmg_sentient_trait_table (kind);

CREATE INDEX idx_dmg_sentient_trait_table_roll
  ON rpg.dmg_sentient_trait_table (kind, roll_min, roll_max);

COMMENT ON TABLE rpg.dmg_sentient_trait_table IS
  'Faixas de rolagem para gerar alinhamento/comunicação/sentidos/propósito/attrs de item senciente.';

-- Contadores de catálogo (view/purchase) — não polui phb_item (seed-owned).
CREATE TABLE rpg.phb_item_catalog_stats (
  item_slug       TEXT PRIMARY KEY
    REFERENCES rpg.phb_item (slug) ON DELETE CASCADE,
  view_count      BIGINT NOT NULL DEFAULT 0
    CHECK (view_count >= 0),
  purchase_count  BIGINT NOT NULL DEFAULT 0
    CHECK (purchase_count >= 0),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_phb_item_catalog_stats_purchase
  ON rpg.phb_item_catalog_stats (purchase_count DESC);

CREATE INDEX idx_phb_item_catalog_stats_view
  ON rpg.phb_item_catalog_stats (view_count DESC);

COMMENT ON TABLE rpg.phb_item_catalog_stats IS
  'Telemetria de catálogo: visualizações e compras (Beyond shop).';

-- Marca opção de catálogo com edição de origem (ex.: lineages Northlands no Elfo PHB).
-- NULL = herda da espécie-pai / sempre disponível com ela.


-- Pré-requisito: talento(s) já adquiridos.

CREATE TABLE rpg.phb_feat_requirement_feat (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  required_feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id),
  PRIMARY KEY (feat_id, required_feat_id),
  CONSTRAINT phb_feat_requirement_feat_no_self CHECK (feat_id <> required_feat_id)
);

CREATE INDEX idx_phb_feat_requirement_feat_required
  ON rpg.phb_feat_requirement_feat (required_feat_id);

-- Pré-requisitos adicionais de talentos: perícia, espécie (OR) e Maestria em Arma.



CREATE TABLE rpg.phb_feat_requirement_skill (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  skill_id BIGINT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (feat_id, skill_id)
);

CREATE TABLE rpg.phb_feat_requirement_species (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id),
  PRIMARY KEY (feat_id, species_id)
);

CREATE INDEX idx_phb_feat_requirement_skill_skill
  ON rpg.phb_feat_requirement_skill (skill_id);

CREATE INDEX idx_phb_feat_requirement_species_species
  ON rpg.phb_feat_requirement_species (species_id);

-- Proficiência de arma exigida + opção de talento pré-requisito (ex.: Adepto Elemental / tipo).

CREATE TABLE rpg.phb_feat_requirement_weapon_proficiency (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  proficiency_slug TEXT NOT NULL,
  PRIMARY KEY (feat_id, proficiency_slug)
);

CREATE TABLE rpg.phb_feat_requirement_feat_option (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat_requirement(feat_id) ON DELETE CASCADE,
  required_feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id),
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  PRIMARY KEY (feat_id, required_feat_id, option_key, value_id)
);

CREATE INDEX idx_phb_feat_requirement_feat_option_required
  ON rpg.phb_feat_requirement_feat_option (required_feat_id);

-- Opções de talento de origem quando o antecedente não tem feat_id fixo.

CREATE TABLE rpg.phb_background_feat_option (
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id),
  PRIMARY KEY (background_id, feat_id)
);

CREATE INDEX idx_phb_background_feat_option_feat
  ON rpg.phb_background_feat_option (feat_id);

-- Catálogo read-only: templates de criatura (stat blocks)

CREATE TABLE rpg.phb_creature_template (
  slug TEXT PRIMARY KEY,
  edition_slug TEXT NOT NULL REFERENCES rpg.phb_edition(slug),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  creature_type TEXT NOT NULL,
  creature_subtype TEXT,
  size_slug TEXT,
  challenge_rating TEXT,
  proficiency_bonus INT CHECK (proficiency_bonus IS NULL OR proficiency_bonus BETWEEN 0 AND 9),
  armor_class INT,
  hit_points_avg INT CHECK (hit_points_avg IS NULL OR hit_points_avg >= 0),
  hit_points_formula TEXT,
  spellcasting_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  spell_save_dc INT CHECK (spell_save_dc IS NULL OR spell_save_dc BETWEEN 1 AND 40),
  spell_attack_bonus INT CHECK (spell_attack_bonus IS NULL OR spell_attack_bonus BETWEEN -10 AND 30),
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  subtitle TEXT,
  alignment TEXT,
  initiative_modifier INT,
  ability_scores JSONB,
  image_url TEXT
);

CREATE TABLE rpg.phb_creature_template_speed (
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  movement_kind TEXT NOT NULL CHECK (char_length(movement_kind) BETWEEN 1 AND 32),
  speed_ft INT NOT NULL CHECK (speed_ft >= 0),
  PRIMARY KEY (template_slug, movement_kind)
);

CREATE TABLE rpg.phb_creature_template_action (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  action_bucket rpg.actor_action_bucket NOT NULL DEFAULT 'action',
  attack_bonus INT,
  damage_expression TEXT,
  reach_ft INT CHECK (reach_ft IS NULL OR reach_ft >= 0),
  sort_order INT NOT NULL DEFAULT 0,
  description TEXT
);

CREATE INDEX idx_phb_creature_template_action_slug
  ON rpg.phb_creature_template_action(template_slug);

CREATE TABLE rpg.phb_creature_template_spell (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell(slug),
  usage_kind rpg.innate_spell_usage NOT NULL,
  uses_per_day INT CHECK (uses_per_day IS NULL OR uses_per_day >= 1),
  slot_level INT CHECK (slot_level IS NULL OR slot_level BETWEEN 0 AND 9),
  recharge_dice TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  UNIQUE (template_slug, spell_slug, usage_kind, slot_level)
);

CREATE TABLE rpg.phb_creature_template_trait (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
  sort_order INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_phb_creature_template_trait_slug
  ON rpg.phb_creature_template_trait(template_slug);

CREATE TABLE rpg.phb_vehicle_template (
  slug TEXT PRIMARY KEY,
  edition_slug TEXT NOT NULL REFERENCES rpg.phb_edition(slug),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  armor_class INT,
  hit_points INT CHECK (hit_points IS NULL OR hit_points >= 0),
  damage_threshold INT CHECK (damage_threshold IS NULL OR damage_threshold >= 0),
  crew_capacity INT CHECK (crew_capacity IS NULL OR crew_capacity >= 0),
  cargo_capacity_lb INT CHECK (cargo_capacity_lb IS NULL OR cargo_capacity_lb >= 0),
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  subtitle TEXT,
  passenger_capacity INT CHECK (passenger_capacity IS NULL OR passenger_capacity >= 0),
  initiative_modifier INT,
  ability_scores JSONB,
  cargo_capacity_label TEXT,
  image_url TEXT
);

CREATE TABLE rpg.phb_vehicle_template_speed (
  template_slug TEXT NOT NULL REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  movement_kind TEXT NOT NULL CHECK (char_length(movement_kind) BETWEEN 1 AND 32),
  speed_ft INT NOT NULL CHECK (speed_ft >= 0),
  PRIMARY KEY (template_slug, movement_kind)
);

CREATE TABLE rpg.phb_vehicle_template_action (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  action_bucket rpg.actor_action_bucket NOT NULL DEFAULT 'action',
  attack_bonus INT,
  damage_expression TEXT,
  reach_ft INT CHECK (reach_ft IS NULL OR reach_ft >= 0),
  sort_order INT NOT NULL DEFAULT 0,
  description TEXT
);

CREATE INDEX idx_phb_vehicle_template_action_slug
  ON rpg.phb_vehicle_template_action(template_slug);

-- Stat blocks completos: atributos, descrição de ações, veículos Northlands









CREATE TABLE rpg.phb_vehicle_template_trait (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_vehicle_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
  sort_order INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_phb_vehicle_template_trait_slug
  ON rpg.phb_vehicle_template_trait(template_slug);

-- Character Threads (Northlands) — catálogo

CREATE TABLE rpg.phb_character_thread (
  slug TEXT PRIMARY KEY,
  edition_slug TEXT NOT NULL REFERENCES rpg.phb_edition(slug),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  summary TEXT NOT NULL,
  special_rules_text TEXT,
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  sort_order INT NOT NULL DEFAULT 0
);

CREATE TABLE rpg.phb_character_thread_goal (
  id BIGSERIAL PRIMARY KEY,
  thread_slug TEXT NOT NULL REFERENCES rpg.phb_character_thread(slug) ON DELETE CASCADE,
  sort_order INT NOT NULL CHECK (sort_order BETWEEN 1 AND 6),
  text TEXT NOT NULL,
  UNIQUE (thread_slug, sort_order)
);

CREATE TABLE rpg.phb_character_thread_milestone (
  id BIGSERIAL PRIMARY KEY,
  thread_slug TEXT NOT NULL REFERENCES rpg.phb_character_thread(slug) ON DELETE CASCADE,
  rank TEXT NOT NULL CHECK (rank IN ('least', 'lesser', 'greater', 'superior')),
  sort_order INT NOT NULL CHECK (sort_order BETWEEN 1 AND 4),
  UNIQUE (thread_slug, rank),
  UNIQUE (thread_slug, sort_order)
);

CREATE TABLE rpg.phb_character_thread_milestone_benefit (
  id BIGSERIAL PRIMARY KEY,
  milestone_id BIGINT NOT NULL REFERENCES rpg.phb_character_thread_milestone(id) ON DELETE CASCADE,
  benefit_key TEXT NOT NULL CHECK (char_length(benefit_key) BETWEEN 1 AND 64),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
  choice_group TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  UNIQUE (milestone_id, benefit_key)
);

CREATE INDEX idx_phb_character_thread_goal_thread
  ON rpg.phb_character_thread_goal(thread_slug);
CREATE INDEX idx_phb_character_thread_milestone_thread
  ON rpg.phb_character_thread_milestone(thread_slug);
CREATE INDEX idx_phb_character_thread_milestone_benefit_ms
  ON rpg.phb_character_thread_milestone_benefit(milestone_id);

-- Ilustrações de catálogo (montarias, criaturas, veículos, itens da loja)







COMMENT ON COLUMN rpg.phb_creature_template.image_url IS
  'Caminho público da ilustração (ex. /catalog/mounts/camelo.png no front).';

COMMENT ON COLUMN rpg.phb_vehicle_template.image_url IS
  'Caminho público da ilustração no front.';

COMMENT ON COLUMN rpg.phb_item.image_url IS
  'Caminho público da ilustração no front (loja/compêndio).';

-- Ilustrações de espécies e subclasses no compêndio





COMMENT ON COLUMN rpg.phb_species.image_url IS
  'Caminho público da ilustração (ex. /catalog/species/feathren.png).';

COMMENT ON COLUMN rpg.phb_subclass.image_url IS
  'Caminho público da ilustração (ex. /catalog/subclasses/path-of-the-glacier.png).';

-- Grim Hollow — build tradicional sugerido por herança (preset 8 traços)

CREATE TABLE rpg.phb_heritage_traditional (
  id BIGSERIAL PRIMARY KEY,
  heritage_id BIGINT NOT NULL REFERENCES rpg.phb_heritage(id) ON DELETE CASCADE,
  trait_id BIGINT NOT NULL REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE,
  sort_order INTEGER NOT NULL DEFAULT 0,
  category_hint rpg.heritage_trait_category,
  UNIQUE (heritage_id, trait_id)
);

CREATE INDEX idx_phb_heritage_traditional_heritage
  ON rpg.phb_heritage_traditional(heritage_id, sort_order);

COMMENT ON TABLE rpg.phb_heritage_traditional IS
  'Preset recomendado por herança (3+3+2 combate/exploração/interpretação) — atalho no wizard.';



-- Função de auditoria updated_at

CREATE OR REPLACE FUNCTION rpg.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_phb_heritage_updated_at
  BEFORE UPDATE ON rpg.phb_heritage
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_heritage_trait_updated_at
  BEFORE UPDATE ON rpg.phb_heritage_trait
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

-- Triggers updated_at em tabelas PHB

CREATE TRIGGER tr_phb_spell_updated_at BEFORE UPDATE ON rpg.phb_spell FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_class_updated_at BEFORE UPDATE ON rpg.phb_class FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_subclass_updated_at BEFORE UPDATE ON rpg.phb_subclass FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_species_updated_at BEFORE UPDATE ON rpg.phb_species FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_background_updated_at BEFORE UPDATE ON rpg.phb_background FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_feat_updated_at BEFORE UPDATE ON rpg.phb_feat FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TRIGGER tr_phb_item_updated_at BEFORE UPDATE ON rpg.phb_item FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE VIEW rpg.v_phb_ability_generation_method AS
SELECT slug, name, description FROM (VALUES
  ('standard-array'::rpg.ability_generation_method, 'Conjunto Padrão', 'Use os seis valores fixos abaixo e atribua a Força, Destreza, Constituição, Inteligência, Sabedoria e Carisma.'),
  ('roll'::rpg.ability_generation_method, 'Geração Aleatória', 'Jogue 4d6, descarte o menor dado e some os três restantes. Repita seis vezes. A soma dos seis atributos costuma ficar entre 72 e 80 (média ~73).'),
  ('point-buy'::rpg.ability_generation_method, 'Custo de Pontos', '27 pontos para distribuir entre os seis atributos, conforme a tabela de custos.')
) AS t(slug, name, description);

CREATE VIEW rpg.v_phb_feat_category AS
SELECT slug, name, type_label, sort_order FROM (VALUES
  ('origin'::rpg.feat_category, 'Origem', 'Talento de Origem', 1),
  ('general'::rpg.feat_category, 'Geral', 'Talento Geral', 2),
  ('fighting-style'::rpg.feat_category, 'Estilo de Luta', 'Talento de Estilo de Luta', 3),
  ('epic-boon'::rpg.feat_category, 'Dádiva Épica', 'Talento de Dádiva Épica', 4),
  ('gh-transformation'::rpg.feat_category, 'Transformação GH', 'Transformação Grim Hollow', 5)
) AS t(slug, name, type_label, sort_order);

CREATE VIEW rpg.v_phb_weapon_proficiency AS
SELECT slug, label FROM (VALUES
  ('armas-simples', 'Armas Simples'),
  ('armas-marciais', 'Armas Marciais'),
  ('armas-avancadas', 'Armas Avançadas'),
  ('adagas', 'Adagas'),
  ('dardos', 'Dardos'),
  ('fundas', 'Fundas'),
  ('bordoes', 'Bordões'),
  ('bestas-leves', 'Bestas Leves'),
  ('bestas-de-mao', 'Bestas de Mão'),
  ('espada-longa', 'Espada Longa'),
  ('rapieira', 'Rapieira'),
  ('espada-curta', 'Espada Curta'),
  ('machadinhas', 'Machadinhas'),
  ('armas-marciais-leves', 'Armas Marciais (leves)'),
  ('armas-marciais-a-distancia', 'Armas Marciais (à Distância)')
) AS t(slug, label);


CREATE VIEW rpg.v_spell_by_class AS
SELECT
  c.slug AS class_slug,
  c.name AS class_name,
  s.level AS spell_level,
  s.slug AS spell_slug,
  s.name AS spell_name,
  sch.slug AS school_slug,
  sch.name AS school_name
FROM rpg.phb_class c
JOIN rpg.phb_spell_class sc ON sc.class_id = c.id
JOIN rpg.phb_spell s ON s.id = sc.spell_id
JOIN rpg.phb_spell_school sch ON sch.id = s.school_id;


CREATE VIEW rpg.v_phb_spell AS
SELECT
  s.slug,
  s.name,
  s.level,
  s.level_label,
  sch.slug AS school_slug,
  sch.name AS school_name,
  s.casting_time,
  s.range,
  s.has_verbal,
  s.has_somatic,
  s.has_material,
  s.material_description,
  s.components_label,
  s.duration,
  s.concentration,
  s.ritual,
  s.description,
  s.higher_levels,
  sc.chapter AS source_chapter,
  e.slug AS edition_slug,
  a.slug AS save_ability_slug,
  s.requires_attack_roll
FROM rpg.phb_spell s
JOIN rpg.phb_spell_school sch ON sch.id = s.school_id
LEFT JOIN rpg.phb_ability a ON a.id = s.save_ability_id
LEFT JOIN rpg.phb_source_citation sc ON sc.id = s.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id;


CREATE VIEW rpg.v_phb_subclass_prepared_spell AS
SELECT
  s.slug AS subclass_slug,
  ps.unlock_level,
  sp.slug AS spell_slug,
  sp.name AS spell_name,
  ps.terrain::text AS terrain_slug,
  INITCAP(ps.terrain::text) AS terrain_label
FROM rpg.phb_subclass_prepared_spell ps
JOIN rpg.phb_subclass s ON s.id = ps.subclass_id
JOIN rpg.phb_spell sp ON sp.id = ps.spell_id;


CREATE VIEW rpg.v_phb_subclass_spells_expected AS
SELECT
  c.slug AS class_slug,
  s.slug AS subclass_slug,
  ps.unlock_level,
  sp.slug AS spell_slug,
  ss.slug AS spell_source_slug
FROM rpg.phb_subclass_prepared_spell ps
JOIN rpg.phb_subclass s ON s.id = ps.subclass_id
JOIN rpg.phb_class c ON c.id = s.class_id
JOIN rpg.phb_spell sp ON sp.id = ps.spell_id
LEFT JOIN rpg.phb_spell_source ss ON ss.subclass_id = s.id AND ss.origin_type = 'subclass';




CREATE VIEW rpg.v_phb_background_equipment AS
SELECT
  b.slug AS background_slug,
  p.slug AS package_slug,
  p.label AS package_label,
  p.gold AS package_gold,
  si.sort_order,
  i.slug AS item_slug,
  i.name AS item_name,
  si.quantity,
  si.choice_text
FROM rpg.phb_background b
JOIN rpg.phb_starting_package p
  ON p.source = 'background' AND p.owner_id = b.id
JOIN rpg.phb_starting_item si ON si.package_id = p.id
LEFT JOIN rpg.phb_item i ON i.id = si.item_id
ORDER BY b.slug, p.sort_order, si.sort_order;


CREATE VIEW rpg.v_phb_class_equipment AS
SELECT
  c.slug AS class_slug,
  p.slug AS package_slug,
  p.label AS package_label,
  si.sort_order,
  i.slug AS item_slug,
  i.name AS item_name,
  si.quantity,
  si.choice_text,
  si.gold_amount
FROM rpg.phb_class c
JOIN rpg.phb_starting_package p
  ON p.source = 'class' AND p.owner_id = c.id
JOIN rpg.phb_starting_item si ON si.package_id = p.id
LEFT JOIN rpg.phb_item i ON i.id = si.item_id
ORDER BY c.slug, p.sort_order, si.sort_order;


CREATE VIEW rpg.v_phb_class_skill_choice AS
SELECT
  c.slug AS class_slug,
  c.skill_choice_count,
  c.skill_choice_from,
  s.slug AS skill_slug,
  s.name AS skill_name
FROM rpg.phb_class c
JOIN rpg.phb_class_skill_pool p ON p.class_id = c.id
JOIN rpg.phb_skill s ON s.id = p.skill_id
ORDER BY c.slug, s.slug;

-- Opções de truque para Alto Elfo (lista de cantrips de Mago).
-- Kind opcional: não entra nos requiredKinds da validação padrão;
-- validado no application quando presente.

CREATE VIEW rpg.v_phb_high_elf_cantrip_options AS
SELECT
  'elf'::text AS species_slug,
  'high_elf_cantrip'::rpg.species_choice_kind AS choice_kind,
  s.spell_slug AS choice_slug,
  s.spell_name AS choice_name
FROM rpg.v_spell_by_class s
WHERE s.class_slug = 'wizard'
  AND s.spell_level = 0
ORDER BY s.spell_name;



CREATE VIEW rpg.v_phb_background_skill AS
SELECT
  b.slug AS background_slug,
  s.slug AS skill_slug,
  s.name AS skill_name
FROM rpg.phb_background b
JOIN rpg.phb_background_skill bs ON bs.background_id = b.id
JOIN rpg.phb_skill s ON s.id = bs.skill_id
ORDER BY b.slug, s.slug;


-- Enriquece v_phb_background com talento de origem e proficiência em ferramenta

-- Opções de ferramenta quando o antecedente exige escolha (tool_proficiency_kind = choice)

-- Recria a view para incluir feature_description (CREATE OR REPLACE
-- não permite inserir coluna no meio da lista existente).

CREATE VIEW rpg.v_phb_subclass_mechanics AS
SELECT
  c.slug AS class_slug,
  s.slug AS subclass_slug,
  sf.level AS feature_level,
  sf.name AS feature_name,
  sf.description AS feature_description,
  sf.feature_kind,
  sf.option_key,
  rd.slug AS resource_slug,
  rd.name AS resource_name,
  psr.unlock_level AS resource_unlock_level,
  psr.max_formula,
  psr.fixed_max
FROM rpg.phb_subclass_feature sf
JOIN rpg.phb_subclass s ON s.id = sf.subclass_id
JOIN rpg.phb_class c ON c.id = s.class_id
LEFT JOIN rpg.phb_resource_grant psr
  ON psr.owner_kind = 'subclass'::rpg.resource_owner_kind
 AND psr.owner_id = s.id
 AND psr.feature_id = sf.id
LEFT JOIN rpg.phb_resource_definition rd ON rd.id = psr.resource_id;

-- View canônica rpg.v_phb_class (flavor + mastery eligibility)
CREATE VIEW rpg.v_phb_class AS
SELECT
  c.slug AS class_slug,
  c.name AS class_name,
  c.tagline,
  c.summary,
  c.description,
  c.primary_ability_label,
  c.primary_ability_operator,
  UPPER(c.hit_die::text) AS hit_die,
  c.hp_level1_die_value,
  c.hp_fixed_per_level,
  c.skill_choice_count,
  c.skill_choice_from,
  c.weapon_mastery_eligibility,
  array_agg(pa.slug ORDER BY cpa.sort_order) AS primary_ability_slugs,
  sc.chapter AS source_chapter,
  e.slug AS edition_slug
FROM rpg.phb_class c
LEFT JOIN rpg.phb_source_citation sc ON sc.id = c.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id
LEFT JOIN rpg.phb_class_proficiency cpa
  ON cpa.class_id = c.id AND cpa.kind = 'primary_ability'::rpg.class_proficiency_kind
LEFT JOIN rpg.phb_ability pa ON pa.id = cpa.ref_id
GROUP BY c.id, c.slug, c.name, c.tagline, c.summary, c.description,
  c.primary_ability_label, c.primary_ability_operator,
  c.hit_die, c.hp_level1_die_value, c.hp_fixed_per_level, c.skill_choice_count,
  c.skill_choice_from, c.weapon_mastery_eligibility, sc.chapter, e.slug;

-- v_phb_armor: incluir custo e peso do phb_item


CREATE VIEW rpg.v_phb_background_tool_option AS
SELECT
  b.slug AS background_slug,
  i.slug AS item_slug,
  i.name AS item_name,
  tc.slug AS category_slug,
  tc.name AS category_name
FROM rpg.phb_background b
JOIN rpg.phb_background_tool_option opt
  ON opt.background_id = b.id
JOIN rpg.phb_item i ON i.id = opt.item_id
LEFT JOIN rpg.phb_tool t ON t.item_id = i.id
LEFT JOIN rpg.phb_tool_category tc ON tc.id = t.category_id
WHERE b.tool_proficiency_kind = 'choice'
ORDER BY b.slug, i.name;


CREATE VIEW rpg.v_class_spell_slots AS
SELECT
  c.slug AS class_slug,
  cp.level AS class_level,
  p.slug AS pattern_slug,
  p.name AS pattern_name,
  cp.proficiency_bonus,
  cp.cantrips,
  cp.prepared_spells,
  cp.channel_divinity,
  jsonb_object_agg(ss.circle::text, ss.slot_count ORDER BY ss.circle) AS spell_slots
FROM rpg.phb_class c
JOIN rpg.phb_spell_slot_pattern p ON p.id = c.spell_slot_pattern_id
JOIN rpg.phb_class_progression cp ON cp.class_id = c.id
JOIN rpg.phb_spell_slot_by_level ss ON ss.pattern_id = p.id AND ss.level = cp.level
GROUP BY
  c.slug,
  cp.level,
  p.slug,
  p.name,
  cp.proficiency_bonus,
  cp.cantrips,
  cp.prepared_spells,
  cp.channel_divinity;


CREATE VIEW rpg.v_phb_background_language AS
SELECT
  b.slug AS background_slug,
  l.slug AS language_slug,
  l.name AS language_name,
  l.is_rare AS language_is_rare
FROM rpg.phb_background b
JOIN rpg.phb_background_language bl ON bl.background_id = b.id
JOIN rpg.phb_language l ON l.id = bl.language_id
ORDER BY b.slug, l.slug;

-- View unificada: magias concedidas por espécie (fixas + linhagem/legado)
-- Magias fixas de talento (além de featOptions)
CREATE VIEW rpg.v_phb_feat_granted_spell AS
SELECT
  f.slug AS feat_slug,
  s.slug AS spell_slug
FROM rpg.phb_spell_grant g
JOIN rpg.phb_feat f ON f.id = g.origin_id
JOIN rpg.phb_spell s ON s.id = g.spell_id
WHERE g.origin_type = 'feat'::rpg.spell_grant_origin;

-- PV e defesa sem armadura (views de leitura)

CREATE VIEW rpg.v_phb_hp_bonus_source AS
SELECT
  cm.owner_kind::text AS source_kind,
  sp.slug AS source_slug,
  cm.label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_species sp ON sp.id = cm.owner_id
WHERE cm.kind = 'hp_bonus' AND cm.owner_kind = 'species'

UNION ALL

SELECT
  cm.owner_kind::text,
  sc.slug,
  cm.label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_subclass sc ON sc.id = cm.owner_id
WHERE cm.kind = 'hp_bonus' AND cm.owner_kind = 'subclass'

UNION ALL

SELECT
  cm.owner_kind::text,
  f.slug,
  cm.label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_feat f ON f.id = cm.owner_id
WHERE cm.kind = 'hp_bonus' AND cm.owner_kind = 'feat';

CREATE VIEW rpg.v_phb_unarmored_defense AS
SELECT
  cm.owner_kind::text AS source_kind,
  c.slug AS source_slug,
  cm.label,
  cm.second_ability_slug,
  cm.allows_shield
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_class c ON c.id = cm.owner_id
WHERE cm.kind = 'unarmored_defense' AND cm.owner_kind = 'class'

UNION ALL

SELECT
  cm.owner_kind::text,
  sc.slug,
  cm.label,
  cm.second_ability_slug,
  cm.allows_shield
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_subclass sc ON sc.id = cm.owner_id
WHERE cm.kind = 'unarmored_defense' AND cm.owner_kind = 'subclass';

-- Espaços de magia + cotas por nível de personagem (subclasse conjuradora)

CREATE VIEW rpg.v_subclass_spell_slots AS
SELECT
  sc.slug AS subclass_slug,
  c.slug AS class_slug,
  sp.level AS class_level,
  p.slug AS pattern_slug,
  p.name AS pattern_name,
  cp.proficiency_bonus,
  sp.cantrips,
  sp.prepared_spells,
  list_c.slug AS spell_list_class_slug,
  jsonb_object_agg(ss.circle::text, ss.slot_count ORDER BY ss.circle) AS spell_slots
FROM rpg.phb_subclass sc
JOIN rpg.phb_class c ON c.id = sc.class_id
JOIN rpg.phb_subclass_spellcasting ssc ON ssc.subclass_id = sc.id
JOIN rpg.phb_spell_slot_pattern p ON p.id = ssc.spell_slot_pattern_id
JOIN rpg.phb_subclass_progression sp ON sp.subclass_id = sc.id
JOIN rpg.phb_class list_c ON list_c.id = ssc.spell_list_class_id
JOIN rpg.phb_class_progression cp ON cp.class_id = c.id AND cp.level = sp.level
JOIN rpg.phb_spell_slot_by_level ss ON ss.pattern_id = p.id AND ss.level = sp.level
GROUP BY
  sc.slug,
  c.slug,
  sp.level,
  p.slug,
  p.name,
  cp.proficiency_bonus,
  sp.cantrips,
  sp.prepared_spells,
  list_c.slug;

-- Adiciona pré-requisitos estruturados à view de talentos.
-- Aumentos de atributo por classe/nível com a classe normalizada (slug).
CREATE VIEW rpg.v_phb_class_ability_boost AS
SELECT
  c.slug AS class_slug,
  b.ability_slug,
  b.label,
  b.bonus,
  b.score_max,
  b.from_level
FROM rpg.phb_class_ability_boost b
JOIN rpg.phb_class c ON c.id = b.class_id;

-- Magias always_prepared de classe (phb_spell_grant origin=class)

CREATE VIEW rpg.v_phb_class_granted_spell AS
SELECT
  c.slug AS class_slug,
  g.unlock_level,
  s.slug AS spell_slug,
  s.name AS spell_name
FROM rpg.phb_spell_grant g
JOIN rpg.phb_class c ON c.id = g.origin_id
JOIN rpg.phb_spell s ON s.id = g.spell_id
WHERE g.origin_type = 'class'::rpg.spell_grant_origin;


-- Inclui machadinhas (handaxe) nas labels de proficiência de arma.

CREATE VIEW rpg.v_phb_feat AS
SELECT
  feat.slug AS feat_slug,
  feat.name AS feat_name,
  feat.category::text AS category_slug,
  category.name AS category_name,
  category.type_label AS category_type_label,
  feat.repeatable,
  feat.prerequisite,
  citation.chapter AS source_chapter,
  citation.chapter_title AS source_chapter_title,
  edition.slug AS edition_slug,
  COALESCE(benefits.items, '[]'::jsonb) AS benefits,
  requirement.minimum_level,
  COALESCE(ability_requirements.items, '[]'::jsonb) AS ability_prerequisites,
  COALESCE(requirement.requires_spellcasting, FALSE) AS requires_spellcasting,
  armor_category.slug AS required_armor_training_slug,
  COALESCE(requirement.requires_fighting_style, FALSE) AS requires_fighting_style,
  COALESCE(requirement.requires_weapon_mastery, FALSE) AS requires_weapon_mastery,
  COALESCE(required_feats.items, '[]'::jsonb) AS required_feat_slugs,
  COALESCE(required_skills.items, '[]'::jsonb) AS required_skill_slugs,
  COALESCE(required_species.items, '[]'::jsonb) AS required_species_slugs,
  COALESCE(required_weapon_profs.items, '[]'::jsonb) AS required_weapon_proficiency_slugs,
  COALESCE(required_feat_options.items, '[]'::jsonb) AS required_feat_options
FROM rpg.phb_feat feat
JOIN rpg.v_phb_feat_category category ON category.slug = feat.category
LEFT JOIN rpg.phb_feat_requirement requirement ON requirement.feat_id = feat.id
LEFT JOIN rpg.phb_armor_category armor_category
  ON armor_category.id = requirement.required_armor_category_id
LEFT JOIN rpg.phb_source_citation citation ON citation.id = feat.source_citation_id
LEFT JOIN rpg.phb_edition edition ON edition.id = citation.edition_id
LEFT JOIN LATERAL (
  SELECT jsonb_agg(
    jsonb_build_object(
      'abilitySlug', ability.slug,
      'minimumScore', ability_requirement.minimum_score
    )
    ORDER BY ability.sort_order
  ) AS items
  FROM rpg.phb_feat_requirement_ability ability_requirement
  JOIN rpg.phb_ability ability ON ability.id = ability_requirement.ability_id
  WHERE ability_requirement.feat_id = feat.id
) ability_requirements ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(required.slug ORDER BY required.slug) AS items
  FROM rpg.phb_feat_requirement_feat requirement_feat
  JOIN rpg.phb_feat required ON required.id = requirement_feat.required_feat_id
  WHERE requirement_feat.feat_id = feat.id
) required_feats ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(skill.slug ORDER BY skill.slug) AS items
  FROM rpg.phb_feat_requirement_skill requirement_skill
  JOIN rpg.phb_skill skill ON skill.id = requirement_skill.skill_id
  WHERE requirement_skill.feat_id = feat.id
) required_skills ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(species.slug ORDER BY species.slug) AS items
  FROM rpg.phb_feat_requirement_species requirement_species
  JOIN rpg.phb_species species ON species.id = requirement_species.species_id
  WHERE requirement_species.feat_id = feat.id
) required_species ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(weapon_prof.proficiency_slug ORDER BY weapon_prof.proficiency_slug) AS items
  FROM rpg.phb_feat_requirement_weapon_proficiency weapon_prof
  WHERE weapon_prof.feat_id = feat.id
) required_weapon_profs ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(
    jsonb_build_object(
      'featSlug', required.slug,
      'optionKey', feat_option.option_key,
      'valueId', feat_option.value_id
    )
    ORDER BY required.slug, feat_option.option_key, feat_option.value_id
  ) AS items
  FROM rpg.phb_feat_requirement_feat_option feat_option
  JOIN rpg.phb_feat required ON required.id = feat_option.required_feat_id
  WHERE feat_option.feat_id = feat.id
) required_feat_options ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(
    jsonb_strip_nulls(
      jsonb_build_object('name', benefit.name, 'description', benefit.description)
    )
    ORDER BY benefit.sort_order
  ) AS items
  FROM rpg.phb_feat_benefit benefit
  WHERE benefit.feat_id = feat.id
) benefits ON TRUE;

-- Opções de truque para Andari (lista de cantrips de Druida).
-- Kind opcional na validação padrão; exigido quando bearfolk_lineage = andari.

CREATE VIEW rpg.v_phb_andari_druid_cantrip_options AS
SELECT
  'bearfolk'::text AS species_slug,
  'andari_druid_cantrip'::rpg.species_choice_kind AS choice_kind,
  s.spell_slug AS choice_slug,
  s.spell_name AS choice_name
FROM rpg.v_spell_by_class s
WHERE s.class_slug = 'druid'
  AND s.spell_level = 0
ORDER BY s.spell_name;

CREATE VIEW rpg.v_phb_background AS
SELECT
  b.slug AS background_slug,
  b.name AS background_name,
  b.tagline,
  b.summary,
  b.description,
  b.equipment_gold_option,
  b.language_choice_count,
  sc.chapter AS source_chapter,
  sc.chapter_title AS source_chapter_title,
  e.slug AS edition_slug,
  array_agg(ab.slug ORDER BY bao.sort_order)
    FILTER (WHERE ab.slug IS NOT NULL) AS ability_option_slugs,
  array_agg(ab.name ORDER BY bao.sort_order)
    FILTER (WHERE ab.name IS NOT NULL) AS ability_option_names,
  f.slug AS feat_slug,
  f.name AS feat_name,
  COALESCE(
    (
      SELECT array_agg(feat.slug ORDER BY feat.slug)
      FROM rpg.phb_background_feat_option opt
      JOIN rpg.phb_feat feat ON feat.id = opt.feat_id
      WHERE opt.background_id = b.id
    ),
    '{}'::text[]
  ) AS origin_feat_choice_slugs,
  b.tool_proficiency_kind,
  b.tool_proficiency_description,
  ti.slug AS tool_item_slug,
  ti.name AS tool_item_name,
  tc.slug AS tool_category_slug,
  tc.name AS tool_category_name
FROM rpg.phb_background b
LEFT JOIN rpg.phb_source_citation sc ON sc.id = b.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id
LEFT JOIN rpg.phb_feat f ON f.id = b.feat_id
LEFT JOIN rpg.phb_item ti ON ti.id = b.tool_item_id
LEFT JOIN rpg.phb_tool_category tc ON tc.id = b.tool_category_id
LEFT JOIN rpg.phb_background_ability_option bao ON bao.background_id = b.id
LEFT JOIN rpg.phb_ability ab ON ab.id = bao.ability_id
GROUP BY
  b.id,
  b.slug,
  b.name,
  b.tagline,
  b.summary,
  b.description,
  b.equipment_gold_option,
  b.language_choice_count,
  sc.chapter,
  sc.chapter_title,
  e.slug,
  f.slug,
  f.name,
  b.tool_proficiency_kind,
  b.tool_proficiency_description,
  ti.slug,
  ti.name,
  tc.slug,
  tc.name;

-- Magias concedidas por ancestria Giantkin (Nuvem / Tempestade)

-- Views: bundle de template de criatura / veículo (catálogo read-only)

-- Bundle de catálogo: thread + goals + milestones + benefits

CREATE VIEW rpg.v_phb_character_thread_bundle AS
SELECT
  t.slug,
  t.edition_slug,
  t.name,
  t.summary,
  t.special_rules_text,
  t.sort_order,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'sortOrder', g.sort_order,
        'text', g.text
      )
      ORDER BY g.sort_order
    )
    FROM rpg.phb_character_thread_goal g
    WHERE g.thread_slug = t.slug
  ), '[]'::jsonb) AS goals,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'id', m.id,
        'rank', m.rank,
        'sortOrder', m.sort_order,
        'benefits', COALESCE((
          SELECT jsonb_agg(
            jsonb_build_object(
              'benefitKey', b.benefit_key,
              'name', b.name,
              'description', b.description,
              'choiceGroup', b.choice_group,
              'sortOrder', b.sort_order
            )
            ORDER BY b.sort_order, b.benefit_key
          )
          FROM rpg.phb_character_thread_milestone_benefit b
          WHERE b.milestone_id = m.id
        ), '[]'::jsonb)
      )
      ORDER BY m.sort_order
    )
    FROM rpg.phb_character_thread_milestone m
    WHERE m.thread_slug = t.slug
  ), '[]'::jsonb) AS milestones
FROM rpg.phb_character_thread t;

-- Views: expõe image_url nos bundles de criatura/veículo

CREATE VIEW rpg.v_phb_creature_template_bundle AS
SELECT
  t.slug,
  t.edition_slug,
  t.name,
  t.subtitle,
  t.alignment,
  t.creature_type,
  t.creature_subtype,
  t.size_slug,
  t.challenge_rating,
  t.proficiency_bonus,
  t.armor_class,
  t.hit_points_avg,
  t.hit_points_formula,
  t.initiative_modifier,
  t.ability_scores,
  t.image_url,
  t.spellcasting_ability_slug,
  t.spell_save_dc,
  t.spell_attack_bonus,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'movementKind', s.movement_kind,
        'speedFt', s.speed_ft
      )
      ORDER BY s.movement_kind
    )
    FROM rpg.phb_creature_template_speed s
    WHERE s.template_slug = t.slug
  ), '[]'::jsonb) AS speeds,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'id', a.id,
        'name', a.name,
        'actionBucket', a.action_bucket,
        'attackBonus', a.attack_bonus,
        'damageExpression', a.damage_expression,
        'reachFt', a.reach_ft,
        'description', a.description,
        'sortOrder', a.sort_order
      )
      ORDER BY a.sort_order, a.name
    )
    FROM rpg.phb_creature_template_action a
    WHERE a.template_slug = t.slug
  ), '[]'::jsonb) AS actions,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'spellSlug', sp.spell_slug,
        'usageKind', sp.usage_kind,
        'usesPerDay', sp.uses_per_day,
        'slotLevel', sp.slot_level,
        'rechargeDice', sp.recharge_dice,
        'sortOrder', sp.sort_order
      )
      ORDER BY sp.sort_order, sp.spell_slug
    )
    FROM rpg.phb_creature_template_spell sp
    WHERE sp.template_slug = t.slug
  ), '[]'::jsonb) AS spells,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'name', tr.name,
        'description', tr.description,
        'sortOrder', tr.sort_order
      )
      ORDER BY tr.sort_order, tr.name
    )
    FROM rpg.phb_creature_template_trait tr
    WHERE tr.template_slug = t.slug
  ), '[]'::jsonb) AS traits
FROM rpg.phb_creature_template t;

CREATE VIEW rpg.v_phb_vehicle_template_bundle AS
SELECT
  t.slug,
  t.edition_slug,
  t.name,
  t.subtitle,
  t.armor_class,
  t.hit_points,
  t.damage_threshold,
  t.crew_capacity,
  t.passenger_capacity,
  t.cargo_capacity_lb,
  t.cargo_capacity_label,
  t.initiative_modifier,
  t.ability_scores,
  t.image_url,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'movementKind', s.movement_kind,
        'speedFt', s.speed_ft
      )
      ORDER BY s.movement_kind
    )
    FROM rpg.phb_vehicle_template_speed s
    WHERE s.template_slug = t.slug
  ), '[]'::jsonb) AS speeds,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'id', a.id,
        'name', a.name,
        'actionBucket', a.action_bucket,
        'attackBonus', a.attack_bonus,
        'damageExpression', a.damage_expression,
        'reachFt', a.reach_ft,
        'description', a.description,
        'sortOrder', a.sort_order
      )
      ORDER BY a.sort_order, a.name
    )
    FROM rpg.phb_vehicle_template_action a
    WHERE a.template_slug = t.slug
  ), '[]'::jsonb) AS actions,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'name', tr.name,
        'description', tr.description,
        'sortOrder', tr.sort_order
      )
      ORDER BY tr.sort_order, tr.name
    )
    FROM rpg.phb_vehicle_template_trait tr
    WHERE tr.template_slug = t.slug
  ), '[]'::jsonb) AS traits
FROM rpg.phb_vehicle_template t;

-- Magias concedidas por ancestria Feathren + Identificar / Aprimorar Atributo

CREATE VIEW rpg.v_phb_species_granted_spell AS
SELECT * FROM (
  SELECT
    sp.slug AS species_slug,
    NULL::rpg.species_choice_kind AS choice_kind,
    NULL::text AS choice_slug,
    1 AS unlock_level,
    s.slug AS spell_slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_spell s ON s.id = t.spell_id
  WHERE t.spell_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
    AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 3, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
    AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level3_id
  WHERE ov.spell_level3_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 5, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
    AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level5_id
  WHERE ov.spell_level5_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
    AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 3, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
    AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level3_id
  WHERE ov.spell_level3_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 5, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
    AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level5_id
  WHERE ov.spell_level5_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'gnomeLineageId'
    AND t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_1_id
  WHERE ov.spell_1_id IS NOT NULL
  UNION ALL
  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'gnomeLineageId'
    AND t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_2_id
  WHERE ov.spell_2_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'giantkinAncestryId'
    AND t.choice_kind = 'giantkin_ancestry'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL

  UNION ALL

  -- Feathren aviária L1 (truque)
  SELECT sp.slug, t.choice_kind, ov.value_id, 1, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'feathrenAvianAncestryId'
    AND t.choice_kind = 'feathren_avian_ancestry'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level1_id
  WHERE ov.spell_level1_id IS NOT NULL
  UNION ALL
  -- Feathren felina L3
  SELECT sp.slug, t.choice_kind, ov.value_id, 3, s.slug
  FROM rpg.phb_species_trait t
  JOIN rpg.phb_species sp ON sp.id = t.species_id
  JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'feathrenFelineAncestryId'
    AND t.choice_kind = 'feathren_feline_ancestry'::rpg.species_choice_kind
  JOIN rpg.phb_spell s ON s.id = ov.spell_level3_id
  WHERE ov.spell_level3_id IS NOT NULL

  UNION ALL

  SELECT sp.slug, NULL::rpg.species_choice_kind, NULL::text, g.unlock_level, s.slug
  FROM rpg.phb_spell_grant g
  JOIN rpg.phb_species sp ON sp.id = g.origin_id
  JOIN rpg.phb_spell s ON s.id = g.spell_id
  WHERE g.origin_type = 'species'::rpg.spell_grant_origin
) AS granted;


CREATE VIEW rpg.v_phb_subclass AS
SELECT
  s.slug AS subclass_slug,
  s.name AS subclass_name,
  c.slug AS class_slug,
  c.name AS class_name,
  s.tagline,
  s.summary,
  s.image_url,
  cit.chapter AS source_chapter,
  e.slug AS edition_slug,
  ss.slug AS spell_source_slug,
  ss.label AS spell_source_label
FROM rpg.phb_subclass s
JOIN rpg.phb_class c ON c.id = s.class_id
LEFT JOIN rpg.phb_source_citation cit ON cit.id = s.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = cit.edition_id
LEFT JOIN rpg.phb_spell_source ss ON ss.subclass_id = s.id;

-- v_phb_armor: edition_slug e image_url para compêndio (ex. escudos GH)

CREATE VIEW rpg.v_phb_armor AS
SELECT
  i.slug AS item_slug,
  i.name AS item_name,
  c.slug AS category_slug,
  c.name AS category_name,
  c.don_doff,
  a.ac_base,
  a.ac_formula,
  a.strength_req,
  a.stealth_disadvantage,
  i.cost->>'text' AS cost_text,
  i.weight,
  i.properties->>'editionSlug' AS edition_slug,
  i.image_url
FROM rpg.phb_armor a
JOIN rpg.phb_item i ON i.id = a.item_id
JOIN rpg.phb_armor_category c ON c.id = a.category_id;

-- Pool global, slots modulares, speed trade e tamanho por herança GH

-- Build tradicional sugerido (8 traços por herança)

CREATE VIEW rpg.v_phb_heritage_traditional_build AS
SELECT
  h.slug AS heritage_slug,
  tr.slug AS trait_slug,
  tr.name AS trait_name,
  tr.category::text AS category,
  trt.category_hint::text AS category_hint,
  trt.sort_order,
  tr.benefit_base,
  tr.benefit_improved,
  tr.improved_name,
  tr.max_takes,
  tr.take_mode::text AS take_mode,
  h.source_meta->>'editionSlug' AS edition_slug
FROM rpg.phb_heritage_traditional trt
JOIN rpg.phb_heritage h ON h.id = trt.heritage_id
JOIN rpg.phb_heritage_trait tr ON tr.id = trt.trait_id
ORDER BY h.slug, trt.sort_order;

-- Passivos de combate/ficha ligados a traços de herança

CREATE VIEW rpg.v_phb_heritage_passive_modifier AS
SELECT
  ht.slug AS trait_slug,
  cm.kind::text AS kind,
  cm.label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level,
  cm.min_trait_takes,
  cm.second_ability_slug,
  cm.allows_shield
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_heritage_trait ht ON ht.id = cm.heritage_trait_id
WHERE cm.owner_kind = 'heritage'::rpg.combat_modifier_owner;

-- Ações de economia (Usar) ligadas a traços de herança

CREATE VIEW rpg.v_phb_heritage_economy_action AS
SELECT
  a.action_id,
  ht.slug AS trait_slug,
  a.name,
  a.economy::text AS economy,
  a.unlock_level,
  a.resource_slug,
  a.free_resource_slug,
  a.always_spends_resource,
  a.summary,
  a.description,
  a.table_action,
  a.spend_amount,
  a.spell_slug,
  a.sort_order,
  a.min_trait_takes
FROM rpg.phb_class_economy_action a
JOIN rpg.phb_heritage_trait ht ON ht.id = a.heritage_trait_id
WHERE a.heritage_trait_id IS NOT NULL;


-- Escolhas de linhagem/ancestralidade por espécie

CREATE VIEW rpg.v_phb_species_trait_choices AS
-- Elf lineage (option_key = 'lineageId')
SELECT
  sp.slug AS species_slug,
  t.name AS trait_name,
  t.choice_kind,
  ov.value_id AS choice_slug,
  ov.label AS choice_name,
  ov.level1_benefit,
  s3.slug AS spell_level3_slug,
  s5.slug AS spell_level5_slug,
  NULL::text AS damage_type,
  ov.edition_slug AS edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'lineageId'
  AND t.choice_kind = 'elf_lineage'::rpg.species_choice_kind
LEFT JOIN rpg.phb_spell s3 ON s3.id = ov.spell_level3_id
LEFT JOIN rpg.phb_spell s5 ON s5.id = ov.spell_level5_id
UNION ALL
-- Infernal legacy (option_key = 'infernalLegacyId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  ov.level1_benefit,
  s3.slug,
  s5.slug,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'infernalLegacyId'
  AND t.choice_kind = 'infernal_legacy'::rpg.species_choice_kind
LEFT JOIN rpg.phb_spell s3 ON s3.id = ov.spell_level3_id
LEFT JOIN rpg.phb_spell s5 ON s5.id = ov.spell_level5_id
UNION ALL
-- Dragon ancestry (option_key = 'dragonAncestryId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  NULL::text,
  NULL::text,
  NULL::text,
  ov.damage_type,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'dragonAncestryId'
  AND t.choice_kind = 'dragon_ancestry'::rpg.species_choice_kind
UNION ALL
-- Gnome lineage (option_key = 'gnomeLineageId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  ov.level1_benefit,
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'gnomeLineageId'
  AND t.choice_kind = 'gnome_lineage'::rpg.species_choice_kind
UNION ALL
-- Giant ancestry (option_key = 'giantAncestryId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'giantAncestryId'
  AND t.choice_kind = 'giant_ancestry'::rpg.species_choice_kind
UNION ALL
-- Geppettin construction (option_key = 'constructionId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'constructionId'
  AND t.choice_kind = 'geppettin_construction'::rpg.species_choice_kind
UNION ALL
-- Mandrake season (option_key = 'seasonId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'seasonId'
  AND t.choice_kind = 'mandrake_season'::rpg.species_choice_kind
UNION ALL
-- Manikin armor preset (option_key = 'armorPresetId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'armorPresetId'
  AND t.choice_kind = 'manikin_armor'::rpg.species_choice_kind
UNION ALL
-- Manikin service model (option_key = 'serviceModelId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'serviceModelId'
  AND t.choice_kind = 'manikin_service_model'::rpg.species_choice_kind
UNION ALL
-- Scourgeborne madness (option_key = 'madnessId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'madnessId'
  AND t.choice_kind = 'scourgeborne_madness'::rpg.species_choice_kind
UNION ALL
-- Scourgeborne monstrous lineage (option_key = 'monstrousLineageId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'monstrousLineageId'
  AND t.choice_kind = 'scourgeborne_lineage'::rpg.species_choice_kind
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  sk.slug,
  sk.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_skill sk ON t.choice_kind IN ('human_skill'::rpg.species_choice_kind, 'geppettin_skill'::rpg.species_choice_kind, 'mandrake_skill'::rpg.species_choice_kind)
  AND (
    (t.choice_kind = 'human_skill'::rpg.species_choice_kind)
    OR (t.choice_kind = 'geppettin_skill'::rpg.species_choice_kind AND sk.slug IN ('intimidation', 'performance', 'persuasion'))
    OR (t.choice_kind = 'mandrake_skill'::rpg.species_choice_kind AND sk.slug IN ('nature', 'survival'))
  )
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  sk.slug,
  sk.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_skill sk
  ON t.choice_kind = 'elf_keen_senses'::rpg.species_choice_kind
 AND sk.slug IN ('insight', 'perception', 'survival')
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  f.slug,
  f.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_feat f ON t.choice_kind = 'human_origin_feat'::rpg.species_choice_kind
  AND f.category = 'origin'::rpg.feat_category
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ab.slug,
  ab.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_ability ab
  ON t.choice_kind IN (
    'elf_casting_ability'::rpg.species_choice_kind,
    'gnome_casting_ability'::rpg.species_choice_kind,
    'infernal_casting_ability'::rpg.species_choice_kind,
    'mandrake_casting_ability'::rpg.species_choice_kind,
    'feathren_casting_ability'::rpg.species_choice_kind
  )
 AND ab.slug IN ('inteligencia', 'sabedoria', 'carisma')
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  sz.slug,
  sz.name,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN (
  VALUES
    ('medium', 'Médio'),
    ('small', 'Pequeno')
) AS sz(slug, name)
  ON t.choice_kind IN (
    'human_size'::rpg.species_choice_kind,
    'aasimar_size'::rpg.species_choice_kind,
    'tiefling_size'::rpg.species_choice_kind,
    'geppettin_size'::rpg.species_choice_kind,
    'manikin_size'::rpg.species_choice_kind,
    'beastkin_size'::rpg.species_choice_kind
  )
UNION ALL
-- Bearfolk lineage (option_key = 'bearfolkLineageId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'bearfolkLineageId'
  AND t.choice_kind = 'bearfolk_lineage'::rpg.species_choice_kind
UNION ALL
-- Beastkin adaptation (option_key = 'naturalAdaptationId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'naturalAdaptationId'
  AND t.choice_kind = 'beastkin_adaptation'::rpg.species_choice_kind
UNION ALL
-- Giantkin ancestry (option_key = 'giantkinAncestryId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'giantkinAncestryId'
  AND t.choice_kind = 'giantkin_ancestry'::rpg.species_choice_kind
UNION ALL
-- Trollkin ancestry (option_key = 'trollkinAncestryId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'trollkinAncestryId'
  AND t.choice_kind = 'trollkin_ancestry'::rpg.species_choice_kind

UNION ALL
-- Feathren ancestria aviária (option_key = 'feathrenAvianAncestryId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'feathrenAvianAncestryId'
  AND t.choice_kind = 'feathren_avian_ancestry'::rpg.species_choice_kind
UNION ALL
-- Feathren ancestria felina (option_key = 'feathrenFelineAncestryId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  s3.slug,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'feathrenFelineAncestryId'
  AND t.choice_kind = 'feathren_feline_ancestry'::rpg.species_choice_kind
LEFT JOIN rpg.phb_spell s3 ON s3.id = ov.spell_level3_id
UNION ALL
-- Variante cultural anã (option_key = 'dwarfCultureId')
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  ov.value_id,
  ov.label,
  COALESCE(ov.level1_benefit, ov.benefit),
  NULL::text,
  NULL::text,
  NULL::text,
  ov.edition_slug
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_option_value ov ON ov.scope = 'species'::rpg.option_scope AND ov.owner_id = sp.id AND ov.option_key = 'dwarfCultureId'
  AND t.choice_kind = 'dwarf_culture'::rpg.species_choice_kind
UNION ALL
-- Truques swappable do Alto Elfo (opcional)
SELECT
  'elf'::text AS species_slug,
  'Truque de Alto Elfo'::text AS trait_name,
  'high_elf_cantrip'::rpg.species_choice_kind AS choice_kind,
  o.choice_slug,
  o.choice_name,
  NULL::text AS level1_benefit,
  NULL::text AS spell_level3_slug,
  NULL::text AS spell_level5_slug,
  NULL::text AS damage_type,
  NULL::text AS edition_slug
FROM rpg.v_phb_high_elf_cantrip_options o
UNION ALL
-- Truque de Druida Andari (Dádiva da Natureza; exigido se bearfolk_lineage = andari)
SELECT
  'bearfolk'::text AS species_slug,
  'Dádiva da Natureza'::text AS trait_name,
  'andari_druid_cantrip'::rpg.species_choice_kind AS choice_kind,
  o.choice_slug,
  o.choice_name,
  NULL::text AS level1_benefit,
  NULL::text AS spell_level3_slug,
  NULL::text AS spell_level5_slug,
  NULL::text AS damage_type,
  NULL::text AS edition_slug
FROM rpg.v_phb_andari_druid_cantrip_options o;



-- Escolhas modulares de traço por herança GH

CREATE VIEW rpg.v_phb_heritage_trait_choices AS
SELECT
  h.slug AS heritage_slug,
  ('heritage_trait_' || gs.slot_index)::text AS choice_kind,
  t.slug AS trait_slug,
  regexp_replace(t.name, '\.$', '', 'g') AS trait_name,
  ('[' || CASE t.category
    WHEN 'combat' THEN 'Combate'
    WHEN 'exploration' THEN 'Exploração'
    ELSE 'Interpretação'
  END || '] ' || regexp_replace(t.name, '\.$', '', 'g')) AS label,
  t.benefit_base,
  t.benefit_improved,
  EXISTS (
    SELECT 1
    FROM rpg.phb_heritage_traditional ht
    WHERE ht.heritage_id = h.id AND ht.trait_id = t.id
  ) AS is_traditional,
  (
    gs.slot_index * 100000
    + CASE t.category
        WHEN 'combat' THEN 10000
        WHEN 'exploration' THEN 20000
        ELSE 30000
      END
    + row_number() OVER (
        PARTITION BY h.slug, gs.slot_index
        ORDER BY t.category, t.name
      )
  )::integer AS sort_order
FROM rpg.phb_heritage h
CROSS JOIN generate_series(1, 8) AS gs(slot_index)
CROSS JOIN rpg.phb_heritage_trait t

UNION ALL

SELECT
  h.slug,
  'heritage_trait_9'::text,
  t.slug,
  regexp_replace(t.name, '\.$', '', 'g'),
  ('[' || CASE t.category
    WHEN 'combat' THEN 'Combate'
    WHEN 'exploration' THEN 'Exploração'
    ELSE 'Interpretação'
  END || '] ' || regexp_replace(t.name, '\.$', '', 'g')),
  t.benefit_base,
  t.benefit_improved,
  EXISTS (
    SELECT 1
    FROM rpg.phb_heritage_traditional ht
    WHERE ht.heritage_id = h.id AND ht.trait_id = t.id
  ),
  (
    900000
    + CASE t.category
        WHEN 'combat' THEN 10000
        WHEN 'exploration' THEN 20000
        ELSE 30000
      END
    + row_number() OVER (PARTITION BY h.slug ORDER BY t.category, t.name)
  )::integer
FROM rpg.phb_heritage h
CROSS JOIN rpg.phb_heritage_trait t
WHERE h.allows_speed_trade

UNION ALL

SELECT
  h.slug,
  'heritage_speed_trade'::text,
  v.choice_slug,
  v.choice_name,
  v.choice_name,
  v.level1_benefit,
  NULL::text,
  FALSE,
  910000 + v.sort_order
FROM rpg.phb_heritage h
JOIN (VALUES
  (1, 'no', 'Não', 'Mantém o deslocamento base da herança.'),
  (2, 'yes', 'Sim', 'Reduz 1,5 m de deslocamento; escolha o 9º traço modular.')
) AS v(sort_order, choice_slug, choice_name, level1_benefit) ON TRUE
WHERE h.allows_speed_trade

UNION ALL

SELECT
  h.slug,
  'heritage_size'::text,
  v.choice_slug,
  v.choice_name,
  v.choice_name,
  v.level1_benefit,
  NULL::text,
  FALSE,
  920000 + v.sort_order
FROM rpg.phb_heritage h
JOIN (VALUES
  (1, 'small', 'Pequeno', 'Tamanho Pequeno.'),
  (2, 'medium', 'Médio', 'Tamanho Médio.')
) AS v(sort_order, choice_slug, choice_name, level1_benefit) ON TRUE
WHERE h.allows_size_choice;

-- v_phb_class_economy_action inclui ações de traços de herança GH

CREATE VIEW rpg.v_phb_class_economy_action AS
SELECT
  a.action_id,
  c.slug AS class_slug,
  sc.slug AS subclass_slug,
  sp.slug AS species_slug,
  f.slug AS feat_slug,
  i.slug AS item_slug,
  ht.slug AS heritage_trait_slug,
  a.name,
  a.economy::text AS economy,
  a.unlock_level,
  a.resource_slug,
  a.free_resource_slug,
  a.always_spends_resource,
  a.summary,
  a.description,
  a.table_action,
  a.spend_amount,
  a.spell_slug,
  a.sort_order,
  a.requires_option_key,
  a.requires_option_value,
  a.min_trait_takes
FROM rpg.phb_class_economy_action a
LEFT JOIN rpg.phb_class c ON c.id = a.class_id
LEFT JOIN rpg.phb_subclass sc ON sc.id = a.subclass_id
LEFT JOIN rpg.phb_species sp ON sp.id = a.species_id
LEFT JOIN rpg.phb_feat f ON f.id = a.feat_id
LEFT JOIN rpg.phb_item i ON i.id = a.item_id
LEFT JOIN rpg.phb_heritage_trait ht ON ht.id = a.heritage_trait_id;

-- Materialized view rpg.mv_spell_by_class

CREATE MATERIALIZED VIEW rpg.mv_spell_by_class AS
  SELECT * FROM rpg.v_spell_by_class;

-- Índices adicionais do catálogo

CREATE INDEX idx_phb_species_trait_choice ON rpg.phb_species_trait(choice_kind);

CREATE INDEX idx_phb_option_value_spells ON rpg.phb_option_value(spell_level1_id, spell_level3_id, spell_level5_id)
  WHERE spell_level1_id IS NOT NULL OR spell_level3_id IS NOT NULL OR spell_level5_id IS NOT NULL;

CREATE INDEX idx_phb_feat_category ON rpg.phb_feat(category);

CREATE INDEX idx_phb_feat_source ON rpg.phb_feat(source_citation_id);

CREATE INDEX idx_phb_feat_benefit_feat ON rpg.phb_feat_benefit(feat_id);

CREATE INDEX idx_phb_subclass_class ON rpg.phb_subclass(class_id);

CREATE INDEX idx_phb_subclass_source ON rpg.phb_subclass(source_citation_id);

CREATE INDEX idx_phb_subclass_feature_sub ON rpg.phb_subclass_feature(subclass_id);

CREATE INDEX idx_subclass_prep_spell ON rpg.phb_subclass_prepared_spell(subclass_id);

CREATE INDEX idx_phb_spell_school ON rpg.phb_spell(school_id);

CREATE INDEX idx_phb_spell_source ON rpg.phb_spell(source_citation_id);

CREATE INDEX idx_phb_spell_level_school ON rpg.phb_spell (level, school_id);

CREATE INDEX idx_spell_class ON rpg.phb_spell_class(class_id);

CREATE INDEX idx_class_skill_pool_skill ON rpg.phb_class_skill_pool (skill_id);

CREATE INDEX idx_phb_item_type ON rpg.phb_item (item_type);

CREATE INDEX idx_phb_skill_ability ON rpg.phb_skill(ability_id);

CREATE INDEX idx_phb_class_hit_die ON rpg.phb_class(hit_die);

CREATE INDEX idx_phb_class_source ON rpg.phb_class(source_citation_id);

CREATE INDEX idx_phb_armor_category ON rpg.phb_armor(category_id);

CREATE INDEX idx_phb_tool_category ON rpg.phb_tool(category_id);

CREATE UNIQUE INDEX uq_resource_species ON rpg.phb_resource_definition (species_id, slug)
  WHERE scope = 'species';

CREATE UNIQUE INDEX uq_resource_class ON rpg.phb_resource_definition (class_id, slug)
  WHERE scope = 'class';

CREATE UNIQUE INDEX uq_resource_subclass ON rpg.phb_resource_definition (subclass_id, slug)
  WHERE scope = 'subclass';

CREATE UNIQUE INDEX uq_resource_heritage
  ON rpg.phb_resource_definition (heritage_trait_id, slug)
  WHERE scope = 'heritage';

CREATE INDEX idx_phb_spell_name_trgm ON rpg.phb_spell USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_feat_name_trgm ON rpg.phb_feat USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_class_name_trgm ON rpg.phb_class USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_item_name_trgm ON rpg.phb_item USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_species_name_trgm ON rpg.phb_species USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_subclass_name_trgm ON rpg.phb_subclass USING gin (name gin_trgm_ops);

CREATE INDEX idx_phb_background_name_trgm ON rpg.phb_background USING gin (name gin_trgm_ops);

CREATE UNIQUE INDEX idx_mv_spell_by_class ON rpg.mv_spell_by_class (class_slug, spell_slug);

-- Criticals: ownership FK (auth.users quando existir); subclass ∈ class; HP current ≤ max

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE rpg.player_character (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 100),
  level INTEGER NOT NULL DEFAULT 1 CHECK (level BETWEEN 1 AND 20),
  class_slug TEXT NOT NULL REFERENCES rpg.phb_class(slug),
  species_slug TEXT REFERENCES rpg.phb_species(slug),
  background_slug TEXT NOT NULL REFERENCES rpg.phb_background(slug),
  subclass_slug TEXT REFERENCES rpg.phb_subclass(slug),
  alignment_slug TEXT REFERENCES rpg.phb_alignment(slug),
  ability_generation_method_slug TEXT CHECK (ability_generation_method_slug IS NULL OR ability_generation_method_slug::rpg.ability_generation_method IS NOT NULL),
  ability_scores JSONB NOT NULL DEFAULT '{"forca":10,"destreza":10,"constituicao":10,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb,
  hit_points_max INTEGER CHECK (hit_points_max IS NULL OR hit_points_max >= 0),
  hit_points_current INTEGER CHECK (hit_points_current IS NULL OR hit_points_current >= 0),
  background_boost_mode TEXT NOT NULL DEFAULT 'plus2plus1' CHECK (background_boost_mode IN ('plus2plus1', 'plus1x3')),
  background_boost_plus2_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  background_boost_plus1_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  background_boost_plus1_slugs TEXT[],
  background_tool_item_slug TEXT REFERENCES rpg.phb_item(slug),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  coin_copper INTEGER NOT NULL DEFAULT 0 CHECK (coin_copper >= 0),
  coin_silver INTEGER NOT NULL DEFAULT 0 CHECK (coin_silver >= 0),
  coin_electrum INTEGER NOT NULL DEFAULT 0 CHECK (coin_electrum >= 0),
  coin_gold INTEGER NOT NULL DEFAULT 0 CHECK (coin_gold >= 0),
  coin_platinum INTEGER NOT NULL DEFAULT 0 CHECK (coin_platinum >= 0),
  heritage_slug TEXT NULL REFERENCES rpg.phb_heritage(slug),
  session_notes TEXT NOT NULL DEFAULT '',
  CONSTRAINT player_character_hp_current_lte_max CHECK (
    hit_points_current IS NULL
    OR hit_points_max IS NULL
    OR hit_points_current <= hit_points_max
  ),
  CONSTRAINT player_character_origin_xor CHECK (
    (species_slug IS NOT NULL AND heritage_slug IS NULL)
    OR (species_slug IS NULL AND heritage_slug IS NOT NULL)
  )
);

CREATE INDEX idx_player_character_user_id ON rpg.player_character(user_id);

CREATE TRIGGER tr_player_character_updated_at
  BEFORE UPDATE ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

-- Invariante: subclass_slug pertence à class_slug (CHECK com subquery não é permitido)
CREATE OR REPLACE FUNCTION rpg.enforce_pc_subclass_belongs_to_class()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.subclass_slug IS NULL THEN
    RETURN NEW;
  END IF;
  IF NOT EXISTS (
    SELECT 1
    FROM rpg.phb_subclass sc
    JOIN rpg.phb_class c ON c.id = sc.class_id
    WHERE sc.slug = NEW.subclass_slug
      AND c.slug = NEW.class_slug
  ) THEN
    RAISE EXCEPTION 'subclass "%" does not belong to class "%"',
      NEW.subclass_slug, NEW.class_slug;
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER tr_player_character_subclass_class
  BEFORE INSERT OR UPDATE OF class_slug, subclass_slug
  ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.enforce_pc_subclass_belongs_to_class();

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player_character.user_id FK — auth schema not present';
    RETURN;
  END IF;
  ALTER TABLE rpg.player_character
    ADD CONSTRAINT player_character_user_id_fkey
    FOREIGN KEY (user_id) REFERENCES auth.users(id);
END $$;

-- Perícias escolhidas da pool da classe (PHB skill choice)

CREATE TABLE rpg.player_character_skill (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  skill_slug TEXT NOT NULL REFERENCES rpg.phb_skill(slug),
  PRIMARY KEY (character_id, skill_slug)
);

CREATE INDEX idx_player_character_skill_character
  ON rpg.player_character_skill(character_id);

-- Extensões da ficha: espécie, subclasse, feats, magias, equipamento, idiomas
CREATE TABLE rpg.player_character_species_choice (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  choice_kind TEXT NOT NULL,
  choice_slug TEXT NOT NULL,
  PRIMARY KEY (character_id, choice_kind)
);

CREATE TABLE rpg.player_character_option (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  scope rpg.option_scope NOT NULL,
  owner_slug TEXT NOT NULL,
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  instance_index INTEGER NOT NULL DEFAULT 0 CHECK (instance_index >= 0),
  UNIQUE (character_id, scope, owner_slug, instance_index, option_key)
);

CREATE TABLE rpg.player_character_feat (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  feat_slug TEXT NOT NULL REFERENCES rpg.phb_feat(slug),
  instance_index INTEGER NOT NULL DEFAULT 0 CHECK (instance_index >= 0),
  PRIMARY KEY (character_id, feat_slug, instance_index)
);

CREATE TABLE rpg.player_character_spell (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell(slug),
  list_type TEXT NOT NULL CHECK (list_type IN ('known', 'prepared', 'always_prepared')),
  PRIMARY KEY (character_id, spell_slug, list_type)
);

CREATE TABLE rpg.player_character_equipment (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  source TEXT NOT NULL CHECK (source IN ('class', 'background')),
  package_slug TEXT NOT NULL,
  package_id BIGINT REFERENCES rpg.phb_starting_package(id),
  item_slug TEXT REFERENCES rpg.phb_item(slug),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (character_id, source, sort_order)
);

CREATE TABLE rpg.player_character_language (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  language_slug TEXT NOT NULL REFERENCES rpg.phb_language(slug),
  PRIMARY KEY (character_id, language_slug)
);

CREATE INDEX idx_player_character_species_choice_character
  ON rpg.player_character_species_choice(character_id);
CREATE INDEX idx_player_character_option_character
  ON rpg.player_character_option(character_id);
CREATE INDEX idx_player_character_option_scope_owner
  ON rpg.player_character_option(character_id, scope, owner_slug);
CREATE INDEX idx_player_character_feat_character
  ON rpg.player_character_feat(character_id);
CREATE INDEX idx_player_character_spell_character
  ON rpg.player_character_spell(character_id);
CREATE INDEX idx_player_character_equipment_character
  ON rpg.player_character_equipment(character_id);
CREATE INDEX idx_player_character_language_character
  ON rpg.player_character_language(character_id);

-- RLS para tabelas de jogador (Supabase — requer schema auth)

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.player_character ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_skill ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_species_choice ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_option ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_feat ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_spell ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_equipment ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_language ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_own ON rpg.player_character;
  CREATE POLICY player_character_own ON rpg.player_character
    FOR ALL USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

  DROP POLICY IF EXISTS player_character_skill_own ON rpg.player_character_skill;
  CREATE POLICY player_character_skill_own ON rpg.player_character_skill
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_species_choice_own ON rpg.player_character_species_choice;
  CREATE POLICY player_character_species_choice_own ON rpg.player_character_species_choice
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_option_own ON rpg.player_character_option;
  CREATE POLICY player_character_option_own ON rpg.player_character_option
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_feat_own ON rpg.player_character_feat;
  CREATE POLICY player_character_feat_own ON rpg.player_character_feat
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_spell_own ON rpg.player_character_spell;
  CREATE POLICY player_character_spell_own ON rpg.player_character_spell
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_equipment_own ON rpg.player_character_equipment;
  CREATE POLICY player_character_equipment_own ON rpg.player_character_equipment
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_language_own ON rpg.player_character_language;
  CREATE POLICY player_character_language_own ON rpg.player_character_language
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );
END $$;

-- Inventário do personagem (mochila + equipado)

CREATE TABLE rpg.player_character_item (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  item_slug TEXT NOT NULL REFERENCES rpg.phb_item(slug),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  location TEXT NOT NULL DEFAULT 'backpack' CHECK (location IN ('equipped', 'backpack')),
  equipment_slot TEXT,
  attuned BOOLEAN NOT NULL DEFAULT FALSE,
  attached_charm_slug TEXT NULL,
  is_pact_weapon BOOLEAN NOT NULL DEFAULT FALSE,
  attached_coverage_slug TEXT NULL,
  attached_coverage_bonus SMALLINT NULL,
  attached_coverage_attuned BOOLEAN NOT NULL DEFAULT FALSE,
  attached_coverage_spell_slug TEXT NULL REFERENCES rpg.phb_spell(slug),
  bound_spell_slug TEXT NULL REFERENCES rpg.phb_spell(slug),
  instance_properties JSONB NULL,
  contained_in_item_slug TEXT NULL,
  PRIMARY KEY (character_id, item_slug),
  CONSTRAINT player_character_item_slot_when_equipped CHECK (
    (location = 'backpack' AND equipment_slot IS NULL)
    OR (location = 'equipped' AND equipment_slot IS NOT NULL)
  ),
  CONSTRAINT player_character_item_equipment_slot_check CHECK (
    equipment_slot IS NULL
    OR equipment_slot IN (
      'armor',
      'main_hand',
      'off_hand',
      'shield',
      'worn',
      'carried'
    )
  ),
  CONSTRAINT player_character_item_attached_charm_slug_check CHECK (
    attached_charm_slug IS NULL
    OR attached_charm_slug LIKE 'weapon-charm-%'
  ),
  CONSTRAINT player_character_item_attached_coverage_bonus_check CHECK (
    attached_coverage_bonus IS NULL
    OR attached_coverage_bonus IN (1, 2, 3)
  ),
  CONSTRAINT player_character_item_attached_coverage_pair_check CHECK (
    (attached_coverage_slug IS NULL AND attached_coverage_bonus IS NULL AND attached_coverage_attuned = FALSE)
    OR (attached_coverage_slug IS NOT NULL)
  ),
  CONSTRAINT player_character_item_attached_coverage_spell_pair_check CHECK (
    attached_coverage_spell_slug IS NULL
    OR attached_coverage_slug IS NOT NULL
  )
);

CREATE INDEX idx_player_character_item_character
  ON rpg.player_character_item(character_id);

CREATE INDEX idx_player_character_item_equipped
  ON rpg.player_character_item(character_id, equipment_slot)
  WHERE location = 'equipped';

CREATE INDEX idx_player_character_item_attuned
  ON rpg.player_character_item(character_id)
  WHERE attuned = TRUE;

-- RLS (Supabase)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player_character_item RLS — auth schema not present';
    RETURN;
  END IF;

  ALTER TABLE rpg.player_character_item ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_item_own ON rpg.player_character_item;
  CREATE POLICY player_character_item_own ON rpg.player_character_item
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );
END $$;

-- Estado de mesa (slots gastos, concentração, condições, HP temporário)
CREATE VIEW rpg.v_phb_condition AS
SELECT slug, name FROM (VALUES
  ('blinded'::rpg.condition_slug, 'Cegueira'),
  ('charmed'::rpg.condition_slug, 'Enfeitiçado'),
  ('deafened'::rpg.condition_slug, 'Surdez'),
  ('exhaustion'::rpg.condition_slug, 'Exaustão'),
  ('frightened'::rpg.condition_slug, 'Amedrontado'),
  ('grappled'::rpg.condition_slug, 'Agarrado'),
  ('incapacitated'::rpg.condition_slug, 'Incapacitado'),
  ('invisible'::rpg.condition_slug, 'Invisível'),
  ('paralyzed'::rpg.condition_slug, 'Paralisado'),
  ('petrified'::rpg.condition_slug, 'Petrificado'),
  ('poisoned'::rpg.condition_slug, 'Envenenado'),
  ('prone'::rpg.condition_slug, 'Caído'),
  ('restrained'::rpg.condition_slug, 'Restringido'),
  ('stunned'::rpg.condition_slug, 'Atordoado'),
  ('unconscious'::rpg.condition_slug, 'Inconsciente')
) AS t(slug, name);


-- Campanhas: mesa, membros (mestre/jogador/auxiliar) e personagens vinculados.
-- Personagem continua do dono; pode estar em várias campanhas.

CREATE TABLE rpg.campaign (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT,
  invite_code TEXT NOT NULL UNIQUE CHECK (char_length(invite_code) BETWEEN 6 AND 16),
  created_by UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  allow_player_skip_payment BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_campaign_created_by ON rpg.campaign(created_by);
CREATE INDEX idx_campaign_invite_code ON rpg.campaign(invite_code);

CREATE TRIGGER tr_campaign_updated_at
  BEFORE UPDATE ON rpg.campaign
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

-- Papéis na mesa: dm (mestre), player (jogador), assistant (auxiliar).
CREATE TABLE rpg.campaign_member (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID NOT NULL REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  user_id UUID NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('dm', 'player', 'assistant')),
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (campaign_id, user_id)
);

CREATE INDEX idx_campaign_member_user_id ON rpg.campaign_member(user_id);
CREATE INDEX idx_campaign_member_campaign_id ON rpg.campaign_member(campaign_id);

-- Personagem do jogador vinculado à campanha (N:N — várias campanhas).
CREATE TABLE rpg.campaign_character (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID NOT NULL REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  linked_by UUID NOT NULL,
  linked_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (campaign_id, character_id)
);

CREATE INDEX idx_campaign_character_character_id ON rpg.campaign_character(character_id);
CREATE INDEX idx_campaign_character_campaign_id ON rpg.campaign_character(campaign_id);

-- Criticals: ownership FKs quando auth.users existir
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign ownership FKs — auth schema not present';
    RETURN;
  END IF;
  ALTER TABLE rpg.campaign
    ADD CONSTRAINT campaign_created_by_fkey
    FOREIGN KEY (created_by) REFERENCES auth.users(id);
  ALTER TABLE rpg.campaign_member
    ADD CONSTRAINT campaign_member_user_id_fkey
    FOREIGN KEY (user_id) REFERENCES auth.users(id);
  ALTER TABLE rpg.campaign_character
    ADD CONSTRAINT campaign_character_linked_by_fkey
    FOREIGN KEY (linked_by) REFERENCES auth.users(id);
END $$;

-- RLS para campanhas (Supabase — requer schema auth)

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.campaign ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.campaign_member ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.campaign_character ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS campaign_member_select ON rpg.campaign;
  CREATE POLICY campaign_member_select ON rpg.campaign
    FOR SELECT USING (
      id IN (SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS campaign_creator_insert ON rpg.campaign;
  CREATE POLICY campaign_creator_insert ON rpg.campaign
    FOR INSERT WITH CHECK (created_by = auth.uid());

  DROP POLICY IF EXISTS campaign_dm_update ON rpg.campaign;
  CREATE POLICY campaign_dm_update ON rpg.campaign
    FOR UPDATE USING (
      id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role = 'dm'
      )
    );

  DROP POLICY IF EXISTS campaign_dm_delete ON rpg.campaign;
  CREATE POLICY campaign_dm_delete ON rpg.campaign
    FOR DELETE USING (
      id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role = 'dm'
      )
    );

  DROP POLICY IF EXISTS campaign_member_own ON rpg.campaign_member;
  CREATE POLICY campaign_member_own ON rpg.campaign_member
    FOR SELECT USING (
      user_id = auth.uid()
      OR campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_member_dm_write ON rpg.campaign_member;
  CREATE POLICY campaign_member_dm_write ON rpg.campaign_member
    FOR ALL USING (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role = 'dm'
      )
      OR user_id = auth.uid()
    )
    WITH CHECK (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role = 'dm'
      )
      OR user_id = auth.uid()
    );

  DROP POLICY IF EXISTS campaign_character_member_select ON rpg.campaign_character;
  CREATE POLICY campaign_character_member_select ON rpg.campaign_character
    FOR SELECT USING (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_character_link ON rpg.campaign_character;
  CREATE POLICY campaign_character_link ON rpg.campaign_character
    FOR INSERT WITH CHECK (
      linked_by = auth.uid()
      AND character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
      AND campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_character_unlink ON rpg.campaign_character;
  CREATE POLICY campaign_character_unlink ON rpg.campaign_character
    FOR DELETE USING (
      linked_by = auth.uid()
      OR character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
      OR campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role IN ('dm', 'assistant')
      )
    );

  -- Leitura de personagem por membros da campanha (além do dono).
  DROP POLICY IF EXISTS player_character_campaign_read ON rpg.player_character;
  CREATE POLICY player_character_campaign_read ON rpg.player_character
    FOR SELECT USING (
      user_id = auth.uid()
      OR id IN (
        SELECT cc.character_id
        FROM rpg.campaign_character cc
        JOIN rpg.campaign_member cm ON cm.campaign_id = cc.campaign_id
        WHERE cm.user_id = auth.uid()
      )
    );

  -- Escrita por mestre/auxiliar na campanha (dono já coberto por player_character_own).
  DROP POLICY IF EXISTS player_character_campaign_write ON rpg.player_character;
  CREATE POLICY player_character_campaign_write ON rpg.player_character
    FOR UPDATE USING (
      user_id = auth.uid()
      OR id IN (
        SELECT cc.character_id
        FROM rpg.campaign_character cc
        JOIN rpg.campaign_member cm ON cm.campaign_id = cc.campaign_id
        WHERE cm.user_id = auth.uid() AND cm.role IN ('dm', 'assistant')
      )
    );
END $$;

-- Encontro de campanha + combatentes (PCs + criaturas manuais)

CREATE TABLE rpg.campaign_encounter (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id UUID NOT NULL REFERENCES rpg.campaign(id) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'closed')),
  round INT NOT NULL DEFAULT 1 CHECK (round >= 1),
  current_turn_index INT NOT NULL DEFAULT 0 CHECK (current_turn_index >= 0),
  players_can_view BOOLEAN NOT NULL DEFAULT FALSE,
  creature_hp_visibility TEXT NOT NULL DEFAULT 'percent' CHECK (creature_hp_visibility IN ('hidden', 'percent', 'exact')),
  created_by UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_campaign_encounter_campaign_id
  ON rpg.campaign_encounter(campaign_id);

CREATE UNIQUE INDEX uq_campaign_one_active_encounter
  ON rpg.campaign_encounter(campaign_id)
  WHERE status = 'active';

CREATE TRIGGER tr_campaign_encounter_updated_at
  BEFORE UPDATE ON rpg.campaign_encounter
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();


-- Runtime: fichas de mesa além do personagem jogador (criatura, montaria, veículo, companion)

CREATE TABLE rpg.game_actor (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_user_id UUID NOT NULL,
  campaign_id UUID REFERENCES rpg.campaign(id) ON DELETE SET NULL,
  parent_character_id UUID REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  actor_kind rpg.actor_kind NOT NULL,
  template_slug TEXT,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  hit_points_max INT CHECK (hit_points_max IS NULL OR hit_points_max >= 0),
  hit_points_current INT CHECK (hit_points_current IS NULL OR hit_points_current >= 0),
  armor_class INT,
  initiative_modifier INT,
  proficiency_bonus INT CHECK (proficiency_bonus IS NULL OR proficiency_bonus BETWEEN 0 AND 9),
  ability_scores JSONB NOT NULL DEFAULT '{"forca":10,"destreza":10,"constituicao":10,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb,
  size_slug TEXT,
  notes TEXT,
  spellcasting_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  spell_save_dc INT CHECK (spell_save_dc IS NULL OR spell_save_dc BETWEEN 1 AND 40),
  spell_attack_bonus INT CHECK (spell_attack_bonus IS NULL OR spell_attack_bonus BETWEEN -10 AND 30),
  damage_threshold INT CHECK (damage_threshold IS NULL OR damage_threshold >= 0),
  crew_capacity INT CHECK (crew_capacity IS NULL OR crew_capacity >= 0),
  cargo_capacity_lb INT CHECK (cargo_capacity_lb IS NULL OR cargo_capacity_lb >= 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  passenger_capacity INT CHECK (passenger_capacity IS NULL OR passenger_capacity >= 0),
  CONSTRAINT game_actor_hp_current_lte_max CHECK (
    hit_points_current IS NULL
    OR hit_points_max IS NULL
    OR hit_points_current <= hit_points_max
  ),
  CONSTRAINT game_actor_companion_requires_parent CHECK (
    actor_kind <> 'companion'::rpg.actor_kind
    OR parent_character_id IS NOT NULL
  )
);

CREATE INDEX idx_game_actor_owner_user_id ON rpg.game_actor(owner_user_id);
CREATE INDEX idx_game_actor_campaign_id ON rpg.game_actor(campaign_id)
  WHERE campaign_id IS NOT NULL;
CREATE INDEX idx_game_actor_parent_character_id ON rpg.game_actor(parent_character_id)
  WHERE parent_character_id IS NOT NULL;

CREATE TRIGGER tr_game_actor_updated_at
  BEFORE UPDATE ON rpg.game_actor
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TABLE rpg.game_actor_speed (
  actor_id UUID NOT NULL REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  movement_kind TEXT NOT NULL CHECK (char_length(movement_kind) BETWEEN 1 AND 32),
  speed_ft INT NOT NULL CHECK (speed_ft >= 0),
  PRIMARY KEY (actor_id, movement_kind)
);

CREATE TABLE rpg.game_actor_action (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_id UUID NOT NULL REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  action_bucket rpg.actor_action_bucket NOT NULL DEFAULT 'action',
  attack_bonus INT,
  damage_expression TEXT,
  reach_ft INT CHECK (reach_ft IS NULL OR reach_ft >= 0),
  sort_order INT NOT NULL DEFAULT 0,
  description TEXT
);

CREATE INDEX idx_game_actor_action_actor_id ON rpg.game_actor_action(actor_id);

CREATE TABLE rpg.game_actor_spell (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_id UUID NOT NULL REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell(slug),
  usage_kind rpg.innate_spell_usage NOT NULL,
  uses_per_day INT CHECK (uses_per_day IS NULL OR uses_per_day >= 1),
  slot_level INT CHECK (slot_level IS NULL OR slot_level BETWEEN 0 AND 9),
  recharge_dice TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  UNIQUE (actor_id, spell_slug, usage_kind, slot_level)
);

CREATE TABLE rpg.game_actor_state (
  actor_id UUID PRIMARY KEY REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  conditions TEXT[] NOT NULL DEFAULT '{}',
  temp_hp INT NOT NULL DEFAULT 0 CHECK (temp_hp >= 0),
  concentrating_on TEXT,
  innate_spell_uses JSONB NOT NULL DEFAULT '{}'::jsonb,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER tr_game_actor_state_updated_at
  BEFORE UPDATE ON rpg.game_actor_state
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TABLE rpg.player_character_state (
  character_id UUID PRIMARY KEY REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  spell_slots_used JSONB NOT NULL DEFAULT '{}',
  concentrating_on TEXT,
  conditions TEXT[] NOT NULL DEFAULT '{}',
  temp_hp INT NOT NULL DEFAULT 0 CHECK (temp_hp >= 0),
  hit_dice_current INT NOT NULL DEFAULT 0 CHECK (hit_dice_current >= 0),
  resources_used JSONB NOT NULL DEFAULT '{}'::jsonb,
  death_save_successes INT NOT NULL DEFAULT 0 CHECK (death_save_successes BETWEEN 0 AND 3),
  death_save_failures INT NOT NULL DEFAULT 0 CHECK (death_save_failures BETWEEN 0 AND 3),
  inspiration BOOLEAN NOT NULL DEFAULT FALSE,
  granted_spell_uses JSONB NOT NULL DEFAULT '{}'::jsonb,
  high_elf_cantrip_swap_available BOOLEAN NOT NULL DEFAULT false,
  firearm_chambers JSONB NOT NULL DEFAULT '{}'::jsonb,
  rage_active BOOLEAN NOT NULL DEFAULT FALSE,
  reckless_active BOOLEAN NOT NULL DEFAULT FALSE,
  persona_masks JSONB NOT NULL DEFAULT '[]'::jsonb,
  bestial_aspect_level INTEGER NOT NULL DEFAULT 0 CHECK (bestial_aspect_level >= 0 AND bestial_aspect_level <= 5),
  missile_shield_armed BOOLEAN NOT NULL DEFAULT false,
  giga_missile_armed BOOLEAN NOT NULL DEFAULT false,
  starry_form_active BOOLEAN NOT NULL DEFAULT FALSE,
  stellar_constellation TEXT NULL,
  boarded_actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE SET NULL
);

CREATE INDEX idx_player_character_state_concentration
  ON rpg.player_character_state(concentrating_on)
  WHERE concentrating_on IS NOT NULL;

CREATE INDEX idx_player_character_state_boarded_actor
  ON rpg.player_character_state(boarded_actor_id)
  WHERE boarded_actor_id IS NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player_character_state RLS — auth schema not present';
    RETURN;
  END IF;

  ALTER TABLE rpg.player_character_state ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_state_own ON rpg.player_character_state;
  CREATE POLICY player_character_state_own ON rpg.player_character_state
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );
END $$;

CREATE TABLE rpg.campaign_encounter_combatant (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  encounter_id UUID NOT NULL REFERENCES rpg.campaign_encounter(id) ON DELETE CASCADE,
  kind TEXT NOT NULL DEFAULT 'pc',
  character_id UUID REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  initiative_total INT,
  initiative_modifier INT,
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT campaign_encounter_combatant_kind_check CHECK (kind IN ('pc', 'actor')),
  CONSTRAINT campaign_encounter_combatant_shape_check CHECK (
    (kind = 'pc' AND character_id IS NOT NULL AND actor_id IS NULL)
    OR (kind = 'actor' AND actor_id IS NOT NULL AND character_id IS NULL)
  )
);

CREATE INDEX idx_campaign_encounter_combatant_encounter_id
  ON rpg.campaign_encounter_combatant(encounter_id);

CREATE UNIQUE INDEX uq_encounter_pc_character
  ON rpg.campaign_encounter_combatant(encounter_id, character_id)
  WHERE character_id IS NOT NULL;

CREATE UNIQUE INDEX uq_encounter_actor
  ON rpg.campaign_encounter_combatant(encounter_id, actor_id)
  WHERE actor_id IS NOT NULL;

CREATE INDEX idx_campaign_encounter_combatant_actor_id
  ON rpg.campaign_encounter_combatant(actor_id)
  WHERE actor_id IS NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign_encounter.created_by FK — auth schema not present';
    RETURN;
  END IF;
  ALTER TABLE rpg.campaign_encounter
    ADD CONSTRAINT campaign_encounter_created_by_fkey
    FOREIGN KEY (created_by) REFERENCES auth.users(id);
END $$;

-- RLS para encontro de campanha (Supabase — requer schema auth)

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign encounter RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.campaign_encounter ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.campaign_encounter_combatant ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS campaign_encounter_member_select ON rpg.campaign_encounter;
  CREATE POLICY campaign_encounter_member_select ON rpg.campaign_encounter
    FOR SELECT USING (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_encounter_staff_write ON rpg.campaign_encounter;
  CREATE POLICY campaign_encounter_staff_write ON rpg.campaign_encounter
    FOR ALL USING (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role IN ('dm', 'assistant')
      )
    )
    WITH CHECK (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role IN ('dm', 'assistant')
      )
    );

  DROP POLICY IF EXISTS campaign_encounter_combatant_member_select
    ON rpg.campaign_encounter_combatant;
  CREATE POLICY campaign_encounter_combatant_member_select
    ON rpg.campaign_encounter_combatant
    FOR SELECT USING (
      encounter_id IN (
        SELECT e.id
        FROM rpg.campaign_encounter e
        JOIN rpg.campaign_member m ON m.campaign_id = e.campaign_id
        WHERE m.user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_encounter_combatant_staff_write
    ON rpg.campaign_encounter_combatant;
  CREATE POLICY campaign_encounter_combatant_staff_write
    ON rpg.campaign_encounter_combatant
    FOR ALL USING (
      encounter_id IN (
        SELECT e.id
        FROM rpg.campaign_encounter e
        JOIN rpg.campaign_member m ON m.campaign_id = e.campaign_id
        WHERE m.user_id = auth.uid() AND m.role IN ('dm', 'assistant')
      )
    )
    WITH CHECK (
      encounter_id IN (
        SELECT e.id
        FROM rpg.campaign_encounter e
        JOIN rpg.campaign_member m ON m.campaign_id = e.campaign_id
        WHERE m.user_id = auth.uid() AND m.role IN ('dm', 'assistant')
      )
    );
END $$;

-- Slots não exclusivos para itens mágicos vestíveis / carregados.




-- Câmara de armas de fogo por personagem (estado de sessão).

-- Estado de combate do Bárbaro (Fúria / Ataque Imprudente).



-- Encanto de arma preso a um item do inventário (slug do phb_item do encanto).




-- Soft check: null ou slug de encanto; sem FK (catálogo pode atrasar).

-- Trackers de sessão Pack 2: Colégio das Máscaras / Beastborne.



-- Trackers de sessão: Mago dos Mísseis (Escudo / Giga armados para o próximo cast).



-- Arma de Pacto (Bruxo · Pacto da Lâmina): no máximo uma por personagem.


CREATE UNIQUE INDEX uq_player_character_item_one_pact_weapon
  ON rpg.player_character_item (character_id)
  WHERE is_pact_weapon = TRUE;

-- Overlay DMG §3.1: cobertura presa à peça base (estilo Valdas charm).













-- Arma Magificada: magia vinculada na cobertura anexada.





-- Magia vinculada em item único (ex.: Cajado Magificado).

-- Wealth: 5 moedas D&D no personagem (PC / PP prata / PE / PO / PL platina)

-- Campanha: players podem optar por não pagar ao pegar item

-- Bucket público de avatares (perfil do usuário).
-- Rode no SQL Editor do Supabase se o pipeline de migrations não cobre storage.

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'avatars',
  'avatars',
  true,
  2097152,
  ARRAY['image/jpeg', 'image/png', 'image/webp']
)
ON CONFLICT (id) DO UPDATE
SET
  public = EXCLUDED.public,
  file_size_limit = EXCLUDED.file_size_limit,
  allowed_mime_types = EXCLUDED.allowed_mime_types;

DROP POLICY IF EXISTS "avatars_public_read" ON storage.objects;
CREATE POLICY "avatars_public_read"
  ON storage.objects
  FOR SELECT
  USING (bucket_id = 'avatars');

DROP POLICY IF EXISTS "avatars_owner_insert" ON storage.objects;
CREATE POLICY "avatars_owner_insert"
  ON storage.objects
  FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

DROP POLICY IF EXISTS "avatars_owner_update" ON storage.objects;
CREATE POLICY "avatars_owner_update"
  ON storage.objects
  FOR UPDATE
  TO authenticated
  USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  )
  WITH CHECK (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

DROP POLICY IF EXISTS "avatars_owner_delete" ON storage.objects;
CREATE POLICY "avatars_owner_delete"
  ON storage.objects
  FOR DELETE
  TO authenticated
  USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = auth.uid()::text
  );

-- Props de instância (artefato rolado na 1ª sintonia, senciência copiada, etc.)


COMMENT ON COLUMN rpg.player_character_item.instance_properties IS
  'Estado por instância: artifactRandom (1ª sintonia), sentience copiada do catálogo, etc.';

-- Compartimentos de inventário: item contido em outro (bolsa/saca/cesta).
-- Nullable = mochila raiz (compatível com inventário existente).


COMMENT ON COLUMN rpg.player_character_item.contained_in_item_slug IS
  'Slug do recipiente no mesmo personagem; NULL = raiz (Equipado/Mochila).';

CREATE INDEX idx_player_character_item_contained_in
  ON rpg.player_character_item (character_id, contained_in_item_slug)
  WHERE contained_in_item_slug IS NOT NULL;

-- Forma Estrelada (Círculo das Estrelas): constelação ativa na sessão



-- RPC de leitura: ficha do jogador em 1 round-trip (JSONB).
-- Substitui N finds TypeORM em player_character_* + skills do antecedente.

-- RPC de leitura: inventário + catálogo de combate em 1 round-trip.

CREATE OR REPLACE FUNCTION rpg.get_character_combat_bundle(
  p_character_id uuid,
  p_class_slug text,
  p_subclass_slug text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE sql
STABLE
AS $$
  WITH inv AS (
    SELECT
      pci.character_id,
      pci.item_slug,
      pci.quantity,
      pci.location,
      pci.equipment_slot,
      pci.attuned,
      pci.is_pact_weapon,
      pci.attached_charm_slug,
      pci.attached_coverage_slug,
      pci.attached_coverage_bonus,
      pci.attached_coverage_attuned,
      pci.attached_coverage_spell_slug,
      pci.bound_spell_slug,
      pci.instance_properties,
      pci.contained_in_item_slug
    FROM rpg.player_character_item pci
    WHERE pci.character_id = p_character_id
  ),
  active_slugs AS (
    SELECT DISTINCT item_slug FROM (
      SELECT i.item_slug
      FROM inv i
      JOIN rpg.phb_item cat ON cat.slug = i.item_slug
      WHERE i.location = 'equipped'
        AND (
          COALESCE((cat.properties->>'requiresAttunement')::boolean, false) = false
          OR i.attuned = true
        )
      UNION ALL
      SELECT i.attached_charm_slug AS item_slug
      FROM inv i
      WHERE i.location = 'equipped'
        AND i.attached_charm_slug IS NOT NULL
      UNION ALL
      SELECT i.attached_coverage_slug AS item_slug
      FROM inv i
      JOIN rpg.phb_item cov ON cov.slug = i.attached_coverage_slug
      WHERE i.location = 'equipped'
        AND i.attached_coverage_slug IS NOT NULL
        AND (
          COALESCE((cov.properties->>'requiresAttunement')::boolean, false) = false
          OR i.attached_coverage_attuned = true
        )
      UNION ALL
      SELECT i.item_slug
      FROM inv i
      JOIN rpg.phb_item cat ON cat.slug = i.item_slug
      WHERE i.quantity > 0
        AND COALESCE((cat.properties->>'consumable')::boolean, false) = true
    ) s
    WHERE item_slug IS NOT NULL
  ),
  related_slugs AS (
    SELECT DISTINCT slug FROM (
      SELECT item_slug AS slug FROM inv
      UNION ALL
      SELECT attached_charm_slug FROM inv WHERE attached_charm_slug IS NOT NULL
      UNION ALL
      SELECT attached_coverage_slug FROM inv WHERE attached_coverage_slug IS NOT NULL
      UNION ALL
      SELECT item_slug FROM active_slugs
    ) u
    WHERE slug IS NOT NULL
  )
  SELECT jsonb_build_object(
    'inventory', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'characterId', i.character_id,
          'itemSlug', i.item_slug,
          'quantity', i.quantity,
          'location', i.location,
          'equipmentSlot', i.equipment_slot,
          'attuned', i.attuned,
          'isPactWeapon', i.is_pact_weapon,
          'attachedCharmSlug', i.attached_charm_slug,
          'attachedCoverageSlug', i.attached_coverage_slug,
          'attachedCoverageBonus', i.attached_coverage_bonus,
          'attachedCoverageAttuned', i.attached_coverage_attuned,
          'attachedCoverageSpellSlug', i.attached_coverage_spell_slug,
          'boundSpellSlug', i.bound_spell_slug,
          'instanceProperties', i.instance_properties,
          'containedInItemSlug', i.contained_in_item_slug
        )
        ORDER BY i.item_slug
      )
      FROM inv i
    ), '[]'::jsonb),
    'activeItemSlugs', COALESCE((
      SELECT jsonb_agg(a.item_slug ORDER BY a.item_slug)
      FROM active_slugs a
    ), '[]'::jsonb),
    'items', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'slug', cat.slug,
          'name', cat.name,
          'properties', cat.properties
        )
        ORDER BY cat.slug
      )
      FROM rpg.phb_item cat
      WHERE cat.slug IN (SELECT slug FROM related_slugs)
    ), '[]'::jsonb),
    'armor', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'itemSlug', a.item_slug,
          'itemName', a.item_name,
          'categorySlug', a.category_slug,
          'acBase', a.ac_base,
          'strengthReq', a.strength_req,
          'stealthDisadvantage', a.stealth_disadvantage
        )
        ORDER BY a.item_slug
      )
      FROM rpg.v_phb_armor a
      WHERE a.item_slug IN (
        SELECT i.item_slug FROM inv i
        WHERE i.location = 'equipped'
          AND i.equipment_slot IN ('armor', 'shield')
      )
    ), '[]'::jsonb),
    'unarmoredDefenses', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'sourceKind', u.source_kind,
          'sourceSlug', u.source_slug,
          'label', u.label,
          'secondAbilitySlug', u.second_ability_slug,
          'allowsShield', u.allows_shield
        )
      )
      FROM rpg.v_phb_unarmored_defense u
      WHERE (u.source_kind = 'class' AND u.source_slug = p_class_slug)
         OR (
           p_subclass_slug IS NOT NULL
           AND u.source_kind = 'subclass'
           AND u.source_slug = p_subclass_slug
         )
    ), '[]'::jsonb)
  );
$$;

COMMENT ON FUNCTION rpg.get_character_combat_bundle(uuid, text, text) IS
  'Read model de combate da ficha: inventário + itens + armadura + defesa sem armadura + active slugs.';

-- Estende get_character_sheet_bundle: PB + class ability boosts + species.size


-- RPC: bundle da ficha actor (1 round-trip)

-- RLS para game_actor* (espelha player_character; dono + campanha via app)

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping game_actor RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.game_actor ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.game_actor_speed ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.game_actor_action ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.game_actor_spell ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.game_actor_state ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS game_actor_own ON rpg.game_actor;
  CREATE POLICY game_actor_own ON rpg.game_actor
    FOR ALL USING (owner_user_id = auth.uid())
    WITH CHECK (owner_user_id = auth.uid());

  DROP POLICY IF EXISTS game_actor_speed_own ON rpg.game_actor_speed;
  CREATE POLICY game_actor_speed_own ON rpg.game_actor_speed
    FOR ALL USING (
      actor_id IN (SELECT id FROM rpg.game_actor WHERE owner_user_id = auth.uid())
    );

  DROP POLICY IF EXISTS game_actor_action_own ON rpg.game_actor_action;
  CREATE POLICY game_actor_action_own ON rpg.game_actor_action
    FOR ALL USING (
      actor_id IN (SELECT id FROM rpg.game_actor WHERE owner_user_id = auth.uid())
    );

  DROP POLICY IF EXISTS game_actor_spell_own ON rpg.game_actor_spell;
  CREATE POLICY game_actor_spell_own ON rpg.game_actor_spell
    FOR ALL USING (
      actor_id IN (SELECT id FROM rpg.game_actor WHERE owner_user_id = auth.uid())
    );

  DROP POLICY IF EXISTS game_actor_state_own ON rpg.game_actor_state;
  CREATE POLICY game_actor_state_own ON rpg.game_actor_state
    FOR ALL USING (
      actor_id IN (SELECT id FROM rpg.game_actor WHERE owner_user_id = auth.uid())
    );
END $$;

-- Spawn runtime game_actor a partir de template de criatura ou veículo

-- Spawn: copiar ability_scores, initiative, passageiros e descrição de ações



CREATE OR REPLACE FUNCTION rpg.get_game_actor_bundle(p_actor_id uuid)
RETURNS jsonb
LANGUAGE sql
STABLE
AS $$
  SELECT jsonb_build_object(
    'speeds', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'movementKind', s.movement_kind,
          'speedFt', s.speed_ft
        )
        ORDER BY s.movement_kind
      )
      FROM rpg.game_actor_speed s
      WHERE s.actor_id = p_actor_id
    ), '[]'::jsonb),
    'actions', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'id', a.id,
          'name', a.name,
          'actionBucket', a.action_bucket,
          'attackBonus', a.attack_bonus,
          'damageExpression', a.damage_expression,
          'reachFt', a.reach_ft,
          'description', a.description,
          'sortOrder', a.sort_order
        )
        ORDER BY a.sort_order, a.name
      )
      FROM rpg.game_actor_action a
      WHERE a.actor_id = p_actor_id
    ), '[]'::jsonb),
    'spells', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'spellSlug', sp.spell_slug,
          'usageKind', sp.usage_kind,
          'usesPerDay', sp.uses_per_day,
          'slotLevel', sp.slot_level,
          'rechargeDice', sp.recharge_dice,
          'sortOrder', sp.sort_order
        )
        ORDER BY sp.sort_order, sp.spell_slug
      )
      FROM rpg.game_actor_spell sp
      WHERE sp.actor_id = p_actor_id
    ), '[]'::jsonb),
    'state', (
      SELECT jsonb_build_object(
        'conditions', st.conditions,
        'tempHp', st.temp_hp,
        'concentratingOn', st.concentrating_on,
        'innateSpellUses', st.innate_spell_uses
      )
      FROM rpg.game_actor_state st
      WHERE st.actor_id = p_actor_id
    )
  );
$$;

-- Character Threads — estado na ficha (1 ativo por personagem)

CREATE TABLE rpg.player_character_thread (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  thread_slug TEXT NOT NULL REFERENCES rpg.phb_character_thread(slug),
  status TEXT NOT NULL CHECK (status IN ('active', 'completed', 'abandoned')),
  goal_index INT CHECK (goal_index IS NULL OR goal_index BETWEEN 1 AND 6),
  goal_text TEXT,
  started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  ended_at TIMESTAMPTZ,
  CHECK (
    (status = 'active' AND ended_at IS NULL)
    OR (status <> 'active' AND ended_at IS NOT NULL)
  )
);

-- No máximo um thread ativo por personagem
CREATE UNIQUE INDEX uq_player_character_thread_one_active
  ON rpg.player_character_thread(character_id)
  WHERE status = 'active';

CREATE INDEX idx_player_character_thread_character
  ON rpg.player_character_thread(character_id);

CREATE TABLE rpg.player_character_thread_milestone (
  character_thread_id UUID NOT NULL REFERENCES rpg.player_character_thread(id) ON DELETE CASCADE,
  rank TEXT NOT NULL CHECK (rank IN ('least', 'lesser', 'greater', 'superior')),
  benefit_key TEXT NOT NULL CHECK (char_length(benefit_key) BETWEEN 1 AND 64),
  reached_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (character_thread_id, rank, benefit_key)
);

DO $$
BEGIN
  ALTER TABLE rpg.player_character_thread ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_thread_milestone ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_thread_own ON rpg.player_character_thread;
  CREATE POLICY player_character_thread_own ON rpg.player_character_thread
    FOR ALL USING (
      character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    )
    WITH CHECK (
      character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS player_character_thread_milestone_own ON rpg.player_character_thread_milestone;
  CREATE POLICY player_character_thread_milestone_own ON rpg.player_character_thread_milestone
    FOR ALL USING (
      character_thread_id IN (
        SELECT t.id
          FROM rpg.player_character_thread t
          JOIN rpg.player_character c ON c.id = t.character_id
         WHERE c.user_id = auth.uid()
      )
    )
    WITH CHECK (
      character_thread_id IN (
        SELECT t.id
          FROM rpg.player_character_thread t
          JOIN rpg.player_character c ON c.id = t.character_id
         WHERE c.user_id = auth.uid()
      )
    );
EXCEPTION
  WHEN undefined_function THEN
    -- auth.uid() pode não existir em Postgres local sem Supabase
    NULL;
END $$;

-- Personagem: origem PHB species XOR herança GH + picks modulares









CREATE INDEX idx_player_character_heritage_slug
  ON rpg.player_character(heritage_slug)
  WHERE heritage_slug IS NOT NULL;

CREATE TABLE rpg.player_character_heritage_trait (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  slot_index INTEGER NOT NULL CHECK (slot_index BETWEEN 1 AND 9),
  trait_id BIGINT NOT NULL REFERENCES rpg.phb_heritage_trait(id),
  PRIMARY KEY (character_id, slot_index)
);

CREATE INDEX idx_player_character_heritage_trait_trait
  ON rpg.player_character_heritage_trait(trait_id);

CREATE TABLE rpg.player_character_heritage_config (
  character_id UUID PRIMARY KEY REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  speed_trade TEXT CHECK (speed_trade IS NULL OR speed_trade IN ('yes', 'no')),
  size_choice TEXT CHECK (size_choice IS NULL OR size_choice IN ('small', 'medium'))
);

COMMENT ON TABLE rpg.player_character_heritage_trait IS
  'Slots 1–8 de traços modulares GH; slot 9 disponível se speed_trade = yes.';

COMMENT ON TABLE rpg.player_character_heritage_config IS
  'Opções de customização GH: trocar 1,5 m por 9º traço; tamanho Pequeno/Médio.';

CREATE OR REPLACE FUNCTION rpg.spawn_game_actor_from_template(
  p_template_slug text,
  p_owner_user_id uuid,
  p_actor_kind rpg.actor_kind,
  p_campaign_id uuid DEFAULT NULL,
  p_parent_character_id uuid DEFAULT NULL,
  p_name_override text DEFAULT NULL
)
RETURNS uuid
LANGUAGE plpgsql
AS $$
DECLARE
  v_actor_id uuid := gen_random_uuid();
  v_creature rpg.phb_creature_template%ROWTYPE;
  v_vehicle rpg.phb_vehicle_template%ROWTYPE;
BEGIN
  IF p_actor_kind IN ('creature', 'mount', 'companion') THEN
    SELECT * INTO v_creature
    FROM rpg.phb_creature_template
    WHERE slug = p_template_slug;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'Creature template % not found', p_template_slug;
    END IF;

    INSERT INTO rpg.game_actor (
      id,
      owner_user_id,
      campaign_id,
      parent_character_id,
      actor_kind,
      template_slug,
      name,
      hit_points_max,
      hit_points_current,
      armor_class,
      initiative_modifier,
      proficiency_bonus,
      ability_scores,
      size_slug,
      spellcasting_ability_slug,
      spell_save_dc,
      spell_attack_bonus
    ) VALUES (
      v_actor_id,
      p_owner_user_id,
      p_campaign_id,
      p_parent_character_id,
      p_actor_kind,
      p_template_slug,
      COALESCE(p_name_override, v_creature.name),
      v_creature.hit_points_avg,
      v_creature.hit_points_avg,
      v_creature.armor_class,
      v_creature.initiative_modifier,
      v_creature.proficiency_bonus,
      COALESCE(v_creature.ability_scores, '{"forca":10,"destreza":10,"constituicao":10,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb),
      v_creature.size_slug,
      v_creature.spellcasting_ability_slug,
      v_creature.spell_save_dc,
      v_creature.spell_attack_bonus
    );

    INSERT INTO rpg.game_actor_speed (actor_id, movement_kind, speed_ft)
    SELECT v_actor_id, movement_kind, speed_ft
    FROM rpg.phb_creature_template_speed
    WHERE template_slug = p_template_slug;

    INSERT INTO rpg.game_actor_action (
      actor_id, name, action_bucket, attack_bonus, damage_expression, reach_ft, description, sort_order
    )
    SELECT
      v_actor_id, name, action_bucket, attack_bonus, damage_expression, reach_ft, description, sort_order
    FROM rpg.phb_creature_template_action
    WHERE template_slug = p_template_slug;

    INSERT INTO rpg.game_actor_spell (
      actor_id, spell_slug, usage_kind, uses_per_day, slot_level, recharge_dice, sort_order
    )
    SELECT
      v_actor_id, spell_slug, usage_kind, uses_per_day, slot_level, recharge_dice, sort_order
    FROM rpg.phb_creature_template_spell
    WHERE template_slug = p_template_slug;

  ELSIF p_actor_kind = 'vehicle' THEN
    SELECT * INTO v_vehicle
    FROM rpg.phb_vehicle_template
    WHERE slug = p_template_slug;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'Vehicle template % not found', p_template_slug;
    END IF;

    INSERT INTO rpg.game_actor (
      id,
      owner_user_id,
      campaign_id,
      parent_character_id,
      actor_kind,
      template_slug,
      name,
      hit_points_max,
      hit_points_current,
      armor_class,
      initiative_modifier,
      ability_scores,
      damage_threshold,
      crew_capacity,
      passenger_capacity,
      cargo_capacity_lb
    ) VALUES (
      v_actor_id,
      p_owner_user_id,
      p_campaign_id,
      p_parent_character_id,
      'vehicle'::rpg.actor_kind,
      p_template_slug,
      COALESCE(p_name_override, v_vehicle.name),
      v_vehicle.hit_points,
      v_vehicle.hit_points,
      v_vehicle.armor_class,
      v_vehicle.initiative_modifier,
      COALESCE(v_vehicle.ability_scores, '{"forca":10,"destreza":10,"constituicao":10,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb),
      v_vehicle.damage_threshold,
      v_vehicle.crew_capacity,
      v_vehicle.passenger_capacity,
      v_vehicle.cargo_capacity_lb
    );

    INSERT INTO rpg.game_actor_speed (actor_id, movement_kind, speed_ft)
    SELECT v_actor_id, movement_kind, speed_ft
    FROM rpg.phb_vehicle_template_speed
    WHERE template_slug = p_template_slug;

    INSERT INTO rpg.game_actor_action (
      actor_id, name, action_bucket, attack_bonus, damage_expression, reach_ft, description, sort_order
    )
    SELECT
      v_actor_id, name, action_bucket, attack_bonus, damage_expression, reach_ft, description, sort_order
    FROM rpg.phb_vehicle_template_action
    WHERE template_slug = p_template_slug;

  ELSE
    RAISE EXCEPTION 'Unsupported actor_kind % for spawn', p_actor_kind;
  END IF;

  INSERT INTO rpg.game_actor_state (actor_id)
  VALUES (v_actor_id);

  RETURN v_actor_id;
END;
$$;

-- Anotações livres da sessão (ficha do personagem)


COMMENT ON COLUMN rpg.player_character.session_notes IS
  'Anotações da sessão (jogador/DM) — texto livre, não confundir com game_actor.notes';

-- Bundle da ficha: herança GH via player_character_heritage_* + species PHB separados

CREATE OR REPLACE FUNCTION rpg.get_character_sheet_bundle(
  p_character_id uuid,
  p_background_slug text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE sql
STABLE
AS $$
  WITH pc AS (
    SELECT level, class_slug, species_slug, heritage_slug
    FROM rpg.player_character
    WHERE id = p_character_id
  )
  SELECT jsonb_build_object(
    'classSkillSlugs', COALESCE((
      SELECT jsonb_agg(s.skill_slug ORDER BY s.skill_slug)
      FROM rpg.player_character_skill s
      WHERE s.character_id = p_character_id
    ), '[]'::jsonb),
    'speciesChoices', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'choiceKind', sc.choice_kind,
          'choiceSlug', sc.choice_slug
        )
        ORDER BY sc.choice_kind
      )
      FROM rpg.player_character_species_choice sc
      WHERE sc.character_id = p_character_id
    ), '[]'::jsonb),
    'heritageChoices', COALESCE((
      SELECT jsonb_agg(choice ORDER BY (choice->>'choiceKind'))
      FROM (
        SELECT jsonb_build_object(
          'choiceKind', 'heritage_trait_' || ht.slot_index,
          'choiceSlug', tr.slug
        ) AS choice
        FROM rpg.player_character_heritage_trait ht
        JOIN rpg.phb_heritage_trait tr ON tr.id = ht.trait_id
        WHERE ht.character_id = p_character_id
        UNION ALL
        SELECT jsonb_build_object(
          'choiceKind', 'heritage_speed_trade',
          'choiceSlug', cfg.speed_trade
        )
        FROM rpg.player_character_heritage_config cfg
        WHERE cfg.character_id = p_character_id
          AND cfg.speed_trade IS NOT NULL
        UNION ALL
        SELECT jsonb_build_object(
          'choiceKind', 'heritage_size',
          'choiceSlug', cfg.size_choice
        )
        FROM rpg.player_character_heritage_config cfg
        WHERE cfg.character_id = p_character_id
          AND cfg.size_choice IS NOT NULL
      ) heritage_rows
    ), COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'choiceKind', sc.choice_kind,
          'choiceSlug', sc.choice_slug
        )
        ORDER BY sc.choice_kind
      )
      FROM rpg.player_character_species_choice sc
      WHERE sc.character_id = p_character_id
        AND sc.choice_kind LIKE 'heritage_%'
    ), '[]'::jsonb)),
    'subclassOptions', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'optionKey', o.option_key,
          'valueId', o.value_id
        )
        ORDER BY o.option_key
      )
      FROM rpg.player_character_option o
      WHERE o.character_id = p_character_id
        AND o.scope = 'subclass'
    ), '[]'::jsonb),
    'classOptions', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'optionKey', o.option_key,
          'valueId', o.value_id,
          'instanceIndex', o.instance_index
        )
        ORDER BY o.option_key, o.instance_index
      )
      FROM rpg.player_character_option o
      WHERE o.character_id = p_character_id
        AND o.scope = 'class'
    ), '[]'::jsonb),
    'characterFeats', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'featSlug', f.feat_slug,
          'instanceIndex', f.instance_index
        )
        ORDER BY f.feat_slug, f.instance_index
      )
      FROM rpg.player_character_feat f
      WHERE f.character_id = p_character_id
    ), '[]'::jsonb),
    'featOptions', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'featSlug', o.owner_slug,
          'instanceIndex', o.instance_index,
          'optionKey', o.option_key,
          'valueId', o.value_id
        )
        ORDER BY o.owner_slug, o.instance_index, o.option_key
      )
      FROM rpg.player_character_option o
      WHERE o.character_id = p_character_id
        AND o.scope = 'feat'
    ), '[]'::jsonb),
    'characterSpells', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'spellSlug', sp.spell_slug,
          'listType', sp.list_type
        )
        ORDER BY sp.spell_slug
      )
      FROM rpg.player_character_spell sp
      WHERE sp.character_id = p_character_id
    ), '[]'::jsonb),
    'equipment', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'source', e.source,
          'packageSlug', e.package_slug,
          'itemSlug', e.item_slug,
          'quantity', e.quantity,
          'sortOrder', e.sort_order
        )
        ORDER BY e.sort_order
      )
      FROM rpg.player_character_equipment e
      WHERE e.character_id = p_character_id
    ), '[]'::jsonb),
    'languageSlugs', COALESCE((
      SELECT jsonb_agg(l.language_slug ORDER BY l.language_slug)
      FROM rpg.player_character_language l
      WHERE l.character_id = p_character_id
    ), '[]'::jsonb),
    'backgroundSkillSlugs', CASE
      WHEN p_background_slug IS NULL OR btrim(p_background_slug) = '' THEN '[]'::jsonb
      ELSE COALESCE((
        SELECT jsonb_agg(sk.slug ORDER BY sk.slug)
        FROM rpg.phb_background_skill bs
        JOIN rpg.phb_background b ON b.id = bs.background_id
        JOIN rpg.phb_skill sk ON sk.id = bs.skill_id
        WHERE b.slug = p_background_slug
      ), '[]'::jsonb)
    END,
    'proficiencyBonus', (
      SELECT cl.proficiency_bonus
      FROM pc
      JOIN rpg.phb_character_level cl ON cl.level = pc.level
    ),
    'classAbilityBoosts', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'abilitySlug', b.ability_slug,
          'label', b.label,
          'bonus', b.bonus,
          'scoreMax', b.score_max,
          'fromLevel', b.from_level
        )
        ORDER BY b.from_level, b.ability_slug
      )
      FROM pc
      JOIN rpg.v_phb_class_ability_boost b ON b.class_slug = pc.class_slug
    ), '[]'::jsonb),
    'speciesSize', COALESCE(
      (
        SELECT cfg.size_choice
        FROM rpg.player_character_heritage_config cfg
        WHERE cfg.character_id = p_character_id
          AND cfg.size_choice IS NOT NULL
      ),
      (
        SELECT s.size
        FROM pc
        JOIN rpg.phb_species s ON s.slug = pc.species_slug
      ),
      (
        SELECT h.size_rule
        FROM pc
        JOIN rpg.phb_heritage h ON h.slug = pc.heritage_slug
      )
    )
  );
$$;

COMMENT ON FUNCTION rpg.get_character_sheet_bundle(uuid, text) IS
  'Read model da ficha: filhos + PB + boosts + origem PHB/herança GH.';
