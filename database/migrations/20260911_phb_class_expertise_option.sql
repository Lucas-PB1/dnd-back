-- Forward: option_def/value de Especialização por classe (SQL-first expertise slots)

INSERT INTO rpg.phb_option_def (
  scope, owner_id, option_key, label, unlock_level, value_type, sort_order
)
VALUES
  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'expertiseSkill1', 'Especialização 1', 1, 'skill'::rpg.option_value_type, 10),
  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'expertiseSkill2', 'Especialização 2', 1, 'skill'::rpg.option_value_type, 11),
  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'expertiseSkill3', 'Especialização 3', 6, 'skill'::rpg.option_value_type, 12),
  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'expertiseSkill4', 'Especialização 4', 6, 'skill'::rpg.option_value_type, 13),

  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'expertiseSkill1', 'Especialização 1', 2, 'skill'::rpg.option_value_type, 10),
  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'expertiseSkill2', 'Especialização 2', 2, 'skill'::rpg.option_value_type, 11),
  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'expertiseSkill3', 'Especialização 3', 9, 'skill'::rpg.option_value_type, 12),
  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'expertiseSkill4', 'Especialização 4', 9, 'skill'::rpg.option_value_type, 13),

  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'expertiseSkill1', 'Especialização 1', 2, 'skill'::rpg.option_value_type, 10),
  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'expertiseSkill2', 'Especialização 2', 9, 'skill'::rpg.option_value_type, 11),
  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'expertiseSkill3', 'Especialização 3', 9, 'skill'::rpg.option_value_type, 12),

  ('class'::rpg.option_scope, (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'expertiseSkill1', 'Especialização (erudição)', 2, 'skill'::rpg.option_value_type, 10)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (
  scope, owner_id, option_key, value_id, label, sort_order
)
SELECT
  'class'::rpg.option_scope,
  c.id,
  'expertiseSkill1',
  s.slug,
  s.name,
  s.ord
FROM rpg.phb_class c
CROSS JOIN (
  VALUES
    ('arcana', 'Arcanismo', 1),
    ('history', 'História', 2),
    ('investigation', 'Investigação', 3),
    ('medicine', 'Medicina', 4),
    ('nature', 'Natureza', 5),
    ('religion', 'Religião', 6)
) AS s(slug, name, ord)
WHERE c.slug = 'wizard'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;
