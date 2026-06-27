-- RPG PHB 2024 — PostgreSQL v4 (catálogo id BIGINT + slug)
-- Gerado por: npm run generate:sql-schema
-- Docs: .cursor/skills/rpg-database/docs/er-diagram.md
-- Personagens: fora do schema até redesign (fichas eram só teste)

DROP SCHEMA IF EXISTS rpg CASCADE;
CREATE SCHEMA rpg;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- =============================================================================
-- TIPOS ENUM
-- =============================================================================

CREATE TYPE rpg.item_type AS ENUM (
  'weapon','armor','gear','tool','focus','other'
);

CREATE TYPE rpg.resource_scope AS ENUM ('species','class');

CREATE TYPE rpg.spell_source_origin AS ENUM (
  'class','subclass','species','feat'
);

CREATE TYPE rpg.option_value_type AS ENUM (
  'catalog','skill','ability','fighting_style','terrain','skill_list','json'
);

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
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id)
);

CREATE TABLE rpg.phb_feat_benefit (
  id BIGSERIAL PRIMARY KEY,
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  sort_order INTEGER NOT NULL CHECK (sort_order >= 1),
  name TEXT,
  description TEXT NOT NULL,
  UNIQUE (feat_id, sort_order)
);

CREATE TABLE rpg.phb_spell (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  level INTEGER NOT NULL CHECK (level BETWEEN 0 AND 9),
  level_label TEXT NOT NULL,
  school TEXT NOT NULL,
  casting_time TEXT NOT NULL,
  range TEXT NOT NULL,
  components JSONB NOT NULL,
  duration TEXT NOT NULL,
  concentration BOOLEAN NOT NULL DEFAULT FALSE,
  ritual BOOLEAN NOT NULL DEFAULT FALSE,
  description TEXT NOT NULL,
  higher_levels TEXT,
  source_meta JSONB
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
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id)
);

CREATE TABLE rpg.phb_subclass (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  tagline TEXT,
  summary TEXT,
  description TEXT,
  prepared_spell_source_key TEXT,
  prepared_spells_by_level JSONB,
  prepared_spells_by_terrain JSONB,
  source_meta JSONB
);

CREATE TABLE rpg.phb_species (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  creature_type TEXT NOT NULL,
  size TEXT NOT NULL,
  speed TEXT NOT NULL,
  description TEXT NOT NULL,
  source_meta JSONB
);

CREATE TABLE rpg.phb_item (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  item_type rpg.item_type NOT NULL,
  name TEXT NOT NULL,
  cost JSONB,
  weight TEXT,
  description TEXT,
  properties JSONB
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
  tool_item_id BIGINT REFERENCES rpg.phb_item(id)
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
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id),
  species_id BIGINT REFERENCES rpg.phb_species(id),
  feat_id BIGINT REFERENCES rpg.phb_feat(id)
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
  subclass_id BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level >= 1),
  spell_id BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  terrain_slug TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (subclass_id, unlock_level, spell_id, terrain_slug)
);

CREATE TABLE rpg.phb_species_trait (
  id BIGSERIAL PRIMARY KEY,
  species_id BIGINT NOT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  trait_table JSONB,
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
  casting_type TEXT NOT NULL CHECK (casting_type IN ('full', 'half', 'pact', 'none')),
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

CREATE TABLE rpg.phb_weapon (
  item_id BIGINT PRIMARY KEY REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  category TEXT,
  damage TEXT,
  damage_type TEXT,
  property_ids TEXT[],
  mastery_id TEXT
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
  category TEXT,
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

CREATE TABLE rpg.phb_class_option_def (
  class_id BIGINT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  option_key TEXT NOT NULL,
  value_type rpg.option_value_type NOT NULL,
  PRIMARY KEY (class_id, option_key)
);

CREATE TABLE rpg.phb_class_option_value (
  class_id BIGINT NOT NULL,
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  label TEXT NOT NULL,
  PRIMARY KEY (class_id, option_key, value_id),
  FOREIGN KEY (class_id, option_key)
    REFERENCES rpg.phb_class_option_def(class_id, option_key) ON DELETE CASCADE
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
  s.name AS spell_name
FROM rpg.phb_class c
JOIN rpg.phb_spell_class sc ON sc.class_id = c.id
JOIN rpg.phb_spell s ON s.id = sc.spell_id;

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

-- =============================================================================
-- ÍNDICES
-- =============================================================================

CREATE INDEX idx_phb_feat_category ON rpg.phb_feat(category_id);
CREATE INDEX idx_phb_feat_source ON rpg.phb_feat(source_citation_id);
CREATE INDEX idx_phb_feat_benefit_feat ON rpg.phb_feat_benefit(feat_id);
CREATE INDEX idx_phb_spell_slug ON rpg.phb_spell(slug);
CREATE INDEX idx_phb_class_slug ON rpg.phb_class(slug);
CREATE INDEX idx_phb_item_slug ON rpg.phb_item(slug);
CREATE INDEX idx_spell_class ON rpg.phb_spell_class(class_id);
CREATE INDEX idx_spell_level ON rpg.phb_spell(level);
CREATE INDEX idx_phb_skill_ability ON rpg.phb_skill(ability_id);
CREATE INDEX idx_phb_class_hit_die ON rpg.phb_class(hit_die_id);
CREATE INDEX idx_phb_class_source ON rpg.phb_class(source_citation_id);
CREATE INDEX idx_phb_armor_category ON rpg.phb_armor(category_id);

COMMENT ON SCHEMA rpg IS 'D&D 5e PHB 2024 PT-BR — catálogo v4 (BIGINT + slug)';
COMMENT ON COLUMN rpg.phb_spell.slug IS 'Identificador canônico do JSON/API; imutável na prática';
