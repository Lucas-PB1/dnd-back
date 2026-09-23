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
      'minimumScore', clause.minimum_score
    )
    ORDER BY ability.sort_order
  ) AS items
  FROM rpg.phb_feat_requirement_clause clause
  JOIN rpg.phb_ability ability ON ability.id = clause.ability_id
  WHERE clause.feat_id = feat.id
    AND clause.clause_kind = 'ability'::rpg.feat_requirement_clause_kind
) ability_requirements ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(required.slug ORDER BY required.slug) AS items
  FROM rpg.phb_feat_requirement_clause clause
  JOIN rpg.phb_feat required ON required.id = clause.required_feat_id
  WHERE clause.feat_id = feat.id
    AND clause.clause_kind = 'feat'::rpg.feat_requirement_clause_kind
) required_feats ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(skill.slug ORDER BY skill.slug) AS items
  FROM rpg.phb_feat_requirement_clause clause
  JOIN rpg.phb_skill skill ON skill.id = clause.skill_id
  WHERE clause.feat_id = feat.id
    AND clause.clause_kind = 'skill'::rpg.feat_requirement_clause_kind
) required_skills ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(species.slug ORDER BY species.slug) AS items
  FROM rpg.phb_feat_requirement_clause clause
  JOIN rpg.phb_species species ON species.id = clause.species_id
  WHERE clause.feat_id = feat.id
    AND clause.clause_kind = 'species'::rpg.feat_requirement_clause_kind
) required_species ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(clause.proficiency_slug ORDER BY clause.proficiency_slug) AS items
  FROM rpg.phb_feat_requirement_clause clause
  WHERE clause.feat_id = feat.id
    AND clause.clause_kind = 'weapon_proficiency'::rpg.feat_requirement_clause_kind
) required_weapon_profs ON TRUE
LEFT JOIN LATERAL (
  SELECT jsonb_agg(
    jsonb_build_object(
      'featSlug', required.slug,
      'optionKey', clause.option_key,
      'valueId', clause.value_id
    )
    ORDER BY required.slug, clause.option_key, clause.value_id
  ) AS items
  FROM rpg.phb_feat_requirement_clause clause
  JOIN rpg.phb_feat required ON required.id = clause.required_feat_id
  WHERE clause.feat_id = feat.id
    AND clause.clause_kind = 'feat_option'::rpg.feat_requirement_clause_kind
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
