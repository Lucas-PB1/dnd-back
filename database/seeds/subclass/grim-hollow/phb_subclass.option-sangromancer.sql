-- Sangromante: Especialista em Sangromancia — picks de grimório bônus (Cap. 7 tag [Sangromancia])

UPDATE rpg.phb_subclass_feature
SET feature_kind = 'spellbook_bonus'::rpg.subclass_feature_kind
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer')
  AND level = 3
  AND name = 'Especialista em Sangromancia';

INSERT INTO rpg.phb_option_def (
  scope, owner_id, option_key, label, unlock_level, value_type, spell_max_level, spell_school_slugs, sort_order
)
VALUES
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'), 'sangromancySavant1', 'Grimório Sangromancia 1', 3, 'spell'::rpg.option_value_type, 2, ARRAY['sangromancia']::text[], 1),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'), 'sangromancySavant2', 'Grimório Sangromancia 2', 3, 'spell'::rpg.option_value_type, 2, ARRAY['sangromancia']::text[], 2),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'), 'sangromancySavant3', 'Grimório Sangromancia 3', 5, 'spell'::rpg.option_value_type, 3, ARRAY['sangromancia']::text[], 3),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'), 'sangromancySavant4', 'Grimório Sangromancia 4', 7, 'spell'::rpg.option_value_type, 4, ARRAY['sangromancia']::text[], 4),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'), 'sangromancySavant5', 'Grimório Sangromancia 5', 9, 'spell'::rpg.option_value_type, 5, ARRAY['sangromancia']::text[], 5),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'), 'sangromancySavant6', 'Grimório Sangromancia 6', 11, 'spell'::rpg.option_value_type, 6, ARRAY['sangromancia']::text[], 6),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'), 'sangromancySavant7', 'Grimório Sangromancia 7', 13, 'spell'::rpg.option_value_type, 7, ARRAY['sangromancia']::text[], 7),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'), 'sangromancySavant8', 'Grimório Sangromancia 8', 15, 'spell'::rpg.option_value_type, 8, ARRAY['sangromancia']::text[], 8),
  ('subclass'::rpg.option_scope, (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'), 'sangromancySavant9', 'Grimório Sangromancia 9', 17, 'spell'::rpg.option_value_type, 9, ARRAY['sangromancia']::text[], 9)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  spell_max_level = EXCLUDED.spell_max_level,
  spell_school_slugs = EXCLUDED.spell_school_slugs,
  sort_order = EXCLUDED.sort_order;
