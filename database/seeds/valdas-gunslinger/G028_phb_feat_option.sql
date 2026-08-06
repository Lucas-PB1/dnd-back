-- Opções de +1 de atributo dos talentos do Pistoleiro.

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'marksman-s-luck'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'marksman-s-luck'), 'abilityIncrease', 'destreza', 'Destreza', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'gun-mage-adept'), 'abilityIncrease', 'destreza', 'Destreza', 1)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;
