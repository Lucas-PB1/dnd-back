-- Fey Touched e Shadow Touched — opções internas

INSERT INTO rpg.phb_feat_option_def (
  feat_id, option_key, label, value_type, sort_order, depends_on_option_key, spell_max_level, spell_school_slugs
)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'castingAbility', 'Atributo de conjuração', 'catalog', 1, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'bonusSpell', 'Magia de 1º círculo', 'spell', 2, NULL, 1, ARRAY['divination', 'enchantment']),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'castingAbility', 'Atributo de conjuração', 'catalog', 1, NULL, NULL, NULL),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'bonusSpell', 'Magia de 1º círculo', 'spell', 2, NULL, 1, ARRAY['illusion', 'necromancy']);

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'castingAbility', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'castingAbility', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched'), 'castingAbility', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'castingAbility', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'castingAbility', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched'), 'castingAbility', 'carisma', 'Carisma', 3);
