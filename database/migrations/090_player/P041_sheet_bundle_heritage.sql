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
