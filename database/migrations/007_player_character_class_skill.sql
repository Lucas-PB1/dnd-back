-- Fase 5.4 — opções de classe sem JSONB

-- Fase 5.4 — skillIds de class_option → tabela de junção

CREATE TABLE IF NOT EXISTS rpg.player_character_class_skill (
  character_id TEXT NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  skill_id     BIGINT NOT NULL REFERENCES rpg.phb_skill(id),
  PRIMARY KEY (character_id, skill_id)
);

INSERT INTO rpg.player_character_class_skill (character_id, skill_id)
SELECT pco.character_id, s.id
FROM rpg.player_character_class_option pco
CROSS JOIN LATERAL jsonb_array_elements_text(pco.json_value) AS elem(slug)
JOIN rpg.phb_skill s ON s.slug = elem.slug
WHERE pco.option_key = 'skillIds' AND pco.json_value IS NOT NULL
ON CONFLICT DO NOTHING;

DELETE FROM rpg.player_character_class_option WHERE option_key = 'skillIds';

ALTER TABLE rpg.player_character_class_option DROP COLUMN IF EXISTS json_value;

ALTER TABLE rpg.player_character_class_option
  DROP CONSTRAINT IF EXISTS pco_has_value;

ALTER TABLE rpg.player_character_class_option
  ADD CONSTRAINT pco_has_value CHECK (
    catalog_value_id IS NOT NULL OR fighting_style_id IS NOT NULL
    OR terrain_id IS NOT NULL
  );

DROP VIEW IF EXISTS rpg.v_player_character_full;

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
      jsonb_build_object('featId', f.slug, 'source', pcf.source)
      || CASE
        WHEN mi.character_id IS NOT NULL THEN jsonb_build_object(
          'magicInitiate', jsonb_build_object(
            'spellListClassId', mi_cl.slug,
            'castingAbilityId', mi_ab.slug,
            'cantripIds', mi_cantrips.ids,
            'preparedSpellId', mi_prep.slug
          )
        )
        ELSE '{}'::jsonb
      END
      ORDER BY f.slug
    ), '[]'::jsonb) AS list
    FROM rpg.player_character_feat pcf
    JOIN rpg.phb_feat f ON f.id = pcf.feat_id
    LEFT JOIN rpg.player_character_feat_magic_initiate mi
      ON mi.character_id = pcf.character_id
      AND mi.feat_id = pcf.feat_id
      AND mi.source = pcf.source
    LEFT JOIN rpg.phb_class mi_cl ON mi_cl.id = mi.spell_list_class_id
    LEFT JOIN rpg.phb_ability mi_ab ON mi_ab.id = mi.casting_ability_id
    LEFT JOIN LATERAL (
      SELECT COALESCE(jsonb_agg(s.slug ORDER BY s.slug), '[]'::jsonb) AS ids
      FROM rpg.player_character_spell_list psl
      JOIN rpg.phb_spell s ON s.id = psl.spell_id
      JOIN rpg.phb_spell_source ss ON ss.id = psl.source_id
      WHERE psl.character_id = pcf.character_id
        AND ss.slug = 'magic-initiate'
        AND psl.list_type = 'known'
        AND s.level = 0
    ) mi_cantrips ON mi.character_id IS NOT NULL
    LEFT JOIN LATERAL (
      SELECT s.slug
      FROM rpg.player_character_spell_list psl
      JOIN rpg.phb_spell s ON s.id = psl.spell_id
      JOIN rpg.phb_spell_source ss ON ss.id = psl.source_id
      WHERE psl.character_id = pcf.character_id
        AND ss.slug = 'magic-initiate'
        AND psl.list_type = 'prepared'
      ORDER BY s.slug
      LIMIT 1
    ) mi_prep ON mi.character_id IS NOT NULL
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
    SELECT COALESCE(opts.choices, '{}'::jsonb)
      || CASE
        WHEN sk.ids = '[]'::jsonb THEN '{}'::jsonb
        ELSE jsonb_build_object('skillIds', sk.ids)
      END AS choices
    FROM (
      SELECT COALESCE(jsonb_object_agg(
        pco.option_key,
        COALESCE(
          to_jsonb(pco.catalog_value_id),
          to_jsonb(fs.slug),
          to_jsonb(dt.slug)
        )
      ), '{}'::jsonb) AS choices
      FROM rpg.player_character_class_option pco
      LEFT JOIN rpg.phb_fighting_style fs ON fs.id = pco.fighting_style_id
      LEFT JOIN rpg.phb_druid_land_terrain dt ON dt.id = pco.terrain_id
      WHERE pco.character_id = pc.id
    ) opts
    CROSS JOIN (
      SELECT COALESCE(jsonb_agg(s.slug ORDER BY s.slug), '[]'::jsonb) AS ids
      FROM rpg.player_character_class_skill pcs
      JOIN rpg.phb_skill s ON s.id = pcs.skill_id
      WHERE pcs.character_id = pc.id
    ) sk
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

