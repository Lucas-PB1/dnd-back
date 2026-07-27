-- Cotas de Maestria em Arma (PHB 2024) na progressão de classe

ALTER TABLE rpg.phb_class
  ADD COLUMN IF NOT EXISTS weapon_mastery_eligibility TEXT
    CHECK (
      weapon_mastery_eligibility IS NULL
      OR weapon_mastery_eligibility IN ('any', 'melee')
    );

ALTER TABLE rpg.phb_class_progression
  ADD COLUMN IF NOT EXISTS weapon_mastery INTEGER
    CHECK (weapon_mastery IS NULL OR weapon_mastery >= 0);

-- Elegibilidade por classe
UPDATE rpg.phb_class SET weapon_mastery_eligibility = 'melee' WHERE slug = 'barbarian';
UPDATE rpg.phb_class SET weapon_mastery_eligibility = 'any'
WHERE slug IN ('fighter', 'paladin', 'ranger', 'rogue');

-- Cotas por nível (coluna Maestria em Armas das tabelas de classe)
UPDATE rpg.phb_class_progression cp
SET weapon_mastery = CASE
  WHEN c.slug = 'barbarian' AND cp.level BETWEEN 1 AND 3 THEN 2
  WHEN c.slug = 'barbarian' AND cp.level BETWEEN 4 AND 9 THEN 3
  WHEN c.slug = 'barbarian' AND cp.level >= 10 THEN 4
  WHEN c.slug = 'fighter' AND cp.level BETWEEN 1 AND 3 THEN 3
  WHEN c.slug = 'fighter' AND cp.level BETWEEN 4 AND 9 THEN 4
  WHEN c.slug = 'fighter' AND cp.level BETWEEN 10 AND 15 THEN 5
  WHEN c.slug = 'fighter' AND cp.level >= 16 THEN 6
  WHEN c.slug IN ('paladin', 'ranger', 'rogue') THEN 2
  ELSE NULL
END
FROM rpg.phb_class c
WHERE cp.class_id = c.id
  AND c.slug IN ('barbarian', 'fighter', 'paladin', 'ranger', 'rogue');

-- View de progressão: CREATE OR REPLACE permite acrescentar coluna no fim
CREATE OR REPLACE VIEW rpg.v_phb_class_progression AS
SELECT
  c.slug AS class_slug,
  cp.level,
  cp.proficiency_bonus,
  cp.cantrips,
  cp.prepared_spells,
  cp.channel_divinity,
  cp.weapon_mastery
FROM rpg.phb_class_progression cp
JOIN rpg.phb_class c ON c.id = cp.class_id;

-- View de classe: DROP + CREATE (lista de colunas muda)
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
  hd.label AS hit_die,
  c.hp_level1_die_value,
  c.hp_fixed_per_level,
  c.skill_choice_count,
  c.skill_choice_from,
  c.weapon_mastery_eligibility,
  array_agg(pa.slug ORDER BY cpa.sort_order) AS primary_ability_slugs,
  sc.chapter AS source_chapter,
  e.slug AS edition_slug
FROM rpg.phb_class c
JOIN rpg.phb_hit_die hd ON hd.id = c.hit_die_id
LEFT JOIN rpg.phb_source_citation sc ON sc.id = c.source_citation_id
LEFT JOIN rpg.phb_edition e ON e.id = sc.edition_id
LEFT JOIN rpg.phb_class_primary_ability cpa ON cpa.class_id = c.id
LEFT JOIN rpg.phb_ability pa ON pa.id = cpa.ability_id
GROUP BY c.id, c.slug, c.name, c.tagline, c.summary, c.description,
  c.primary_ability_label, c.primary_ability_operator,
  hd.label, c.hp_level1_die_value, c.hp_fixed_per_level, c.skill_choice_count,
  c.skill_choice_from, c.weapon_mastery_eligibility, sc.chapter, e.slug;
