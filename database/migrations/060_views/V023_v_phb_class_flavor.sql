-- View canônica rpg.v_phb_class (flavor + mastery eligibility)
-- Lote A: hit_die is now enum column, no join needed

DROP VIEW IF EXISTS rpg.v_phb_class;

CREATE VIEW rpg.v_phb_class AS
SELECT
  c.slug AS class_slug,
  c.name AS class_name,
  c.tagline,
  c.summary,
  c.description,
  c.primary_ability_label,
  c.primary_ability_operator,
  UPPER(c.hit_die::text) AS hit_die,
  c.hp_level1_die_value,
  c.hp_fixed_per_level,
  c.skill_choice_count,
  c.skill_choice_from,
  c.weapon_mastery_eligibility,
  array_agg(pa.slug ORDER BY cpa.sort_order) AS primary_ability_slugs,
  sc.chapter AS source_chapter,
  e.slug AS edition_slug
FROM rpg.phb_class c
LEFT JOIN rpg.phb_source_citation sc ON sc.id = c.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id
LEFT JOIN rpg.phb_class_proficiency cpa
  ON cpa.class_id = c.id AND cpa.kind = 'primary_ability'::rpg.class_proficiency_kind
LEFT JOIN rpg.phb_ability pa ON pa.id = cpa.ref_id
GROUP BY c.id, c.slug, c.name, c.tagline, c.summary, c.description,
  c.primary_ability_label, c.primary_ability_operator,
  c.hit_die, c.hp_level1_die_value, c.hp_fixed_per_level, c.skill_choice_count,
  c.skill_choice_from, c.weapon_mastery_eligibility, sc.chapter, e.slug;
