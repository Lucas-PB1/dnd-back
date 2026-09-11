-- Forward: fórmula Recuperar Fôlego + alwaysSpends second-wind / action-surge.

ALTER TYPE rpg.effect_amount_formula ADD VALUE IF NOT EXISTS 'dice_1d10_plus_level';

UPDATE rpg.phb_class_economy_action
SET always_spends_resource = true
WHERE action_id IN (
  'fighter-second-wind',
  'fighter-action-surge'
)
  AND always_spends_resource IS DISTINCT FROM true;
