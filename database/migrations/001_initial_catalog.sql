-- RPG PHB 2024 — PostgreSQL v4 (DDL prod-safe — sem DROP SCHEMA)
-- Gerado por: npm run generate:sql-schema
-- Docs: .cursor/skills/rpg-database/docs/plano-final.md

CREATE SCHEMA IF NOT EXISTS rpg;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- =============================================================================
-- TIPOS ENUM
-- =============================================================================

CREATE TYPE rpg.item_type AS ENUM (
  'weapon','armor','gear','tool','focus','other'
);

CREATE TYPE rpg.resource_scope AS ENUM ('species','class');

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

-- =============================================================================
-- CATÁLOGO PHB — entidades com id BIGSERIAL + slug UNIQUE
-- =============================================================================

CREATE TABLE rpg.phb_edition (
  id           BIGSERIAL PRIMARY KEY,
  slug         TEXT NOT NULL UNIQUE,
  label        TEXT NOT NULL,
  book         TEXT NOT NULL DEFAULT 'Livro do Jogador 2024',
  language     TEXT NOT NULL DEFAULT 'pt-BR',
  extracted_at TIMESTAMPTZ,
  notes        TEXT
);

INSERT INTO rpg.phb_edition (slug, label, extracted_at)
VALUES ('phb-2024-pt', 'PHB 2024 PT-BR', NOW());

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

CREATE TABLE rpg.phb_feat_category (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  type_label TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE rpg.phb_feat (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  category_id BIGINT NOT NULL REFERENCES rpg.phb_feat_category(id),
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

CREATE TABLE rpg.phb_divine_order (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL
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

CREATE TABLE rpg.phb_hit_die (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  sides INTEGER NOT NULL UNIQUE CHECK (sides IN (6, 8, 10, 12)),
  label TEXT NOT NULL
);

INSERT INTO rpg.phb_hit_die (slug, sides, label) VALUES
  ('d6', 6, 'D6'),
  ('d8', 8, 'D8'),
  ('d10', 10, 'D10'),
  ('d12', 12, 'D12');

CREATE TABLE rpg.phb_weapon_proficiency (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  label TEXT NOT NULL UNIQUE
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
  hit_die_id BIGINT NOT NULL REFERENCES rpg.phb_hit_die(id),
  hp_level1_die_value INTEGER CHECK (hp_level1_die_value >= 0),
  hp_fixed_per_level INTEGER CHECK (hp_fixed_per_level >= 0),
  hp_minimum_gain_per_level INTEGER CHECK (hp_minimum_gain_per_level >= 1),
  hp_constitution_mod_applies BOOLEAN NOT NULL DEFAULT TRUE,
  subclass_unlock_level INTEGER NOT NULL DEFAULT 3 CHECK (subclass_unlock_level >= 1),
  subclass_label TEXT,
  skill_choice_count INTEGER CHECK (skill_choice_count >= 1),
  skill_choice_from TEXT CHECK (skill_choice_from IN ('any')),
  spell_slot_pattern_id BIGINT REFERENCES rpg.phb_spell_slot_pattern(id),
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
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
  UNIQUE (class_id, id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE rpg.phb_subclass_feature (
  id BIGSERIAL PRIMARY KEY,
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level >= 1),
  name TEXT NOT NULL,
  description TEXT NOT NULL,
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
  source_meta JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
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
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE rpg.phb_background (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT,
  feat_id BIGINT REFERENCES rpg.phb_feat(id),
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  equipment_gold_option INTEGER CHECK (equipment_gold_option >= 0),
  tool_proficiency_description TEXT,
  tool_proficiency_kind TEXT CHECK (tool_proficiency_kind IN ('fixed', 'choice')),
  tool_item_id BIGINT REFERENCES rpg.phb_item(id),
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

CREATE TABLE rpg.phb_ability_generation_method (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL
);

CREATE TABLE rpg.phb_background_boost_option (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  label TEXT NOT NULL
);

CREATE TABLE rpg.phb_druid_land_terrain (
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
  min_level INTEGER NOT NULL DEFAULT 1 CHECK (min_level BETWEEN 1 AND 20),
  CONSTRAINT prd_scope_fk CHECK (
    (scope = 'species' AND species_id IS NOT NULL AND class_id IS NULL) OR
    (scope = 'class' AND class_id IS NOT NULL AND species_id IS NULL)
  )
);

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

-- =============================================================================
-- CATÁLOGO — tabelas filhas / junctions (FK BIGINT)
-- =============================================================================

CREATE TABLE rpg.phb_class_progression (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  proficiency_bonus INTEGER NOT NULL CHECK (proficiency_bonus BETWEEN 2 AND 6),
  cantrips INTEGER CHECK (cantrips >= 0),
  prepared_spells INTEGER CHECK (prepared_spells >= 0),
  channel_divinity INTEGER CHECK (channel_divinity >= 0),
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
  terrain_id BIGINT REFERENCES rpg.phb_druid_land_terrain(id) ON DELETE CASCADE,
  CONSTRAINT uq_subclass_prepared_spell
    UNIQUE NULLS NOT DISTINCT (subclass_id, unlock_level, spell_id, terrain_id)
);

CREATE TABLE rpg.phb_elf_lineage (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  level1_benefit TEXT NOT NULL,
  spell_level3_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_level5_id BIGINT REFERENCES rpg.phb_spell(id)
);

CREATE TABLE rpg.phb_infernal_legacy (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  level1_benefit TEXT NOT NULL,
  spell_level3_id BIGINT REFERENCES rpg.phb_spell(id),
  spell_level5_id BIGINT REFERENCES rpg.phb_spell(id)
);

CREATE TABLE rpg.phb_dragon_ancestry (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  damage_type TEXT NOT NULL
);

CREATE TABLE rpg.phb_species_trait (
  id BIGSERIAL PRIMARY KEY,
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  choice_kind rpg.species_choice_kind,
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

CREATE TABLE rpg.phb_background_starting_package (
  id BIGSERIAL PRIMARY KEY,
  background_id BIGINT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  slug TEXT NOT NULL,
  label TEXT NOT NULL,
  gold INTEGER CHECK (gold >= 0),
  sort_order INTEGER NOT NULL DEFAULT 0,
  UNIQUE (background_id, slug)
);

CREATE TABLE rpg.phb_background_starting_item (
  id BIGSERIAL PRIMARY KEY,
  package_id BIGINT NOT NULL REFERENCES rpg.phb_background_starting_package(id) ON DELETE CASCADE,
  item_id BIGINT REFERENCES rpg.phb_item(id),
  choice_text TEXT,
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  sort_order INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT pbsi_item_or_choice CHECK (
    item_id IS NOT NULL OR choice_text IS NOT NULL
  )
);

CREATE TABLE rpg.phb_class_saving_throw (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  ability_id BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  PRIMARY KEY (class_id, ability_id)
);

CREATE TABLE rpg.phb_class_primary_ability (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  ability_id BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (class_id, ability_id)
);

CREATE TABLE rpg.phb_class_armor_training (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  category_id BIGINT NOT NULL REFERENCES rpg.phb_armor_category(id),
  PRIMARY KEY (class_id, category_id)
);

CREATE TABLE rpg.phb_class_weapon_proficiency (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  proficiency_id BIGINT NOT NULL REFERENCES rpg.phb_weapon_proficiency(id),
  PRIMARY KEY (class_id, proficiency_id)
);

CREATE TABLE rpg.phb_class_spellcasting (
  class_id BIGINT PRIMARY KEY REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  casting_type rpg.casting_type NOT NULL,
  ability_id BIGINT REFERENCES rpg.phb_ability(id),
  focus_label TEXT,
  focus_item_id BIGINT REFERENCES rpg.phb_item(id),
  ritual BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE rpg.phb_class_starting_package (
  id BIGSERIAL PRIMARY KEY,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  slug TEXT NOT NULL,
  label TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0,
  UNIQUE (class_id, slug)
);

CREATE TABLE rpg.phb_class_starting_item (
  id BIGSERIAL PRIMARY KEY,
  package_id BIGINT NOT NULL REFERENCES rpg.phb_class_starting_package(id) ON DELETE CASCADE,
  item_id BIGINT REFERENCES rpg.phb_item(id),
  choice_text TEXT,
  gold_amount INTEGER CHECK (gold_amount >= 0),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  sort_order INTEGER NOT NULL DEFAULT 0,
  CONSTRAINT pcsi_has_content CHECK (
    item_id IS NOT NULL OR choice_text IS NOT NULL OR gold_amount IS NOT NULL
  )
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

CREATE TABLE rpg.phb_tool_category (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  sort_order INTEGER NOT NULL DEFAULT 0
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

CREATE TABLE rpg.phb_species_option_def (
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  option_key TEXT NOT NULL,
  value_type rpg.option_value_type NOT NULL,
  PRIMARY KEY (species_id, option_key)
);

CREATE TABLE rpg.phb_species_option_value (
  species_id BIGINT NOT NULL,
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  label TEXT NOT NULL,
  PRIMARY KEY (species_id, option_key, value_id),
  FOREIGN KEY (species_id, option_key)
    REFERENCES rpg.phb_species_option_def(species_id, option_key) ON DELETE CASCADE
);

CREATE TABLE rpg.phb_weapon_property_link (
  weapon_id BIGINT NOT NULL REFERENCES rpg.phb_weapon(item_id) ON DELETE CASCADE,
  property_id BIGINT NOT NULL REFERENCES rpg.phb_weapon_property(id) ON DELETE CASCADE,
  PRIMARY KEY (weapon_id, property_id)
);

CREATE TABLE rpg.phb_class_fighting_style (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  fighting_style_id BIGINT NOT NULL REFERENCES rpg.phb_fighting_style(id) ON DELETE CASCADE,
  PRIMARY KEY (class_id, fighting_style_id)
);

-- =============================================================================
-- VIEWS
-- =============================================================================

CREATE OR REPLACE VIEW rpg.v_spell_by_class AS
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

CREATE OR REPLACE VIEW rpg.v_phb_spell AS
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
  e.slug AS edition_slug
FROM rpg.phb_spell s
JOIN rpg.phb_spell_school sch ON sch.id = s.school_id
LEFT JOIN rpg.phb_source_citation sc ON sc.id = s.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id;

CREATE OR REPLACE VIEW rpg.v_phb_subclass AS
SELECT
  s.slug AS subclass_slug,
  s.name AS subclass_name,
  c.slug AS class_slug,
  c.name AS class_name,
  s.tagline,
  s.summary,
  cit.chapter AS source_chapter,
  e.slug AS edition_slug,
  ss.slug AS spell_source_slug,
  ss.label AS spell_source_label
FROM rpg.phb_subclass s
JOIN rpg.phb_class c ON c.id = s.class_id
LEFT JOIN rpg.phb_source_citation cit ON cit.id = s.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = cit.edition_id
LEFT JOIN rpg.phb_spell_source ss ON ss.subclass_id = s.id;

CREATE OR REPLACE VIEW rpg.v_phb_subclass_prepared_spell AS
SELECT
  s.slug AS subclass_slug,
  ps.unlock_level,
  sp.slug AS spell_slug,
  sp.name AS spell_name,
  t.slug AS terrain_slug,
  t.label AS terrain_label
FROM rpg.phb_subclass_prepared_spell ps
JOIN rpg.phb_subclass s ON s.id = ps.subclass_id
JOIN rpg.phb_spell sp ON sp.id = ps.spell_id
LEFT JOIN rpg.phb_druid_land_terrain t ON t.id = ps.terrain_id;

CREATE OR REPLACE VIEW rpg.v_phb_armor AS
SELECT
  i.slug AS item_slug,
  i.name AS item_name,
  c.slug AS category_slug,
  c.name AS category_name,
  c.don_doff,
  a.ac_base,
  a.ac_formula,
  a.strength_req,
  a.stealth_disadvantage
FROM rpg.phb_armor a
JOIN rpg.phb_item i ON i.id = a.item_id
JOIN rpg.phb_armor_category c ON c.id = a.category_id;

CREATE OR REPLACE VIEW rpg.v_phb_background AS
SELECT
  b.slug AS background_slug,
  b.name AS background_name,
  b.equipment_gold_option,
  sc.chapter AS source_chapter,
  sc.chapter_title AS source_chapter_title,
  e.slug AS edition_slug,
  array_agg(ab.slug ORDER BY bao.sort_order) AS ability_option_slugs,
  array_agg(ab.name ORDER BY bao.sort_order) AS ability_option_names
FROM rpg.phb_background b
LEFT JOIN rpg.phb_source_citation sc ON sc.id = b.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id
LEFT JOIN rpg.phb_background_ability_option bao ON bao.background_id = b.id
LEFT JOIN rpg.phb_ability ab ON ab.id = bao.ability_id
GROUP BY b.id, b.slug, b.name, b.equipment_gold_option, sc.chapter, sc.chapter_title, e.slug;

CREATE OR REPLACE VIEW rpg.v_phb_background_equipment AS
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
JOIN rpg.phb_background_starting_package p ON p.background_id = b.id
JOIN rpg.phb_background_starting_item si ON si.package_id = p.id
LEFT JOIN rpg.phb_item i ON i.id = si.item_id
ORDER BY b.slug, p.sort_order, si.sort_order;

CREATE OR REPLACE VIEW rpg.v_phb_class AS
SELECT
  c.slug AS class_slug,
  c.name AS class_name,
  c.primary_ability_label,
  c.primary_ability_operator,
  hd.label AS hit_die,
  c.hp_level1_die_value,
  c.hp_fixed_per_level,
  c.skill_choice_count,
  c.skill_choice_from,
  array_agg(pa.slug ORDER BY cpa.sort_order) AS primary_ability_slugs,
  sc.chapter AS source_chapter,
  e.slug AS edition_slug
FROM rpg.phb_class c
JOIN rpg.phb_hit_die hd ON hd.id = c.hit_die_id
LEFT JOIN rpg.phb_source_citation sc ON sc.id = c.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id
LEFT JOIN rpg.phb_class_primary_ability cpa ON cpa.class_id = c.id
LEFT JOIN rpg.phb_ability pa ON pa.id = cpa.ability_id
GROUP BY c.id, c.slug, c.name, c.primary_ability_label, c.primary_ability_operator,
  hd.label, c.hp_level1_die_value, c.hp_fixed_per_level, c.skill_choice_count,
  c.skill_choice_from, sc.chapter, e.slug;

CREATE OR REPLACE VIEW rpg.v_phb_class_equipment AS
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
JOIN rpg.phb_class_starting_package p ON p.class_id = c.id
JOIN rpg.phb_class_starting_item si ON si.package_id = p.id
LEFT JOIN rpg.phb_item i ON i.id = si.item_id
ORDER BY c.slug, p.sort_order, si.sort_order;

CREATE OR REPLACE VIEW rpg.v_phb_feat AS
SELECT
  f.slug AS feat_slug,
  f.name AS feat_name,
  fc.slug AS category_slug,
  fc.name AS category_name,
  fc.type_label AS category_type_label,
  f.repeatable,
  f.prerequisite,
  sc.chapter AS source_chapter,
  sc.chapter_title AS source_chapter_title,
  e.slug AS edition_slug,
  COALESCE(
    jsonb_agg(
      jsonb_strip_nulls(jsonb_build_object('name', fb.name, 'description', fb.description))
      ORDER BY fb.sort_order
    ) FILTER (WHERE fb.id IS NOT NULL),
    '[]'::jsonb
  ) AS benefits
FROM rpg.phb_feat f
JOIN rpg.phb_feat_category fc ON fc.id = f.category_id
LEFT JOIN rpg.phb_source_citation sc ON sc.id = f.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id
LEFT JOIN rpg.phb_feat_benefit fb ON fb.feat_id = f.id
GROUP BY f.id, f.slug, f.name, fc.slug, fc.name, fc.type_label, f.repeatable, f.prerequisite,
  sc.chapter, sc.chapter_title, e.slug;

CREATE OR REPLACE VIEW rpg.v_phb_class_skill_choice AS
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

CREATE OR REPLACE VIEW rpg.v_class_spell_slots AS
SELECT
  c.slug AS class_slug,
  cp.level AS class_level,
  p.slug AS pattern_slug,
  p.name AS pattern_name,
  jsonb_object_agg(ss.circle::text, ss.slot_count ORDER BY ss.circle) AS spell_slots
FROM rpg.phb_class c
JOIN rpg.phb_spell_slot_pattern p ON p.id = c.spell_slot_pattern_id
JOIN rpg.phb_class_progression cp ON cp.class_id = c.id
JOIN rpg.phb_spell_slot_by_level ss ON ss.pattern_id = p.id AND ss.level = cp.level
GROUP BY c.slug, cp.level, p.slug, p.name;

CREATE OR REPLACE VIEW rpg.v_phb_species_trait_choices AS
SELECT
  sp.slug AS species_slug,
  t.name AS trait_name,
  t.choice_kind,
  el.slug AS choice_slug,
  el.name AS choice_name,
  el.level1_benefit,
  s3.slug AS spell_level3_slug,
  s5.slug AS spell_level5_slug,
  NULL::text AS damage_type
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_elf_lineage el ON t.choice_kind = 'elf_lineage'
LEFT JOIN rpg.phb_spell s3 ON s3.id = el.spell_level3_id
LEFT JOIN rpg.phb_spell s5 ON s5.id = el.spell_level5_id
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  il.slug,
  il.name,
  il.level1_benefit,
  s3.slug,
  s5.slug,
  NULL::text
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_infernal_legacy il ON t.choice_kind = 'infernal_legacy'
LEFT JOIN rpg.phb_spell s3 ON s3.id = il.spell_level3_id
LEFT JOIN rpg.phb_spell s5 ON s5.id = il.spell_level5_id
UNION ALL
SELECT
  sp.slug,
  t.name,
  t.choice_kind,
  da.slug,
  da.name,
  NULL::text,
  NULL::text,
  NULL::text,
  da.damage_type
FROM rpg.phb_species_trait t
JOIN rpg.phb_species sp ON sp.id = t.species_id
JOIN rpg.phb_dragon_ancestry da ON t.choice_kind = 'dragon_ancestry';

-- =============================================================================
-- MATERIALIZED VIEWS (hot path — refresh após seed: npm run refresh:views)
-- =============================================================================

CREATE MATERIALIZED VIEW rpg.mv_spell_by_class AS
  SELECT * FROM rpg.v_spell_by_class;

-- =============================================================================
-- ÍNDICES
-- =============================================================================

CREATE INDEX idx_phb_species_trait_choice ON rpg.phb_species_trait(choice_kind);
CREATE INDEX idx_phb_elf_lineage_spells ON rpg.phb_elf_lineage(spell_level3_id, spell_level5_id);
CREATE INDEX idx_phb_feat_category ON rpg.phb_feat(category_id);
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
CREATE INDEX idx_phb_class_hit_die ON rpg.phb_class(hit_die_id);
CREATE INDEX idx_phb_class_source ON rpg.phb_class(source_citation_id);
CREATE INDEX idx_phb_armor_category ON rpg.phb_armor(category_id);
CREATE INDEX idx_phb_tool_category ON rpg.phb_tool(category_id);

CREATE UNIQUE INDEX uq_resource_species ON rpg.phb_resource_definition (species_id, slug)
  WHERE scope = 'species';
CREATE UNIQUE INDEX uq_resource_class ON rpg.phb_resource_definition (class_id, slug)
  WHERE scope = 'class';

-- Autocomplete (pg_trgm)
CREATE INDEX idx_phb_spell_name_trgm ON rpg.phb_spell USING gin (name gin_trgm_ops);
CREATE INDEX idx_phb_feat_name_trgm ON rpg.phb_feat USING gin (name gin_trgm_ops);
CREATE INDEX idx_phb_class_name_trgm ON rpg.phb_class USING gin (name gin_trgm_ops);
CREATE INDEX idx_phb_item_name_trgm ON rpg.phb_item USING gin (name gin_trgm_ops);
CREATE INDEX idx_phb_species_name_trgm ON rpg.phb_species USING gin (name gin_trgm_ops);
CREATE INDEX idx_phb_subclass_name_trgm ON rpg.phb_subclass USING gin (name gin_trgm_ops);
CREATE INDEX idx_phb_background_name_trgm ON rpg.phb_background USING gin (name gin_trgm_ops);

-- Materialized views
CREATE UNIQUE INDEX idx_mv_spell_by_class ON rpg.mv_spell_by_class (class_slug, spell_slug);

-- =============================================================================
-- AUDITORIA (updated_at automático)
-- =============================================================================

CREATE OR REPLACE FUNCTION rpg.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_phb_spell_updated_at BEFORE UPDATE ON rpg.phb_spell FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();
CREATE TRIGGER tr_phb_class_updated_at BEFORE UPDATE ON rpg.phb_class FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();
CREATE TRIGGER tr_phb_subclass_updated_at BEFORE UPDATE ON rpg.phb_subclass FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();
CREATE TRIGGER tr_phb_species_updated_at BEFORE UPDATE ON rpg.phb_species FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();
CREATE TRIGGER tr_phb_background_updated_at BEFORE UPDATE ON rpg.phb_background FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();
CREATE TRIGGER tr_phb_feat_updated_at BEFORE UPDATE ON rpg.phb_feat FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();
CREATE TRIGGER tr_phb_item_updated_at BEFORE UPDATE ON rpg.phb_item FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();


-- =============================================================================
-- FICHAS — player_character (relacional + runtime)
-- =============================================================================

CREATE TYPE rpg.skill_source AS ENUM (
  'species','background','class','feat','other'
);

CREATE TYPE rpg.feat_source AS ENUM (
  'background','class','species','general','other'
);

CREATE TYPE rpg.equipment_source AS ENUM (
  'background','class','purchase','other'
);

CREATE TYPE rpg.equipment_slot AS ENUM (
  'main_hand','off_hand','armor','shield','focus','other'
);

CREATE TYPE rpg.spell_list_type AS ENUM ('known','prepared','always_prepared');

CREATE TABLE rpg.player_character (
  id                         TEXT PRIMARY KEY,
  name                       TEXT NOT NULL,
  level                      INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  edition_id                 BIGINT NOT NULL REFERENCES rpg.phb_edition(id),
  species_id                 BIGINT NOT NULL REFERENCES rpg.phb_species(id),
  background_id              BIGINT NOT NULL REFERENCES rpg.phb_background(id),
  class_id                   BIGINT NOT NULL REFERENCES rpg.phb_class(id),
  subclass_id                BIGINT REFERENCES rpg.phb_subclass(id),
  alignment_id               BIGINT REFERENCES rpg.phb_alignment(id),
  ability_method_id          BIGINT REFERENCES rpg.phb_ability_generation_method(id),
  background_boost_id        BIGINT REFERENCES rpg.phb_background_boost_option(id),
  class_starting_option      TEXT,
  background_starting_option TEXT,
  hp_current                 INTEGER NOT NULL DEFAULT 0 CHECK (hp_current >= 0),
  hp_max                     INTEGER NOT NULL CHECK (hp_max >= 1),
  hp_temp                    INTEGER NOT NULL DEFAULT 0 CHECK (hp_temp >= 0),
  ac_total                   INTEGER NOT NULL CHECK (ac_total >= 0),
  ac_base                    INTEGER NOT NULL DEFAULT 10 CHECK (ac_base >= 0),
  ac_dex_bonus               INTEGER NOT NULL DEFAULT 0,
  ac_shield_bonus            INTEGER NOT NULL DEFAULT 0 CHECK (ac_shield_bonus >= 0),
  ac_fighting_style_bonus    INTEGER NOT NULL DEFAULT 0,
  ac_other_bonus             INTEGER NOT NULL DEFAULT 0,
  passive_perception         INTEGER,
  notes                      TEXT,
  created_at                 TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at                 TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CHECK (
    ac_total = ac_base + ac_dex_bonus + ac_shield_bonus
      + ac_fighting_style_bonus + ac_other_bonus
  )
);

CREATE TABLE rpg.player_character_language (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  language_id  BIGINT NOT NULL REFERENCES rpg.phb_language(id),
  PRIMARY KEY (character_id, language_id)
);

CREATE TABLE rpg.player_character_ability (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  ability_id   BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  score        INTEGER NOT NULL CHECK (score BETWEEN 1 AND 30),
  PRIMARY KEY (character_id, ability_id)
);

CREATE TABLE rpg.player_character_skill (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  skill_id     BIGINT NOT NULL REFERENCES rpg.phb_skill(id),
  source       rpg.skill_source NOT NULL,
  PRIMARY KEY (character_id, skill_id)
);

CREATE TABLE rpg.player_character_saving_throw (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  ability_id   BIGINT NOT NULL REFERENCES rpg.phb_ability(id),
  PRIMARY KEY (character_id, ability_id)
);

CREATE TABLE rpg.player_character_feat (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  feat_id      BIGINT NOT NULL REFERENCES rpg.phb_feat(id),
  source       rpg.feat_source NOT NULL,
  options      JSONB,
  PRIMARY KEY (character_id, feat_id, source)
);

CREATE TABLE rpg.player_character_equipment (
  id           BIGSERIAL PRIMARY KEY,
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  item_id      BIGINT NOT NULL REFERENCES rpg.phb_item(id),
  quantity     INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  source       rpg.equipment_source NOT NULL,
  equipped     BOOLEAN NOT NULL DEFAULT FALSE,
  slot         rpg.equipment_slot
);

CREATE TABLE rpg.player_character_weapon_mastery (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  weapon_id    BIGINT NOT NULL REFERENCES rpg.phb_weapon(item_id),
  PRIMARY KEY (character_id, weapon_id)
);

CREATE TABLE rpg.player_character_expertise (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  skill_id     BIGINT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (character_id, skill_id)
);

CREATE TABLE rpg.player_character_spell_list (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  spell_id     BIGINT NOT NULL REFERENCES rpg.phb_spell(id),
  list_type    rpg.spell_list_type NOT NULL,
  source_id    BIGINT NOT NULL REFERENCES rpg.phb_spell_source(id),
  PRIMARY KEY (character_id, spell_id, list_type, source_id)
);

CREATE TABLE rpg.player_character_spell_slot (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  circle       INTEGER NOT NULL CHECK (circle BETWEEN 1 AND 9),
  slots_max    INTEGER NOT NULL CHECK (slots_max >= 0),
  slots_used   INTEGER NOT NULL DEFAULT 0 CHECK (slots_used >= 0),
  PRIMARY KEY (character_id, circle),
  CHECK (slots_used <= slots_max)
);

CREATE TABLE rpg.player_character_resource (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  resource_id  BIGINT NOT NULL REFERENCES rpg.phb_resource_definition(id),
  max_value    INTEGER NOT NULL CHECK (max_value >= 0),
  remaining    INTEGER NOT NULL CHECK (remaining >= 0),
  PRIMARY KEY (character_id, resource_id),
  CHECK (remaining <= max_value)
);

CREATE TABLE rpg.player_character_species_option (
  character_id      TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  species_id        BIGINT NOT NULL REFERENCES rpg.phb_species(id),
  option_key        TEXT NOT NULL,
  catalog_value_id  TEXT,
  skill_id          BIGINT REFERENCES rpg.phb_skill(id),
  ability_id        BIGINT REFERENCES rpg.phb_ability(id),
  json_value        JSONB,
  PRIMARY KEY (character_id, option_key),
  CONSTRAINT pso_has_value CHECK (
    catalog_value_id IS NOT NULL OR skill_id IS NOT NULL
    OR ability_id IS NOT NULL OR json_value IS NOT NULL
  )
);

CREATE TABLE rpg.player_character_class_option (
  character_id       TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  class_id           BIGINT NOT NULL REFERENCES rpg.phb_class(id),
  option_key         TEXT NOT NULL,
  catalog_value_id   TEXT,
  fighting_style_id  BIGINT REFERENCES rpg.phb_fighting_style(id),
  terrain_id         BIGINT REFERENCES rpg.phb_druid_land_terrain(id),
  json_value         JSONB,
  PRIMARY KEY (character_id, option_key),
  CONSTRAINT pco_has_value CHECK (
    catalog_value_id IS NOT NULL OR fighting_style_id IS NOT NULL
    OR terrain_id IS NOT NULL OR json_value IS NOT NULL
  )
);

CREATE UNIQUE INDEX uq_pc_equipment_equipped_slot
  ON rpg.player_character_equipment (character_id, slot)
  WHERE equipped = TRUE AND slot IS NOT NULL;

CREATE INDEX idx_pc_class_level ON rpg.player_character (class_id, level);
CREATE INDEX idx_pc_species ON rpg.player_character (species_id);
CREATE INDEX idx_pc_edition ON rpg.player_character (edition_id);
CREATE INDEX idx_pc_name_trgm ON rpg.player_character USING gin (name gin_trgm_ops);

-- =============================================================================
-- INTEGRIDADE FICHAS
-- =============================================================================

CREATE OR REPLACE FUNCTION rpg.validate_pc_subclass()
RETURNS TRIGGER AS $$
DECLARE
  sub_class_id BIGINT;
  unlock_level INTEGER;
BEGIN
  IF NEW.subclass_id IS NULL THEN
    RETURN NEW;
  END IF;
  SELECT s.class_id, c.subclass_unlock_level
    INTO sub_class_id, unlock_level
  FROM rpg.phb_subclass s
  JOIN rpg.phb_class c ON c.id = s.class_id
  WHERE s.id = NEW.subclass_id;
  IF sub_class_id IS NULL THEN
    RAISE EXCEPTION 'subclass_id % inválida', NEW.subclass_id;
  END IF;
  IF sub_class_id <> NEW.class_id THEN
    RAISE EXCEPTION 'subclasse não pertence à classe do personagem';
  END IF;
  IF NEW.level < unlock_level THEN
    RAISE EXCEPTION 'nível % insuficiente para subclasse (desbloqueio %)', NEW.level, unlock_level;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_validate_pc_subclass
  BEFORE INSERT OR UPDATE ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.validate_pc_subclass();

CREATE TRIGGER tr_player_character_updated_at
  BEFORE UPDATE ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

-- =============================================================================
-- RUNTIME — CA recalculada a partir de equipamento
-- =============================================================================

CREATE OR REPLACE FUNCTION rpg.skip_character_sync()
RETURNS BOOLEAN AS $$
  SELECT current_setting('rpg.skip_sync', true) = '1';
$$ LANGUAGE sql STABLE;

CREATE OR REPLACE FUNCTION rpg.ability_modifier(score INTEGER)
RETURNS INTEGER AS $$
  SELECT FLOOR((score - 10) / 2.0)::INTEGER;
$$ LANGUAGE sql IMMUTABLE;

CREATE OR REPLACE FUNCTION rpg.recalculate_character_ac(p_character_id TEXT)
RETURNS void AS $$
DECLARE
  v_dex_score INTEGER;
  v_dex_mod INTEGER;
  v_base INTEGER := 10;
  v_dex_bonus INTEGER;
  v_shield_bonus INTEGER := 0;
  v_style_bonus INTEGER := 0;
  v_other_bonus INTEGER := 0;
  v_total INTEGER;
  v_cat_slug TEXT;
BEGIN
  IF rpg.skip_character_sync() THEN
    RETURN;
  END IF;

  SELECT pca.score INTO v_dex_score
  FROM rpg.player_character_ability pca
  JOIN rpg.phb_ability a ON a.id = pca.ability_id
  WHERE pca.character_id = p_character_id AND a.slug = 'destreza';

  v_dex_mod := rpg.ability_modifier(COALESCE(v_dex_score, 10));
  v_dex_bonus := v_dex_mod;

  SELECT cat.slug INTO v_cat_slug
  FROM rpg.player_character_equipment pce
  JOIN rpg.phb_armor ar ON ar.item_id = pce.item_id
  JOIN rpg.phb_armor_category cat ON cat.id = ar.category_id
  WHERE pce.character_id = p_character_id AND pce.equipped AND pce.slot = 'armor'
  LIMIT 1;

  IF v_cat_slug IS NOT NULL THEN
    SELECT ar.ac_base INTO v_base
    FROM rpg.player_character_equipment pce
    JOIN rpg.phb_armor ar ON ar.item_id = pce.item_id
    WHERE pce.character_id = p_character_id AND pce.equipped AND pce.slot = 'armor'
    LIMIT 1;

    v_dex_bonus := CASE v_cat_slug
      WHEN 'heavy' THEN 0
      WHEN 'medium' THEN LEAST(v_dex_mod, 2)
      ELSE v_dex_mod
    END;
  END IF;

  IF EXISTS (
    SELECT 1 FROM rpg.player_character_equipment
    WHERE character_id = p_character_id AND equipped AND slot = 'shield'
  ) THEN
    v_shield_bonus := 2;
  END IF;

  SELECT
    COALESCE(ac_fighting_style_bonus, 0),
    COALESCE(ac_other_bonus, 0)
  INTO v_style_bonus, v_other_bonus
  FROM rpg.player_character
  WHERE id = p_character_id;

  v_total := v_base + v_dex_bonus + v_shield_bonus + v_style_bonus + v_other_bonus;

  UPDATE rpg.player_character
  SET
    ac_total = v_total,
    ac_base = v_base,
    ac_dex_bonus = v_dex_bonus,
    ac_shield_bonus = v_shield_bonus
  WHERE id = p_character_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rpg.trg_recalculate_ac_on_equipment()
RETURNS TRIGGER AS $$
DECLARE
  v_id TEXT;
BEGIN
  v_id := COALESCE(NEW.character_id, OLD.character_id);
  PERFORM rpg.recalculate_character_ac(v_id);
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tr_recalc_ac_on_equipment ON rpg.player_character_equipment;

CREATE TRIGGER tr_recalc_ac_on_equipment
  AFTER INSERT OR UPDATE OF equipped, slot, item_id OR DELETE
  ON rpg.player_character_equipment
  FOR EACH ROW EXECUTE FUNCTION rpg.trg_recalculate_ac_on_equipment();

-- =============================================================================
-- DOCUMENTO — monta JSON a partir das projeções (substitui sheet)
-- =============================================================================

CREATE OR REPLACE FUNCTION rpg.character_document(p_id TEXT)
RETURNS JSONB AS $$
  SELECT jsonb_strip_nulls(jsonb_build_object(
    'id', pc.id,
    'name', pc.name,
    'level', pc.level,
    'speciesId', sp.slug,
    'backgroundId', bg.slug,
    'classId', cl.slug,
    'subclassId', sb.slug,
    'alignmentId', al.slug,
    'abilityGeneration', CASE
      WHEN agm.slug IS NOT NULL OR bbo.slug IS NOT NULL THEN jsonb_build_object(
        'methodId', agm.slug,
        'backgroundBoostId', bbo.slug
      )
    END,
    'startingPackages', CASE
      WHEN pc.class_starting_option IS NOT NULL OR pc.background_starting_option IS NOT NULL
      THEN jsonb_build_object(
        'classOption', pc.class_starting_option,
        'backgroundOption', pc.background_starting_option
      )
    END,
    'languageIds', langs.ids,
    'abilities', ab.scores,
    'skillProficiencies', sk.profs,
    'savingThrowProficiencies', sv.slugs,
    'feats', ft.list,
    'equipment', eq.list,
    'weaponMasteryWeaponIds', wm.ids,
    'expertise', ex.ids,
    'speciesChoices', so.choices,
    'classChoices', co.choices,
    'resources', res.map,
    'spellcasting', sc.doc,
    'hp', jsonb_build_object(
      'current', pc.hp_current,
      'max', pc.hp_max,
      'temp', pc.hp_temp
    ),
    'armorClass', jsonb_strip_nulls(jsonb_build_object(
      'total', pc.ac_total,
      'base', pc.ac_base,
      'dexBonus', pc.ac_dex_bonus,
      'shieldBonus', NULLIF(pc.ac_shield_bonus, 0),
      'fightingStyleBonus', NULLIF(pc.ac_fighting_style_bonus, 0),
      'otherBonus', NULLIF(pc.ac_other_bonus, 0)
    )),
    'passivePerception', pc.passive_perception,
    'notes', pc.notes
  ))
  FROM rpg.player_character pc
  JOIN rpg.phb_species sp ON sp.id = pc.species_id
  JOIN rpg.phb_background bg ON bg.id = pc.background_id
  JOIN rpg.phb_class cl ON cl.id = pc.class_id
  LEFT JOIN rpg.phb_subclass sb ON sb.id = pc.subclass_id
  LEFT JOIN rpg.phb_alignment al ON al.id = pc.alignment_id
  LEFT JOIN rpg.phb_ability_generation_method agm ON agm.id = pc.ability_method_id
  LEFT JOIN rpg.phb_background_boost_option bbo ON bbo.id = pc.background_boost_id
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_agg(l.slug ORDER BY l.slug), '[]'::jsonb) AS ids
    FROM rpg.player_character_language pcl
    JOIN rpg.phb_language l ON l.id = pcl.language_id
    WHERE pcl.character_id = pc.id
  ) langs ON TRUE
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_object_agg(a.slug, pca.score), '{}'::jsonb) AS scores
    FROM rpg.player_character_ability pca
    JOIN rpg.phb_ability a ON a.id = pca.ability_id
    WHERE pca.character_id = pc.id
  ) ab ON TRUE
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_agg(
      jsonb_build_object('skillId', s.slug, 'source', pcs.source)
      ORDER BY s.slug
    ), '[]'::jsonb) AS profs
    FROM rpg.player_character_skill pcs
    JOIN rpg.phb_skill s ON s.id = pcs.skill_id
    WHERE pcs.character_id = pc.id
  ) sk ON TRUE
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_agg(a.slug ORDER BY a.slug), '[]'::jsonb) AS slugs
    FROM rpg.player_character_saving_throw pst
    JOIN rpg.phb_ability a ON a.id = pst.ability_id
    WHERE pst.character_id = pc.id
  ) sv ON TRUE
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_agg(
      jsonb_build_object('featId', f.slug, 'source', pcf.source) || COALESCE(pcf.options, '{}'::jsonb)
      ORDER BY f.slug
    ), '[]'::jsonb) AS list
    FROM rpg.player_character_feat pcf
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id
    WHERE pcf.character_id = pc.id
  ) ft ON TRUE
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_agg(
      jsonb_build_object(
        'itemId', i.slug,
        'quantity', pce.quantity,
        'source', CASE pce.source
          WHEN 'class' THEN 'class-starting'
          WHEN 'background' THEN 'background-starting'
          WHEN 'purchase' THEN 'purchased'
          ELSE 'other'
        END,
        'equipped', pce.equipped,
        'slot', CASE pce.slot
          WHEN 'main_hand' THEN 'mainHand'
          WHEN 'off_hand' THEN 'offHand'
          ELSE pce.slot::text
        END
      ) ORDER BY pce.id
    ), '[]'::jsonb) AS list
    FROM rpg.player_character_equipment pce
    JOIN rpg.phb_item i ON i.id = pce.item_id
    WHERE pce.character_id = pc.id
  ) eq ON TRUE
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_agg(i.slug ORDER BY i.slug), '[]'::jsonb) AS ids
    FROM rpg.player_character_weapon_mastery pwm
    JOIN rpg.phb_weapon w ON w.item_id = pwm.weapon_id
    JOIN rpg.phb_item i ON i.id = w.item_id
    WHERE pwm.character_id = pc.id
  ) wm ON TRUE
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_agg(s.slug ORDER BY s.slug), '[]'::jsonb) AS ids
    FROM rpg.player_character_expertise pex
    JOIN rpg.phb_skill s ON s.id = pex.skill_id
    WHERE pex.character_id = pc.id
  ) ex ON TRUE
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_object_agg(
      pso.option_key,
      COALESCE(
        to_jsonb(pso.catalog_value_id),
        to_jsonb(sk.slug),
        to_jsonb(ab.slug),
        pso.json_value
      )
    ), '{}'::jsonb) AS choices
    FROM rpg.player_character_species_option pso
    LEFT JOIN rpg.phb_skill sk ON sk.id = pso.skill_id
    LEFT JOIN rpg.phb_ability ab ON ab.id = pso.ability_id
    WHERE pso.character_id = pc.id
  ) so ON TRUE
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_object_agg(
      pco.option_key,
      COALESCE(
        to_jsonb(pco.catalog_value_id),
        to_jsonb(fs.slug),
        to_jsonb(dt.slug),
        pco.json_value
      )
    ), '{}'::jsonb) AS choices
    FROM rpg.player_character_class_option pco
    LEFT JOIN rpg.phb_fighting_style fs ON fs.id = pco.fighting_style_id
    LEFT JOIN rpg.phb_druid_land_terrain dt ON dt.id = pco.terrain_id
    WHERE pco.character_id = pc.id
  ) co ON TRUE
  LEFT JOIN LATERAL (
    SELECT COALESCE(jsonb_object_agg(
      rd.slug,
      jsonb_build_object('max', pcr.max_value, 'remaining', pcr.remaining)
    ), '{}'::jsonb) AS map
    FROM rpg.player_character_resource pcr
    JOIN rpg.phb_resource_definition rd ON rd.id = pcr.resource_id
    WHERE pcr.character_id = pc.id
  ) res ON TRUE
  LEFT JOIN LATERAL (
    SELECT CASE
      WHEN cantrips.doc = '{}'::jsonb
        AND prepared.doc = '{}'::jsonb
        AND slots_max.doc = '{}'::jsonb
      THEN NULL
      ELSE jsonb_strip_nulls(jsonb_build_object(
        'cantrips', NULLIF(cantrips.doc, '{}'::jsonb),
        'prepared', NULLIF(prepared.doc, '{}'::jsonb),
        'slotsMax', NULLIF(slots_max.doc, '{}'::jsonb),
        'slotsUsed', NULLIF(slots_used.doc, '{}'::jsonb)
      ))
    END AS doc
    FROM (
      SELECT COALESCE((
        SELECT jsonb_object_agg(src_slug, spell_ids)
        FROM (
          SELECT ss.slug AS src_slug,
                 jsonb_agg(s.slug ORDER BY s.slug) AS spell_ids
          FROM rpg.player_character_spell_list psl
          JOIN rpg.phb_spell s ON s.id = psl.spell_id
          JOIN rpg.phb_spell_source ss ON ss.id = psl.source_id
          WHERE psl.character_id = pc.id
            AND psl.list_type = 'known'
            AND s.level = 0
          GROUP BY ss.slug
        ) c
      ), '{}'::jsonb) AS doc
    ) cantrips
    CROSS JOIN (
      SELECT COALESCE((
        SELECT jsonb_object_agg(src_slug, spell_ids)
        FROM (
          SELECT ss.slug AS src_slug,
                 jsonb_agg(s.slug ORDER BY s.slug) AS spell_ids
          FROM rpg.player_character_spell_list psl
          JOIN rpg.phb_spell s ON s.id = psl.spell_id
          JOIN rpg.phb_spell_source ss ON ss.id = psl.source_id
          WHERE psl.character_id = pc.id
            AND psl.list_type = 'prepared'
          GROUP BY ss.slug
        ) p
      ), '{}'::jsonb) AS doc
    ) prepared
    CROSS JOIN (
      SELECT COALESCE((
        SELECT jsonb_object_agg(pss.circle::text, pss.slots_max)
        FROM rpg.player_character_spell_slot pss
        WHERE pss.character_id = pc.id
      ), '{}'::jsonb) AS doc
    ) slots_max
    CROSS JOIN (
      SELECT COALESCE((
        SELECT jsonb_object_agg(pss.circle::text, pss.slots_used)
        FROM rpg.player_character_spell_slot pss
        WHERE pss.character_id = pc.id
      ), '{}'::jsonb) AS doc
    ) slots_used
  ) sc ON TRUE
  WHERE pc.id = p_id;
$$ LANGUAGE sql STABLE;

-- =============================================================================
-- VIEWS FICHAS
-- =============================================================================

CREATE OR REPLACE VIEW rpg.v_character_abilities AS
SELECT
  pc.id AS character_id,
  pc.name AS character_name,
  a.slug AS ability_slug,
  a.name AS ability_name,
  pca.score
FROM rpg.player_character_ability pca
JOIN rpg.player_character pc ON pc.id = pca.character_id
JOIN rpg.phb_ability a ON a.id = pca.ability_id;

CREATE OR REPLACE VIEW rpg.v_player_character_summary AS
SELECT
  pc.id,
  pc.name,
  pc.level,
  e.slug AS edition_slug,
  sp.slug AS species_slug,
  sp.name AS species_name,
  bg.slug AS background_slug,
  cl.slug AS class_slug,
  cl.name AS class_name,
  sb.slug AS subclass_slug,
  pc.hp_current,
  pc.hp_max,
  pc.ac_total,
  pc.passive_perception
FROM rpg.player_character pc
JOIN rpg.phb_edition e ON e.id = pc.edition_id
JOIN rpg.phb_species sp ON sp.id = pc.species_id
JOIN rpg.phb_background bg ON bg.id = pc.background_id
JOIN rpg.phb_class cl ON cl.id = pc.class_id
LEFT JOIN rpg.phb_subclass sb ON sb.id = pc.subclass_id;

CREATE OR REPLACE VIEW rpg.v_player_character_runtime AS
SELECT
  pc.id,
  pc.name,
  pc.level,
  pc.hp_current,
  pc.hp_max,
  pc.hp_temp,
  pc.ac_total,
  pc.ac_base,
  pc.ac_dex_bonus,
  pc.ac_shield_bonus,
  pc.ac_fighting_style_bonus,
  pc.ac_other_bonus,
  pc.passive_perception,
  cl.slug AS class_slug,
  sp.slug AS species_slug
FROM rpg.player_character pc
JOIN rpg.phb_class cl ON cl.id = pc.class_id
JOIN rpg.phb_species sp ON sp.id = pc.species_id;

CREATE OR REPLACE VIEW rpg.v_player_character_full AS
SELECT
  pc.id,
  pc.name,
  pc.level,
  e.slug AS edition_slug,
  sp.slug AS species_slug,
  bg.slug AS background_slug,
  cl.slug AS class_slug,
  sb.slug AS subclass_slug,
  al.slug AS alignment_slug,
  agm.slug AS ability_method_slug,
  bbo.slug AS background_boost_slug,
  pc.class_starting_option,
  pc.background_starting_option,
  pc.hp_current,
  pc.hp_max,
  pc.hp_temp,
  pc.ac_total,
  pc.ac_base,
  pc.ac_dex_bonus,
  pc.ac_shield_bonus,
  pc.ac_fighting_style_bonus,
  pc.ac_other_bonus,
  pc.passive_perception,
  pc.notes,
  rpg.character_document(pc.id) AS document
FROM rpg.player_character pc
JOIN rpg.phb_edition e ON e.id = pc.edition_id
JOIN rpg.phb_species sp ON sp.id = pc.species_id
JOIN rpg.phb_background bg ON bg.id = pc.background_id
JOIN rpg.phb_class cl ON cl.id = pc.class_id
LEFT JOIN rpg.phb_subclass sb ON sb.id = pc.subclass_id
LEFT JOIN rpg.phb_alignment al ON al.id = pc.alignment_id
LEFT JOIN rpg.phb_ability_generation_method agm ON agm.id = pc.ability_method_id
LEFT JOIN rpg.phb_background_boost_option bbo ON bbo.id = pc.background_boost_id;

CREATE OR REPLACE VIEW rpg.v_character_resources AS
SELECT
  pc.id AS character_id,
  pc.name AS character_name,
  rd.slug AS resource_slug,
  rd.name AS resource_name,
  pcr.max_value,
  pcr.remaining
FROM rpg.player_character_resource pcr
JOIN rpg.player_character pc ON pc.id = pcr.character_id
JOIN rpg.phb_resource_definition rd ON rd.id = pcr.resource_id;

CREATE OR REPLACE VIEW rpg.v_character_spells AS
SELECT
  pc.id AS character_id,
  pc.name AS character_name,
  ps.list_type,
  ss.slug AS source_slug,
  ss.label AS source_label,
  s.slug AS spell_slug,
  s.name AS spell_name,
  s.level AS spell_level
FROM rpg.player_character_spell_list ps
JOIN rpg.player_character pc ON pc.id = ps.character_id
JOIN rpg.phb_spell s ON s.id = ps.spell_id
JOIN rpg.phb_spell_source ss ON ss.id = ps.source_id;


COMMENT ON SCHEMA rpg IS 'D&D 5e PHB 2024 PT-BR — catálogo v4 (BIGINT + slug)';
COMMENT ON COLUMN rpg.phb_spell.slug IS 'Identificador canônico do JSON/API; imutável na prática';
