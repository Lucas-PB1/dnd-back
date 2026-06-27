-- RPG PHB 2024 — PostgreSQL v2 (híbrido)
-- Gerado por: npm run generate:sql-schema
-- Schema: rpg | Catálogo phb_* + player_character (sheet JSONB + projeções)
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
  id TEXT PRIMARY KEY, name TEXT NOT NULL, description TEXT NOT NULL, classes TEXT[]
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
  source_key   TEXT NOT NULL,
  PRIMARY KEY (character_id, spell_id, list_type, source_key)
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
  resource_key  TEXT NOT NULL,
  max_value     INTEGER NOT NULL CHECK (max_value >= 0),
  remaining     INTEGER NOT NULL CHECK (remaining >= 0),
  PRIMARY KEY (character_id, resource_key),
  CONSTRAINT pcr_remaining_lte_max CHECK (remaining <= max_value)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_species_option (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  option_key   TEXT NOT NULL,
  option_value TEXT NOT NULL,
  PRIMARY KEY (character_id, option_key)
);

CREATE TABLE IF NOT EXISTS rpg.player_character_class_option (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  option_key   TEXT NOT NULL,
  option_value TEXT NOT NULL,
  PRIMARY KEY (character_id, option_key)
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

COMMENT ON SCHEMA rpg IS 'D&D 5e PHB 2024 PT-BR — PostgreSQL v2 híbrido';
COMMENT ON TABLE rpg.player_character IS 'Ficha: sheet JSONB canônico + projeções; classe única (sem multiclasse)';
COMMENT ON COLUMN rpg.player_character.sheet IS 'JSON idêntico a data/characters/{id}.json (round-trip)';
