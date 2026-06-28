-- Fase 5 — camada de fichas


-- =============================================================================
-- FICHAS — player_character (híbrido sheet JSONB + projeções)
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
  id                  TEXT PRIMARY KEY,
  name                TEXT NOT NULL,
  level               INTEGER NOT NULL CHECK (level BETWEEN 1 AND 20),
  edition_id          BIGINT NOT NULL REFERENCES rpg.phb_edition(id),
  species_id          BIGINT NOT NULL REFERENCES rpg.phb_species(id),
  background_id       BIGINT NOT NULL REFERENCES rpg.phb_background(id),
  class_id            BIGINT NOT NULL REFERENCES rpg.phb_class(id),
  subclass_id         BIGINT REFERENCES rpg.phb_subclass(id),
  alignment_id        BIGINT REFERENCES rpg.phb_alignment(id),
  ability_method_id   BIGINT REFERENCES rpg.phb_ability_generation_method(id),
  background_boost_id BIGINT REFERENCES rpg.phb_background_boost_option(id),
  hp_current          INTEGER NOT NULL DEFAULT 0 CHECK (hp_current >= 0),
  hp_max              INTEGER NOT NULL CHECK (hp_max >= 1),
  hp_temp             INTEGER NOT NULL DEFAULT 0 CHECK (hp_temp >= 0),
  ac_total            INTEGER NOT NULL CHECK (ac_total >= 0),
  ac_detail           JSONB,
  passive_perception  INTEGER,
  sheet               JSONB NOT NULL,
  ability_generation  JSONB,
  starting_packages   JSONB,
  notes               TEXT,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW()
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
CREATE INDEX idx_pc_sheet ON rpg.player_character USING gin (sheet jsonb_path_ops);
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
-- SYNC RUNTIME — projeções mutáveis ↔ sheet JSON
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
    COALESCE((ac_detail->>'fightingStyleBonus')::INTEGER, 0),
    COALESCE((ac_detail->>'otherBonus')::INTEGER, 0)
  INTO v_style_bonus, v_other_bonus
  FROM rpg.player_character
  WHERE id = p_character_id;

  v_total := v_base + v_dex_bonus + v_shield_bonus + v_style_bonus + v_other_bonus;

  UPDATE rpg.player_character
  SET
    ac_total = v_total,
    ac_detail = jsonb_build_object(
      'total', v_total,
      'base', v_base,
      'dexBonus', v_dex_bonus,
      'shieldBonus', v_shield_bonus,
      'fightingStyleBonus', v_style_bonus,
      'otherBonus', v_other_bonus
    )
  WHERE id = p_character_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION rpg.sync_sheet_runtime()
RETURNS TRIGGER AS $$
BEGIN
  IF rpg.skip_character_sync() THEN
    RETURN NEW;
  END IF;

  NEW.sheet := jsonb_set(NEW.sheet, '{hp,current}', to_jsonb(NEW.hp_current), true);
  NEW.sheet := jsonb_set(NEW.sheet, '{hp,max}', to_jsonb(NEW.hp_max), true);
  NEW.sheet := jsonb_set(NEW.sheet, '{hp,temp}', to_jsonb(NEW.hp_temp), true);
  NEW.sheet := jsonb_set(NEW.sheet, '{passivePerception}', to_jsonb(NEW.passive_perception), true);

  IF NEW.ac_detail IS NOT NULL THEN
    NEW.sheet := jsonb_set(NEW.sheet, '{armorClass}', NEW.ac_detail || jsonb_build_object('total', NEW.ac_total), true);
  ELSE
    NEW.sheet := jsonb_set(NEW.sheet, '{armorClass,total}', to_jsonb(NEW.ac_total), true);
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_sync_sheet_runtime
  BEFORE UPDATE OF hp_current, hp_max, hp_temp, ac_total, ac_detail, passive_perception
  ON rpg.player_character
  FOR EACH ROW EXECUTE FUNCTION rpg.sync_sheet_runtime();

CREATE OR REPLACE FUNCTION rpg.sync_sheet_resource()
RETURNS TRIGGER AS $$
BEGIN
  IF rpg.skip_character_sync() THEN
    RETURN NEW;
  END IF;

  UPDATE rpg.player_character pc
  SET sheet = jsonb_set(
    jsonb_set(
      pc.sheet,
      ARRAY['resources', rd.slug, 'remaining'],
      to_jsonb(NEW.remaining),
      true
    ),
    ARRAY['resources', rd.slug, 'max'],
    to_jsonb(NEW.max_value),
    true
  )
  FROM rpg.phb_resource_definition rd
  WHERE pc.id = NEW.character_id AND rd.id = NEW.resource_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_sync_sheet_resource
  AFTER UPDATE OF remaining, max_value ON rpg.player_character_resource
  FOR EACH ROW EXECUTE FUNCTION rpg.sync_sheet_resource();

CREATE OR REPLACE FUNCTION rpg.sync_sheet_spell_slot()
RETURNS TRIGGER AS $$
BEGIN
  IF rpg.skip_character_sync() THEN
    RETURN NEW;
  END IF;

  UPDATE rpg.player_character
  SET sheet = jsonb_set(
    jsonb_set(
      sheet,
      ARRAY['spellcasting', 'slotsUsed', NEW.circle::TEXT],
      to_jsonb(NEW.slots_used),
      true
    ),
    ARRAY['spellcasting', 'slotsMax', NEW.circle::TEXT],
    to_jsonb(NEW.slots_max),
    true
  )
  WHERE id = NEW.character_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_sync_sheet_spell_slot
  AFTER UPDATE OF slots_used, slots_max ON rpg.player_character_spell_slot
  FOR EACH ROW EXECUTE FUNCTION rpg.sync_sheet_spell_slot();

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

CREATE TRIGGER tr_recalc_ac_on_equipment
  AFTER INSERT OR UPDATE OF equipped, slot, item_id OR DELETE
  ON rpg.player_character_equipment
  FOR EACH ROW EXECUTE FUNCTION rpg.trg_recalculate_ac_on_equipment();

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

-- Estado de combate em tempo real — preferir esta view na UI (não ler sheet->hp/ac)
CREATE OR REPLACE VIEW rpg.v_player_character_runtime AS
SELECT
  pc.id,
  pc.name,
  pc.level,
  pc.hp_current,
  pc.hp_max,
  pc.hp_temp,
  pc.ac_total,
  pc.ac_detail,
  pc.passive_perception,
  cl.slug AS class_slug,
  sp.slug AS species_slug
FROM rpg.player_character pc
JOIN rpg.phb_class cl ON cl.id = pc.class_id
JOIN rpg.phb_species sp ON sp.id = pc.species_id;

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
