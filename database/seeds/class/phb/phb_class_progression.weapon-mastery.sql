-- Seed rpg.phb_class_progression — classes marciais + cotas de maestria (PHB 2024)
-- Absorve D016: S033 só cobre conjuradores/meio-conjuradores; bárbaro/guerreiro/
-- monge/ladino precisam das 20 linhas de PB + weapon_mastery.

INSERT INTO rpg.phb_class_progression (
  class_id, level, proficiency_bonus, cantrips, prepared_spells, channel_divinity, weapon_mastery
)
SELECT
  c.id,
  lv.level,
  lv.proficiency_bonus,
  NULL,
  NULL,
  NULL,
  CASE
    WHEN c.slug = 'barbarian' AND lv.level BETWEEN 1 AND 3 THEN 2
    WHEN c.slug = 'barbarian' AND lv.level BETWEEN 4 AND 9 THEN 3
    WHEN c.slug = 'barbarian' AND lv.level >= 10 THEN 4
    WHEN c.slug = 'fighter' AND lv.level BETWEEN 1 AND 3 THEN 3
    WHEN c.slug = 'fighter' AND lv.level BETWEEN 4 AND 9 THEN 4
    WHEN c.slug = 'fighter' AND lv.level BETWEEN 10 AND 15 THEN 5
    WHEN c.slug = 'fighter' AND lv.level >= 16 THEN 6
    WHEN c.slug = 'rogue' THEN 2
    ELSE NULL
  END
FROM rpg.phb_class c
CROSS JOIN rpg.phb_character_level lv
WHERE c.slug IN ('barbarian', 'fighter', 'monk', 'rogue')
ON CONFLICT (class_id, level) DO UPDATE SET
  proficiency_bonus = EXCLUDED.proficiency_bonus,
  weapon_mastery = EXCLUDED.weapon_mastery;

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
  ELSE cp.weapon_mastery
END
FROM rpg.phb_class c
WHERE cp.class_id = c.id
  AND c.slug IN ('barbarian', 'fighter', 'paladin', 'ranger', 'rogue');
