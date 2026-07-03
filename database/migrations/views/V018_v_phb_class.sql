-- View rpg.v_phb_class

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
