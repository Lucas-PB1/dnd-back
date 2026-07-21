-- Telecinético — atributo de conjuração explícito (deve coincidir com abilityIncrease / +1)

UPDATE rpg.phb_feat_option_def
SET label = 'Aumento de atributo (+1)'
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic')
  AND option_key = 'abilityIncrease';

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'),
    'castingAbility',
    'Atributo de conjuração (Mãos Mágicas)',
    'catalog',
    2
  )
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT feat_id, 'castingAbility', value_id, label, sort_order
FROM rpg.phb_feat_option_value
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic')
  AND option_key = 'abilityIncrease'
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;
