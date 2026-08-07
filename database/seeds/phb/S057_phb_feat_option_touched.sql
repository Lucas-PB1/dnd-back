-- Fey Touched e Shadow Touched — opções internas
-- Lote C: migrado para phb_option_def/value

INSERT INTO rpg.phb_option_def (
  scope, owner_id, option_key, label, value_type, sort_order, depends_on_option_key, spell_max_level, spell_school_slugs
)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'castingAbility', 'Atributo de conjuração', 'catalog', 1, NULL, NULL, NULL),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'bonusSpell', 'Magia de 1º círculo', 'spell', 2, NULL, 1, ARRAY['adivinhacao', 'encantamento']),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'castingAbility', 'Atributo de conjuração', 'catalog', 1, NULL, NULL, NULL),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'bonusSpell', 'Magia de 1º círculo', 'spell', 2, NULL, 1, ARRAY['ilusao', 'necromancia'])
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'castingAbility', 'inteligencia', 'Inteligência', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'castingAbility', 'sabedoria', 'Sabedoria', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'castingAbility', 'carisma', 'Carisma', 3),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'castingAbility', 'inteligencia', 'Inteligência', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'castingAbility', 'sabedoria', 'Sabedoria', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'castingAbility', 'carisma', 'Carisma', 3)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;
