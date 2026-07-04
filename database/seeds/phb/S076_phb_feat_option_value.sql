-- Seed rpg.phb_feat_option_value — valores estáticos de Iniciado em Magia

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'spellList', 'cleric', 'Clérigo', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'spellList', 'druid', 'Druida', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'spellList', 'wizard', 'Mago', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'castingAbility', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'castingAbility', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'castingAbility', 'carisma', 'Carisma', 3);
