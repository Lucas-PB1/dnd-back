-- Seed rpg.phb_class weapon mastery eligibility

UPDATE rpg.phb_class
SET weapon_mastery_eligibility = 'melee'
WHERE slug = 'barbarian';

UPDATE rpg.phb_class
SET weapon_mastery_eligibility = 'any'
WHERE slug IN ('fighter', 'paladin', 'ranger', 'rogue');
