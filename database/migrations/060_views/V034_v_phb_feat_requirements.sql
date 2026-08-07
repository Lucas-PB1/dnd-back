-- Adiciona pré-requisitos estruturados à view de talentos.
-- Lote A: feat.category is now enum, joins VALUES view for labels

CREATE OR REPLACE VIEW rpg.v_phb_feat AS
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
  COALESCE(requirement.requires_fighting_style, FALSE) AS requires_fighting_style
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
  SELECT jsonb_agg(
    jsonb_strip_nulls(
      jsonb_build_object('name', benefit.name, 'description', benefit.description)
    )
    ORDER BY benefit.sort_order
  ) AS items
  FROM rpg.phb_feat_benefit benefit
  WHERE benefit.feat_id = feat.id
) benefits ON TRUE;
