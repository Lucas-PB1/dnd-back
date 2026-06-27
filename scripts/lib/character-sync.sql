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
