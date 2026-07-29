-- Opções de +1 de atributo dos talentos Valda.
-- Sem isso o texto do benefício existe, mas applyFeatAbilityIncreases não aplica o ponto.

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'brutal-grip'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'field-commander'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'focused-critical'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'brutal-grip'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'field-commander'), 'abilityIncrease', 'carisma', 'Carisma', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'focused-critical'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'focused-critical'), 'abilityIncrease', 'destreza', 'Destreza', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'), 'abilityIncrease', 'forca', 'Força', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'iron-hero'), 'abilityIncrease', 'destreza', 'Destreza', 2)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;
