-- Seed rpg.phb_option_def (scope = 'feat') — Magic Initiate e Skilled
-- Lote C: migrado de phb_feat_option_def

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, depends_on_option_key, spell_max_level)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'spellList', 'Lista de magias', 'catalog', 1, NULL, NULL),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'castingAbility', 'Atributo de conjuração', 'catalog', 2, NULL, NULL),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'cantrip1', 'Truque 1', 'spell', 3, 'spellList', 0),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'cantrip2', 'Truque 2', 'spell', 4, 'spellList', 0),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'firstLevelSpell', 'Magia de 1º círculo', 'spell', 5, 'spellList', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'), 'proficiency1', 'Proficiência 1', 'proficiency', 1, NULL, NULL),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'), 'proficiency2', 'Proficiência 2', 'proficiency', 2, NULL, NULL),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'), 'proficiency3', 'Proficiência 3', 'proficiency', 3, NULL, NULL)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;
