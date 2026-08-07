-- Seed rpg.phb_option_value (scope = 'feat') — valores estáticos de Iniciado em Magia
-- Lote C: migrado de phb_feat_option_value

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'spellList', 'cleric', 'Clérigo', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'spellList', 'druid', 'Druida', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'spellList', 'wizard', 'Mago', 3),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'castingAbility', 'inteligencia', 'Inteligência', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'castingAbility', 'sabedoria', 'Sabedoria', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'castingAbility', 'carisma', 'Carisma', 3)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;
