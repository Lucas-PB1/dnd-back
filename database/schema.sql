-- RPG PHB 2024 — PostgreSQL v3 (híbrido + relações tipadas)
-- Gerado por: npm run generate:sql-schema
-- Docs: .cursor/skills/rpg-database/docs/er-diagram.md
-- Classe única por personagem — sem multiclasse

CREATE SCHEMA IF NOT EXISTS rpg;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- =============================================================================
-- TIPOS ENUM
-- =============================================================================

DO $$ BEGIN CREATE TYPE rpg.ability_id AS ENUM (
  'forca','destreza','constituicao','inteligencia','sabedoria','carisma'
); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE rpg.skill_source AS ENUM (
  'background','class','species','feat','other'
); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE rpg.feat_source AS ENUM (
  'background','class','species','general','other'
); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE rpg.equipment_source AS ENUM (
  'class-starting','background-starting','purchased','other'
); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE rpg.equipment_slot AS ENUM (
  'armor','shield','mainHand','offHand','focus','other'
); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE rpg.spell_list_type AS ENUM ('cantrip','prepared');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE rpg.item_type AS ENUM (
  'weapon','armor','gear','tool','focus','other'
); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE rpg.resource_scope AS ENUM ('species','class');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE rpg.spell_source_origin AS ENUM (
  'class','subclass','species','feat'
); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE rpg.option_value_type AS ENUM (
  'catalog','skill','ability','fighting_style','terrain','skill_list','json'
); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- =============================================================================
-- EDIÇÃO / CATÁLOGO PHB
-- =============================================================================

CREATE TABLE IF NOT EXISTS rpg.phb_edition (
  id           TEXT PRIMARY KEY,
  label        TEXT NOT NULL,
  book         TEXT NOT NULL DEFAULT 'Livro do Jogador 2024',
  language     TEXT NOT NULL DEFAULT 'pt-BR',
  extracted_at TIMESTAMPTZ,
  notes        TEXT
);

INSERT INTO rpg.phb_edition (id, label, extracted_at)
VALUES ('phb-2024-pt', 'PHB 2024 PT-BR', NOW())
ON CONFLICT (id) DO NOTHING;

CREATE TABLE IF NOT EXISTS rpg.phb_alignment (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, abbreviation TEXT, description TEXT
);

CREATE TABLE IF NOT EXISTS rpg.phb_language (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, script TEXT,
  typical_speakers TEXT, is_rare BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS rpg.phb_skill (
  id TEXT PRIMARY KEY, name TEXT NOT NULL,
  ability_id rpg.ability_id NOT NULL, description TEXT
);

CREATE TABLE IF NOT EXISTS rpg.phb_fighting_style (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS rpg.phb_weapon_property (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS rpg.phb_feat (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, category TEXT NOT NULL,
  repeatable BOOLEAN NOT NULL DEFAULT FALSE, prerequisite TEXT,
  benefits JSONB, source_meta JSONB
);

CREATE TABLE IF NOT EXISTS rpg.phb_spell (
  id TEXT PRIMARY KEY, name TEXT NOT NULL,
  level INTEGER NOT NULL CHECK (level BETWEEN 0 AND 9),
  level_label TEXT NOT NULL, school TEXT NOT NULL,
  casting_time TEXT NOT NULL, range TEXT NOT NULL,
  components JSONB NOT NULL, duration TEXT NOT NULL,
  concentration BOOLEAN NOT NULL DEFAULT FALSE,
  ritual BOOLEAN NOT NULL DEFAULT FALSE,
  description TEXT NOT NULL, higher_levels TEXT, source_meta JSONB
);

CREATE TABLE IF NOT EXISTS rpg.phb_class (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, tagline TEXT, summary TEXT, description TEXT,
  primary_ability TEXT, primary_ability_id rpg.ability_id,
  hit_die TEXT NOT NULL, hit_points JSONB,
  saving_throw_ids rpg.ability_id[] NOT NULL,
  subclass_unlock_level INTEGER NOT NULL DEFAULT 3 CHECK (subclass_unlock_level >= 1),
  subclass_label TEXT, skill_choices JSONB, armor_training JSONB,
  weapon_proficiencies JSONB, starting_equipment JSONB, spellcasting JSONB, source_meta JSONB
);

CREATE TABLE IF NOT EXISTS rpg.phb_class_progression (
  class_id TEXT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  proficiency_bonus INTEGER NOT NULL CHECK (proficiency_bonus BETWEEN 2 AND 6),
  cantrips INTEGER CHECK (cantrips >= 0),
  prepared_spells INTEGER CHECK (prepared_spells >= 0),
  spell_slots JSONB, channel_divinity INTEGER CHECK (channel_divinity >= 0),
  PRIMARY KEY (class_id, level)
);

CREATE TABLE IF NOT EXISTS rpg.phb_class_feature (
  id BIGSERIAL PRIMARY KEY,
  class_id TEXT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  level INTEGER NOT NULL CHECK (level >= 1),
  name TEXT NOT NULL, description TEXT NOT NULL,
  UNIQUE (class_id, level, name)
);

CREATE TABLE IF NOT EXISTS rpg.phb_class_skill_pool (
  class_id TEXT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  skill_id TEXT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (class_id, skill_id)
);

CREATE TABLE IF NOT EXISTS rpg.phb_spell_class (
  spell_id TEXT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  class_id TEXT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  PRIMARY KEY (spell_id, class_id)
);

CREATE TABLE IF NOT EXISTS rpg.phb_subclass (
  id TEXT PRIMARY KEY,
  class_id TEXT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  name TEXT NOT NULL, tagline TEXT, summary TEXT, description TEXT,
  prepared_spell_source_key TEXT,
  prepared_spells_by_level JSONB, prepared_spells_by_terrain JSONB, source_meta JSONB
);

CREATE TABLE IF NOT EXISTS rpg.phb_subclass_prepared_spell (
  subclass_id TEXT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level >= 1),
  spell_id TEXT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  terrain_id TEXT NOT NULL DEFAULT '',
  PRIMARY KEY (subclass_id, unlock_level, spell_id, terrain_id)
);

CREATE TABLE IF NOT EXISTS rpg.phb_species (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, creature_type TEXT NOT NULL,
  size TEXT NOT NULL, speed TEXT NOT NULL, description TEXT NOT NULL, source_meta JSONB
);

CREATE TABLE IF NOT EXISTS rpg.phb_species_trait (
  id BIGSERIAL PRIMARY KEY,
  species_id TEXT NOT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  name TEXT NOT NULL, description TEXT NOT NULL, trait_table JSONB,
  UNIQUE (species_id, name)
);

CREATE TABLE IF NOT EXISTS rpg.phb_background (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, description TEXT,
  feat_id TEXT REFERENCES rpg.phb_feat(id),
  ability_options rpg.ability_id[], equipment JSONB, source_meta JSONB
);

CREATE TABLE IF NOT EXISTS rpg.phb_background_skill (
  background_id TEXT NOT NULL REFERENCES rpg.phb_background(id) ON DELETE CASCADE,
  skill_id TEXT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (background_id, skill_id)
);

CREATE TABLE IF NOT EXISTS rpg.phb_item (
  id TEXT PRIMARY KEY, item_type rpg.item_type NOT NULL, name TEXT NOT NULL,
  cost JSONB, weight TEXT, description TEXT, properties JSONB
);

CREATE TABLE IF NOT EXISTS rpg.phb_weapon (
  item_id TEXT PRIMARY KEY REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  category TEXT, damage TEXT, damage_type TEXT, property_ids TEXT[], mastery_id TEXT
);

CREATE TABLE IF NOT EXISTS rpg.phb_armor (
  item_id TEXT PRIMARY KEY REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  category TEXT NOT NULL, ac_base INTEGER CHECK (ac_base >= 0),
  ac_formula TEXT, strength_req INTEGER CHECK (strength_req >= 0),
  stealth_disadvantage BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS rpg.phb_tool (
  item_id TEXT PRIMARY KEY REFERENCES rpg.phb_item(id) ON DELETE CASCADE,
  category TEXT, use_description TEXT
);

CREATE TABLE IF NOT EXISTS rpg.phb_character_level (
  level INTEGER PRIMARY KEY CHECK (level BETWEEN 1 AND 20),
  proficiency_bonus INTEGER NOT NULL CHECK (proficiency_bonus BETWEEN 2 AND 6),
  xp_threshold INTEGER CHECK (xp_threshold >= 0)
);

-- =============================================================================
-- CATÁLOGO v3 — recursos, magias, opções, junctions
-- =============================================================================

CREATE TABLE IF NOT EXISTS rpg.phb_ability_generation_method (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS rpg.phb_background_boost_option (
  id TEXT PRIMARY KEY, label TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS rpg.phb_druid_land_terrain (
  id TEXT PRIMARY KEY, label TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS rpg.phb_resource_definition (
  id          TEXT PRIMARY KEY,
  name        TEXT NOT NULL,
  scope       rpg.resource_scope NOT NULL,
  species_id  TEXT REFERENCES rpg.phb_species(id),
  class_id    TEXT REFERENCES rpg.phb_class(id),
  min_level   INTEGER NOT NULL DEFAULT 1 CHECK (min_level BETWEEN 1 AND 20),
  CONSTRAINT prd_scope_fk CHECK (
    (scope = 'species' AND species_id IS NOT NULL AND class_id IS NULL) OR
    (scope = 'class' AND class_id IS NOT NULL AND species_id IS NULL)
  )
);

CREATE TABLE IF NOT EXISTS rpg.phb_spell_source (
  id           TEXT PRIMARY KEY,
  label        TEXT NOT NULL,
  origin_type  rpg.spell_source_origin NOT NULL,
  class_id     TEXT REFERENCES rpg.phb_class(id),
  subclass_id  TEXT REFERENCES rpg.phb_subclass(id),
  species_id   TEXT REFERENCES rpg.phb_species(id),
  feat_id      TEXT REFERENCES rpg.phb_feat(id)
);

CREATE TABLE IF NOT EXISTS rpg.phb_species_option_def (
  species_id  TEXT NOT NULL REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  option_key  TEXT NOT NULL,
  value_type  rpg.option_value_type NOT NULL,
  PRIMARY KEY (species_id, option_key)
);

CREATE TABLE IF NOT EXISTS rpg.phb_species_option_value (
  species_id  TEXT NOT NULL,
  option_key  TEXT NOT NULL,
  value_id    TEXT NOT NULL,
  label       TEXT NOT NULL,
  PRIMARY KEY (species_id, option_key, value_id),
  FOREIGN KEY (species_id, option_key)
    REFERENCES rpg.phb_species_option_def(species_id, option_key) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS rpg.phb_class_option_def (
  class_id    TEXT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  option_key  TEXT NOT NULL,
  value_type  rpg.option_value_type NOT NULL,
  PRIMARY KEY (class_id, option_key)
);

CREATE TABLE IF NOT EXISTS rpg.phb_class_option_value (
  class_id    TEXT NOT NULL,
  option_key  TEXT NOT NULL,
  value_id    TEXT NOT NULL,
  label       TEXT NOT NULL,
  PRIMARY KEY (class_id, option_key, value_id),
  FOREIGN KEY (class_id, option_key)
    REFERENCES rpg.phb_class_option_def(class_id, option_key) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS rpg.phb_weapon_property_link (
  weapon_id   TEXT NOT NULL REFERENCES rpg.phb_weapon(item_id) ON DELETE CASCADE,
  property_id TEXT NOT NULL REFERENCES rpg.phb_weapon_property(id) ON DELETE CASCADE,
  PRIMARY KEY (weapon_id, property_id)
);

CREATE TABLE IF NOT EXISTS rpg.phb_class_fighting_style (
  class_id          TEXT NOT NULL REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  fighting_style_id TEXT NOT NULL REFERENCES rpg.phb_fighting_style(id) ON DELETE CASCADE,
  PRIMARY KEY (class_id, fighting_style_id)
);

-- =============================================================================
-- FICHA — player_character (híbrido)
-- =============================================================================

CREATE TABLE IF NOT EXISTS rpg.player_character (
  id                  TEXT PRIMARY KEY CHECK (id ~ '^[a-z][a-z0-9-]*$'),
  name                TEXT NOT NULL,
  level               INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  edition_id          TEXT NOT NULL DEFAULT 'phb-2024-pt'
                        REFERENCES rpg.phb_edition(id),
  species_id          TEXT NOT NULL REFERENCES rpg.phb_species(id),
  background_id       TEXT NOT NULL REFERENCES rpg.phb_background(id),
  class_id            TEXT NOT NULL REFERENCES rpg.phb_class(id),
  subclass_id         TEXT REFERENCES rpg.phb_subclass(id),
  alignment_id        TEXT NOT NULL REFERENCES rpg.phb_alignment(id),
  ability_method_id   TEXT NOT NULL REFERENCES rpg.phb_ability_generation_method(id),
  background_boost_id TEXT REFERENCES rpg.phb_background_boost_option(id),
  ability_generation  JSONB NOT NULL,
  forca               INTEGER NOT NULL CHECK (forca BETWEEN 1 AND 30),
  destreza            INTEGER NOT NULL CHECK (destreza BETWEEN 1 AND 30),
  constituicao        INTEGER NOT NULL CHECK (constituicao BETWEEN 1 AND 30),
  inteligencia        INTEGER NOT NULL CHECK (inteligencia BETWEEN 1 AND 30),
  sabedoria           INTEGER NOT NULL CHECK (sabedoria BETWEEN 1 AND 30),
  carisma             INTEGER NOT NULL CHECK (carisma BETWEEN 1 AND 30),
  hp_current          INTEGER NOT NULL CHECK (hp_current >= 0),
  hp_max              INTEGER NOT NULL CHECK (hp_max >= 1),
  hp_temp             INTEGER NOT NULL DEFAULT 0 CHECK (hp_temp >= 0),
  ac_total            INTEGER NOT NULL CHECK (ac_total >= 0),
  ac_detail           JSONB,
  passive_perception  INTEGER CHECK (passive_perception >= 0),
  starting_packages   JSONB,
  sheet               JSONB NOT NULL,
  notes               TEXT,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT pc_hp_current_lte_max CHECK (hp_current <= hp_max + hp_temp)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_language (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  language_id  TEXT NOT NULL REFERENCES rpg.phb_language(id),
  PRIMARY KEY (character_id, language_id)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_skill (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  skill_id     TEXT NOT NULL REFERENCES rpg.phb_skill(id),
  source       rpg.skill_source NOT NULL,
  PRIMARY KEY (character_id, skill_id)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_saving_throw (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  ability_id   rpg.ability_id NOT NULL,
  PRIMARY KEY (character_id, ability_id)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_feat (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  feat_id      TEXT NOT NULL REFERENCES rpg.phb_feat(id),
  source       rpg.feat_source NOT NULL,
  options      JSONB,
  PRIMARY KEY (character_id, feat_id, source)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_equipment (
  id           BIGSERIAL PRIMARY KEY,
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  item_id      TEXT NOT NULL REFERENCES rpg.phb_item(id),
  quantity     INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  source       rpg.equipment_source NOT NULL,
  equipped     BOOLEAN NOT NULL DEFAULT FALSE,
  slot         rpg.equipment_slot
);

CREATE TABLE IF NOT EXISTS rpg.player_character_weapon_mastery (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  weapon_id    TEXT NOT NULL REFERENCES rpg.phb_weapon(item_id),
  PRIMARY KEY (character_id, weapon_id)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_expertise (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  skill_id     TEXT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (character_id, skill_id)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_spell_list (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  spell_id     TEXT NOT NULL REFERENCES rpg.phb_spell(id),
  list_type    rpg.spell_list_type NOT NULL,
  source_id    TEXT NOT NULL REFERENCES rpg.phb_spell_source(id),
  PRIMARY KEY (character_id, spell_id, list_type, source_id)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_spell_slot (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  circle       INTEGER NOT NULL CHECK (circle BETWEEN 1 AND 9),
  slots_max    INTEGER NOT NULL DEFAULT 0 CHECK (slots_max >= 0),
  slots_used   INTEGER NOT NULL DEFAULT 0 CHECK (slots_used >= 0),
  PRIMARY KEY (character_id, circle),
  CONSTRAINT pcs_slots_used_lte_max CHECK (slots_used <= slots_max)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_resource (
  character_id  TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  resource_id   TEXT NOT NULL REFERENCES rpg.phb_resource_definition(id),
  max_value     INTEGER NOT NULL CHECK (max_value >= 0),
  remaining     INTEGER NOT NULL CHECK (remaining >= 0),
  PRIMARY KEY (character_id, resource_id),
  CONSTRAINT pcr_remaining_lte_max CHECK (remaining <= max_value)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_species_option (
  character_id       TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  species_id         TEXT NOT NULL REFERENCES rpg.phb_species(id),
  option_key         TEXT NOT NULL,
  catalog_value_id   TEXT,
  skill_id           TEXT REFERENCES rpg.phb_skill(id),
  ability_id         rpg.ability_id,
  json_value         JSONB,
  PRIMARY KEY (character_id, option_key),
  FOREIGN KEY (species_id, option_key, catalog_value_id)
    REFERENCES rpg.phb_species_option_value(species_id, option_key, value_id),
  CONSTRAINT pso_has_value CHECK (
    num_nonnulls(catalog_value_id, skill_id, ability_id, json_value) >= 1
  )
);

CREATE TABLE IF NOT EXISTS rpg.player_character_class_option (
  character_id       TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  class_id           TEXT NOT NULL REFERENCES rpg.phb_class(id),
  option_key         TEXT NOT NULL,
  catalog_value_id   TEXT,
  fighting_style_id  TEXT REFERENCES rpg.phb_fighting_style(id),
  terrain_id         TEXT REFERENCES rpg.phb_druid_land_terrain(id),
  json_value         JSONB,
  PRIMARY KEY (character_id, option_key),
  FOREIGN KEY (class_id, option_key, catalog_value_id)
    REFERENCES rpg.phb_class_option_value(class_id, option_key, value_id),
  CONSTRAINT pco_has_value CHECK (
    num_nonnulls(catalog_value_id, fighting_style_id, terrain_id, json_value) >= 1
  )
);

-- =============================================================================
-- TRIGGER updated_at
-- =============================================================================

CREATE OR REPLACE FUNCTION rpg.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_player_character_updated ON rpg.player_character;
CREATE TRIGGER trg_player_character_updated
  BEFORE UPDATE ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

-- =============================================================================
-- INTEGRIDADE v3 — triggers
-- =============================================================================

CREATE OR REPLACE FUNCTION rpg.validate_pc_subclass()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.subclass_id IS NOT NULL THEN
    IF NOT EXISTS (
      SELECT 1 FROM rpg.phb_subclass sb
      WHERE sb.id = NEW.subclass_id AND sb.class_id = NEW.class_id
    ) THEN
      RAISE EXCEPTION 'subclasse % não pertence à classe %', NEW.subclass_id, NEW.class_id;
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rpg.validate_pc_subclass_level()
RETURNS TRIGGER AS $$
DECLARE
  unlock INTEGER;
BEGIN
  IF NEW.subclass_id IS NOT NULL THEN
    SELECT subclass_unlock_level INTO unlock FROM rpg.phb_class WHERE id = NEW.class_id;
    IF NEW.level < unlock THEN
      RAISE EXCEPTION 'nível % insuficiente para subclasse (desbloqueio %)', NEW.level, unlock;
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_pc_subclass ON rpg.player_character;
CREATE TRIGGER trg_pc_subclass
  BEFORE INSERT OR UPDATE OF subclass_id, class_id ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.validate_pc_subclass();

DROP TRIGGER IF EXISTS trg_pc_subclass_level ON rpg.player_character;
CREATE TRIGGER trg_pc_subclass_level
  BEFORE INSERT OR UPDATE OF subclass_id, class_id, level ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.validate_pc_subclass_level();

-- =============================================================================
-- VIEWS
-- =============================================================================

CREATE OR REPLACE VIEW rpg.v_spell_by_class AS
SELECT c.id AS class_id, c.name AS class_name, s.level AS spell_level,
       s.id AS spell_id, s.name AS spell_name
FROM rpg.phb_class c
JOIN rpg.phb_spell_class sc ON sc.class_id = c.id
JOIN rpg.phb_spell s ON s.id = sc.spell_id;

CREATE OR REPLACE VIEW rpg.v_player_character_summary AS
SELECT
  pc.id, pc.name, pc.level,
  sp.name AS species_name, cl.name AS class_name,
  sb.name AS subclass_name, bg.name AS background_name,
  pc.hp_current, pc.hp_max, pc.ac_total, pc.passive_perception,
  pc.species_id, pc.class_id, pc.subclass_id
FROM rpg.player_character pc
JOIN rpg.phb_species sp ON sp.id = pc.species_id
JOIN rpg.phb_class cl ON cl.id = pc.class_id
JOIN rpg.phb_background bg ON bg.id = pc.background_id
LEFT JOIN rpg.phb_subclass sb ON sb.id = pc.subclass_id;

CREATE OR REPLACE VIEW rpg.v_character_resources AS
SELECT
  pc.id AS character_id, pc.name AS character_name,
  rd.id AS resource_id, rd.name AS resource_name, rd.scope,
  pcr.max_value, pcr.remaining
FROM rpg.player_character pc
JOIN rpg.player_character_resource pcr ON pcr.character_id = pc.id
JOIN rpg.phb_resource_definition rd ON rd.id = pcr.resource_id;

CREATE OR REPLACE VIEW rpg.v_character_spells AS
SELECT
  pc.id AS character_id, pc.name AS character_name,
  ss.id AS source_id, ss.label AS source_label,
  psl.list_type, s.id AS spell_id, s.name AS spell_name, s.level AS spell_level
FROM rpg.player_character pc
JOIN rpg.player_character_spell_list psl ON psl.character_id = pc.id
JOIN rpg.phb_spell_source ss ON ss.id = psl.source_id
JOIN rpg.phb_spell s ON s.id = psl.spell_id;

-- =============================================================================
-- ÍNDICES
-- =============================================================================

CREATE INDEX IF NOT EXISTS idx_pc_species ON rpg.player_character(species_id);
CREATE INDEX IF NOT EXISTS idx_pc_class ON rpg.player_character(class_id);
CREATE INDEX IF NOT EXISTS idx_pc_level ON rpg.player_character(level);
CREATE INDEX IF NOT EXISTS idx_pc_sheet_gin ON rpg.player_character USING GIN (sheet jsonb_path_ops);
CREATE INDEX IF NOT EXISTS idx_pc_name_trgm ON rpg.player_character USING GIN (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_spell_class ON rpg.phb_spell_class(class_id);
CREATE INDEX IF NOT EXISTS idx_spell_level ON rpg.phb_spell(level);
CREATE INDEX IF NOT EXISTS idx_pc_spell_list ON rpg.player_character_spell_list(character_id);
CREATE INDEX IF NOT EXISTS idx_pc_resource ON rpg.player_character_resource(character_id);
CREATE INDEX IF NOT EXISTS idx_pc_spell_source ON rpg.player_character_spell_list(source_id);
CREATE INDEX IF NOT EXISTS idx_pc_resource_def ON rpg.player_character_resource(resource_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_pc_equip_one_slot
  ON rpg.player_character_equipment (character_id, slot)
  WHERE equipped = TRUE AND slot IS NOT NULL;

COMMENT ON SCHEMA rpg IS 'D&D 5e PHB 2024 PT-BR — PostgreSQL v3 híbrido';
COMMENT ON TABLE rpg.player_character IS 'Ficha: sheet JSONB canônico + projeções; classe única (sem multiclasse)';
COMMENT ON COLUMN rpg.player_character.sheet IS 'JSON idêntico a data/characters/{id}.json (round-trip)';

-- =============================================================================
-- SYNC sheet JSONB ↔ projeções (fase 4)
-- Incluído em database/schema.sql via generate-sql-schema.mjs
-- =============================================================================

CREATE OR REPLACE FUNCTION rpg.sync_skip() RETURNS boolean AS $$
  SELECT COALESCE(current_setting('rpg.skip_sync', true), '') = '1';
$$ LANGUAGE sql STABLE;

CREATE OR REPLACE FUNCTION rpg.sync_active() RETURNS boolean AS $$
  SELECT COALESCE(current_setting('rpg.syncing', true), '') = '1';
$$ LANGUAGE sql STABLE;

-- -----------------------------------------------------------------------------
-- sheet → colunas + filhas
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION rpg.apply_sheet_to_character(p_id TEXT)
RETURNS void AS $$
DECLARE
  s JSONB;
  ag JSONB;
  feat JSONB;
  opt_key TEXT;
  opt_val JSONB;
BEGIN
  IF rpg.sync_skip() OR rpg.sync_active() THEN RETURN; END IF;
  PERFORM set_config('rpg.syncing', '1', true);

  SELECT sheet INTO s FROM rpg.player_character WHERE id = p_id;
  IF s IS NULL THEN
    PERFORM set_config('rpg.syncing', '0', true);
    RETURN;
  END IF;

  ag := COALESCE(s->'abilityGeneration', '{}'::jsonb);

  UPDATE rpg.player_character SET
    name                = s->>'name',
    level               = (s->>'level')::integer,
    species_id          = s->>'speciesId',
    background_id       = s->>'backgroundId',
    class_id            = s->>'classId',
    subclass_id         = NULLIF(s->>'subclassId', ''),
    alignment_id        = s->>'alignmentId',
    ability_method_id   = ag->>'methodId',
    background_boost_id = NULLIF(ag->>'backgroundBoostId', ''),
    ability_generation  = ag,
    forca               = (s->'abilities'->>'forca')::integer,
    destreza            = (s->'abilities'->>'destreza')::integer,
    constituicao        = (s->'abilities'->>'constituicao')::integer,
    inteligencia        = (s->'abilities'->>'inteligencia')::integer,
    sabedoria           = (s->'abilities'->>'sabedoria')::integer,
    carisma             = (s->'abilities'->>'carisma')::integer,
    hp_current          = (s->'hp'->>'current')::integer,
    hp_max              = (s->'hp'->>'max')::integer,
    hp_temp             = COALESCE((s->'hp'->>'temp')::integer, 0),
    ac_total            = (s->'armorClass'->>'total')::integer,
    ac_detail           = s->'armorClass',
    passive_perception  = NULLIF(s->>'passivePerception', '')::integer,
    starting_packages   = s->'startingPackages'
  WHERE id = p_id;

  DELETE FROM rpg.player_character_language WHERE character_id = p_id;
  DELETE FROM rpg.player_character_skill WHERE character_id = p_id;
  DELETE FROM rpg.player_character_saving_throw WHERE character_id = p_id;
  DELETE FROM rpg.player_character_feat WHERE character_id = p_id;
  DELETE FROM rpg.player_character_equipment WHERE character_id = p_id;
  DELETE FROM rpg.player_character_weapon_mastery WHERE character_id = p_id;
  DELETE FROM rpg.player_character_expertise WHERE character_id = p_id;
  DELETE FROM rpg.player_character_spell_list WHERE character_id = p_id;
  DELETE FROM rpg.player_character_spell_slot WHERE character_id = p_id;
  DELETE FROM rpg.player_character_resource WHERE character_id = p_id;
  DELETE FROM rpg.player_character_species_option WHERE character_id = p_id;
  DELETE FROM rpg.player_character_class_option WHERE character_id = p_id;

  INSERT INTO rpg.player_character_language (character_id, language_id)
  SELECT p_id, jsonb_array_elements_text(COALESCE(s->'languageIds', '[]'::jsonb));

  INSERT INTO rpg.player_character_skill (character_id, skill_id, source)
  SELECT p_id, e->>'skillId', (e->>'source')::rpg.skill_source
  FROM jsonb_array_elements(COALESCE(s->'skillProficiencies', '[]'::jsonb)) AS e;

  INSERT INTO rpg.player_character_saving_throw (character_id, ability_id)
  SELECT p_id, (jsonb_array_elements_text(COALESCE(s->'savingThrowProficiencies', '[]'::jsonb)))::rpg.ability_id;

  INSERT INTO rpg.player_character_feat (character_id, feat_id, source, options)
  SELECT p_id, e->>'featId', (e->>'source')::rpg.feat_source,
         CASE WHEN (e - 'featId' - 'source') = '{}'::jsonb THEN NULL
              ELSE (e - 'featId' - 'source') END
  FROM jsonb_array_elements(COALESCE(s->'feats', '[]'::jsonb)) AS e;

  INSERT INTO rpg.player_character_equipment (character_id, item_id, quantity, source, equipped, slot)
  SELECT p_id, e->>'itemId', COALESCE((e->>'quantity')::integer, 1),
         (e->>'source')::rpg.equipment_source,
         COALESCE((e->>'equipped')::boolean, false),
         NULLIF(e->>'slot', '')::rpg.equipment_slot
  FROM jsonb_array_elements(COALESCE(s->'equipment', '[]'::jsonb)) AS e;

  INSERT INTO rpg.player_character_weapon_mastery (character_id, weapon_id)
  SELECT p_id, jsonb_array_elements_text(COALESCE(s->'weaponMasteryWeaponIds', '[]'::jsonb));

  INSERT INTO rpg.player_character_expertise (character_id, skill_id)
  SELECT p_id, jsonb_array_elements_text(COALESCE(s->'expertise', '[]'::jsonb));

  -- spellcasting: cantrips e prepared por source_id
  IF s ? 'spellcasting' THEN
    INSERT INTO rpg.player_character_spell_list (character_id, spell_id, list_type, source_id)
    SELECT p_id, spell_id, 'cantrip'::rpg.spell_list_type, src_key
    FROM (
      SELECT key AS src_key, jsonb_array_elements_text(value) AS spell_id
      FROM jsonb_each(COALESCE(s->'spellcasting'->'cantrips', '{}'::jsonb))
    ) q;

    INSERT INTO rpg.player_character_spell_list (character_id, spell_id, list_type, source_id)
    SELECT p_id, spell_id, 'prepared'::rpg.spell_list_type, src_key
    FROM (
      SELECT key AS src_key, jsonb_array_elements_text(value) AS spell_id
      FROM jsonb_each(COALESCE(s->'spellcasting'->'prepared', '{}'::jsonb))
    ) q;

    INSERT INTO rpg.player_character_spell_slot (character_id, circle, slots_max, slots_used)
    SELECT p_id, (key)::integer, (value)::integer,
           COALESCE((s->'spellcasting'->'slotsUsed'->>key)::integer, 0)
    FROM jsonb_each_text(COALESCE(s->'spellcasting'->'slotsMax', '{}'::jsonb));
  END IF;

  INSERT INTO rpg.player_character_resource (character_id, resource_id, max_value, remaining)
  SELECT p_id, key, (value->>'max')::integer, (value->>'remaining')::integer
  FROM jsonb_each(COALESCE(s->'resources', '{}'::jsonb));

  -- speciesChoices
  FOR opt_key, opt_val IN
    SELECT key, value FROM jsonb_each(COALESCE(s->'speciesChoices', '{}'::jsonb))
  LOOP
    IF opt_key LIKE '%SkillId' THEN
      INSERT INTO rpg.player_character_species_option
        (character_id, species_id, option_key, skill_id)
      VALUES (p_id, s->>'speciesId', opt_key, opt_val #>> '{}');
    ELSIF opt_key LIKE '%CastingAbilityId' THEN
      INSERT INTO rpg.player_character_species_option
        (character_id, species_id, option_key, ability_id)
      VALUES (p_id, s->>'speciesId', opt_key, (opt_val #>> '{}')::rpg.ability_id);
    ELSIF jsonb_typeof(opt_val) = 'array' THEN
      INSERT INTO rpg.player_character_species_option
        (character_id, species_id, option_key, json_value)
      VALUES (p_id, s->>'speciesId', opt_key, opt_val);
    ELSE
      INSERT INTO rpg.player_character_species_option
        (character_id, species_id, option_key, catalog_value_id)
      VALUES (p_id, s->>'speciesId', opt_key, opt_val #>> '{}');
    END IF;
  END LOOP;

  -- classChoices
  FOR opt_key, opt_val IN
    SELECT key, value FROM jsonb_each(COALESCE(s->'classChoices', '{}'::jsonb))
  LOOP
    IF opt_key = 'fightingStyleId' THEN
      INSERT INTO rpg.player_character_class_option
        (character_id, class_id, option_key, fighting_style_id)
      VALUES (p_id, s->>'classId', opt_key, opt_val #>> '{}');
    ELSIF opt_key = 'landTerrainId' THEN
      INSERT INTO rpg.player_character_class_option
        (character_id, class_id, option_key, terrain_id)
      VALUES (p_id, s->>'classId', opt_key, opt_val #>> '{}');
    ELSIF jsonb_typeof(opt_val) = 'array' THEN
      INSERT INTO rpg.player_character_class_option
        (character_id, class_id, option_key, json_value)
      VALUES (p_id, s->>'classId', opt_key, opt_val);
    ELSE
      INSERT INTO rpg.player_character_class_option
        (character_id, class_id, option_key, catalog_value_id)
      VALUES (p_id, s->>'classId', opt_key, opt_val #>> '{}');
    END IF;
  END LOOP;

  PERFORM set_config('rpg.syncing', '0', true);
END;
$$ LANGUAGE plpgsql;

-- -----------------------------------------------------------------------------
-- projeções → sheet JSONB
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION rpg.rebuild_sheet_from_projections(p_id TEXT)
RETURNS void AS $$
DECLARE
  pc RECORD;
  new_sheet JSONB;
  cantrips JSONB := '{}'::jsonb;
  prepared JSONB := '{}'::jsonb;
  slots_max JSONB := '{}'::jsonb;
  slots_used JSONB := '{}'::jsonb;
  resources JSONB := '{}'::jsonb;
  species_choices JSONB := '{}'::jsonb;
  class_choices JSONB := '{}'::jsonb;
  r RECORD;
  o RECORD;
BEGIN
  IF rpg.sync_skip() OR rpg.sync_active() THEN RETURN; END IF;
  PERFORM set_config('rpg.syncing', '1', true);

  SELECT * INTO pc FROM rpg.player_character WHERE id = p_id;
  IF NOT FOUND THEN
    PERFORM set_config('rpg.syncing', '0', true);
    RETURN;
  END IF;

  SELECT COALESCE(jsonb_object_agg(source_id, spells), '{}'::jsonb) INTO cantrips
  FROM (
    SELECT source_id, jsonb_agg(spell_id ORDER BY spell_id) AS spells
    FROM rpg.player_character_spell_list
    WHERE character_id = p_id AND list_type = 'cantrip'
    GROUP BY source_id
  ) q;

  SELECT COALESCE(jsonb_object_agg(source_id, spells), '{}'::jsonb) INTO prepared
  FROM (
    SELECT source_id, jsonb_agg(spell_id ORDER BY spell_id) AS spells
    FROM rpg.player_character_spell_list
    WHERE character_id = p_id AND list_type = 'prepared'
    GROUP BY source_id
  ) q;

  SELECT COALESCE(jsonb_object_agg(ss.circle::text, ss.slots_max), '{}'::jsonb),
         COALESCE(jsonb_object_agg(ss.circle::text, ss.slots_used), '{}'::jsonb)
  INTO slots_max, slots_used
  FROM rpg.player_character_spell_slot ss WHERE ss.character_id = p_id;

  SELECT COALESCE(jsonb_object_agg(resource_id,
    jsonb_build_object('max', max_value, 'remaining', remaining)), '{}'::jsonb)
  INTO resources
  FROM rpg.player_character_resource WHERE character_id = p_id;

  FOR o IN SELECT * FROM rpg.player_character_species_option WHERE character_id = p_id LOOP
    species_choices := species_choices || jsonb_build_object(
      o.option_key,
      CASE
        WHEN o.skill_id IS NOT NULL THEN to_jsonb(o.skill_id)
        WHEN o.ability_id IS NOT NULL THEN to_jsonb(o.ability_id::text)
        WHEN o.json_value IS NOT NULL THEN o.json_value
        ELSE to_jsonb(o.catalog_value_id)
      END
    );
  END LOOP;

  FOR o IN SELECT * FROM rpg.player_character_class_option WHERE character_id = p_id LOOP
    class_choices := class_choices || jsonb_build_object(
      o.option_key,
      CASE
        WHEN o.fighting_style_id IS NOT NULL THEN to_jsonb(o.fighting_style_id)
        WHEN o.terrain_id IS NOT NULL THEN to_jsonb(o.terrain_id)
        WHEN o.json_value IS NOT NULL THEN o.json_value
        ELSE to_jsonb(o.catalog_value_id)
      END
    );
  END LOOP;

  new_sheet := jsonb_build_object(
    'id', pc.id,
    'name', pc.name,
    'level', pc.level,
    'speciesId', pc.species_id,
    'backgroundId', pc.background_id,
    'classId', pc.class_id,
    'alignmentId', pc.alignment_id,
    'abilityGeneration', pc.ability_generation,
    'languageIds', COALESCE((
      SELECT jsonb_agg(language_id ORDER BY language_id)
      FROM rpg.player_character_language WHERE character_id = p_id
    ), '[]'::jsonb),
    'abilities', jsonb_build_object(
      'forca', pc.forca, 'destreza', pc.destreza, 'constituicao', pc.constituicao,
      'inteligencia', pc.inteligencia, 'sabedoria', pc.sabedoria, 'carisma', pc.carisma
    ),
    'skillProficiencies', COALESCE((
      SELECT jsonb_agg(jsonb_build_object('skillId', skill_id, 'source', source::text) ORDER BY skill_id)
      FROM rpg.player_character_skill WHERE character_id = p_id
    ), '[]'::jsonb),
    'savingThrowProficiencies', COALESCE((
      SELECT jsonb_agg(ability_id::text ORDER BY ability_id)
      FROM rpg.player_character_saving_throw WHERE character_id = p_id
    ), '[]'::jsonb),
    'feats', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object('featId', feat_id, 'source', source::text) || COALESCE(options, '{}'::jsonb)
        ORDER BY feat_id
      )
      FROM rpg.player_character_feat WHERE character_id = p_id
    ), '[]'::jsonb),
    'startingPackages', pc.starting_packages,
    'equipment', COALESCE((
      SELECT jsonb_agg(
        jsonb_strip_nulls(jsonb_build_object(
          'itemId', item_id, 'source', source::text, 'quantity', quantity,
          'equipped', equipped, 'slot', slot::text
        )) ORDER BY item_id
      )
      FROM rpg.player_character_equipment WHERE character_id = p_id
    ), '[]'::jsonb),
    'hp', jsonb_build_object('current', pc.hp_current, 'max', pc.hp_max, 'temp', pc.hp_temp),
    'armorClass', pc.ac_detail,
    'resources', resources,
    'passivePerception', pc.passive_perception,
    'weaponMasteryWeaponIds', COALESCE((
      SELECT jsonb_agg(weapon_id ORDER BY weapon_id)
      FROM rpg.player_character_weapon_mastery WHERE character_id = p_id
    ), '[]'::jsonb)
  );

  IF pc.subclass_id IS NOT NULL THEN
    new_sheet := new_sheet || jsonb_build_object('subclassId', pc.subclass_id);
  END IF;

  IF species_choices != '{}'::jsonb THEN
    new_sheet := new_sheet || jsonb_build_object('speciesChoices', species_choices);
  END IF;

  IF class_choices != '{}'::jsonb THEN
    new_sheet := new_sheet || jsonb_build_object('classChoices', class_choices);
  END IF;

  IF EXISTS (SELECT 1 FROM rpg.player_character_expertise WHERE character_id = p_id) THEN
    new_sheet := new_sheet || jsonb_build_object('expertise', (
      SELECT jsonb_agg(skill_id ORDER BY skill_id)
      FROM rpg.player_character_expertise WHERE character_id = p_id
    ));
  END IF;

  IF cantrips != '{}'::jsonb OR prepared != '{}'::jsonb OR slots_max != '{}'::jsonb THEN
    new_sheet := new_sheet || jsonb_build_object(
      'spellcasting', jsonb_strip_nulls(jsonb_build_object(
        'cantrips', NULLIF(cantrips, '{}'::jsonb),
        'prepared', NULLIF(prepared, '{}'::jsonb),
        'slotsMax', NULLIF(slots_max, '{}'::jsonb),
        'slotsUsed', NULLIF(slots_used, '{}'::jsonb)
      ))
    );
  END IF;

  UPDATE rpg.player_character SET sheet = new_sheet WHERE id = p_id;

  PERFORM set_config('rpg.syncing', '0', true);
END;
$$ LANGUAGE plpgsql;

-- -----------------------------------------------------------------------------
-- Triggers
-- -----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION rpg.trg_sheet_to_projections()
RETURNS TRIGGER AS $$
BEGIN
  IF rpg.sync_skip() OR rpg.sync_active() THEN RETURN NEW; END IF;
  IF TG_OP = 'INSERT' OR NEW.sheet IS DISTINCT FROM OLD.sheet THEN
    PERFORM rpg.apply_sheet_to_character(NEW.id);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rpg.trg_projections_to_sheet()
RETURNS TRIGGER AS $$
DECLARE
  cid TEXT;
BEGIN
  IF rpg.sync_skip() OR rpg.sync_active() THEN
    RETURN COALESCE(NEW, OLD);
  END IF;
  IF TG_TABLE_NAME = 'player_character' THEN
    cid := COALESCE(NEW.id, OLD.id);
  ELSE
    cid := COALESCE(NEW.character_id, OLD.character_id);
  END IF;
  IF cid IS NOT NULL THEN
    PERFORM rpg.rebuild_sheet_from_projections(cid);
  END IF;
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_pc_sheet_to_projections ON rpg.player_character;
CREATE TRIGGER trg_pc_sheet_to_projections
  AFTER INSERT OR UPDATE OF sheet ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.trg_sheet_to_projections();

DROP TRIGGER IF EXISTS trg_pc_cols_to_sheet ON rpg.player_character;
CREATE TRIGGER trg_pc_cols_to_sheet
  AFTER UPDATE OF name, level, species_id, background_id, class_id, subclass_id,
    alignment_id, ability_method_id, background_boost_id, ability_generation,
    forca, destreza, constituicao, inteligencia, sabedoria, carisma,
    hp_current, hp_max, hp_temp, ac_total, ac_detail, passive_perception,
    starting_packages
  ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.trg_projections_to_sheet();

-- Filhas → sheet
DO $$ DECLARE t TEXT; BEGIN
  FOREACH t IN ARRAY ARRAY[
    'player_character_language','player_character_skill','player_character_saving_throw',
    'player_character_feat','player_character_equipment','player_character_weapon_mastery',
    'player_character_expertise','player_character_spell_list','player_character_spell_slot',
    'player_character_resource','player_character_species_option','player_character_class_option'
  ] LOOP
    EXECUTE format('DROP TRIGGER IF EXISTS trg_%s_to_sheet ON rpg.%I', t, t);
    EXECUTE format(
      'CREATE TRIGGER trg_%s_to_sheet
       AFTER INSERT OR UPDATE OR DELETE ON rpg.%I
       FOR EACH ROW EXECUTE FUNCTION rpg.trg_projections_to_sheet()', t, t
    );
  END LOOP;
END $$;

COMMENT ON FUNCTION rpg.apply_sheet_to_character IS 'Projeta sheet JSONB em colunas e tabelas filhas';
COMMENT ON FUNCTION rpg.rebuild_sheet_from_projections IS 'Reconstrói sheet JSONB a partir das projeções';
