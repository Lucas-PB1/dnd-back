-- Subclass fighting style choices use value_type fighting_style (Champion L7, etc.)

UPDATE rpg.phb_subclass_option_def
SET value_type = 'fighting_style'::rpg.option_value_type
WHERE option_key = 'additionalFightingStyle'
   OR option_key = 'fighting_style'
   OR option_key LIKE '%FightingStyle';
