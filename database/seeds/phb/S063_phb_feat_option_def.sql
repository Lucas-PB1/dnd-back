-- Seed rpg.phb_feat_option_def — Magic Initiate e Skilled

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order, depends_on_option_key, spell_max_level)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'spellList', 'Lista de magias', 'catalog', 1, NULL, NULL),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'castingAbility', 'Atributo de conjuração', 'catalog', 2, NULL, NULL),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'cantrip1', 'Truque 1', 'spell', 3, 'spellList', 0),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'cantrip2', 'Truque 2', 'spell', 4, 'spellList', 0),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'magic-initiate'), 'firstLevelSpell', 'Magia de 1º círculo', 'spell', 5, 'spellList', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'), 'proficiency1', 'Proficiência 1', 'proficiency', 1, NULL, NULL),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'), 'proficiency2', 'Proficiência 2', 'proficiency', 2, NULL, NULL),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skilled'), 'proficiency3', 'Proficiência 3', 'proficiency', 3, NULL, NULL);
