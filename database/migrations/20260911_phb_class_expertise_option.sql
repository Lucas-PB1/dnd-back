-- Forward: option_def/value de Especialização por classe (SQL-first expertise slots)
-- Greenfield-safe: sem rows se phb_class ainda não foi seedado (dados também em seeds/).

INSERT INTO rpg.phb_option_def (
  scope, owner_id, option_key, label, unlock_level, value_type, sort_order
)
SELECT
  'class'::rpg.option_scope,
  c.id,
  v.option_key,
  v.label,
  v.unlock_level,
  'skill'::rpg.option_value_type,
  v.sort_order
FROM rpg.phb_class c
JOIN (
  VALUES
    ('rogue', 'expertiseSkill1', 'Especialização 1', 1, 10),
    ('rogue', 'expertiseSkill2', 'Especialização 2', 1, 11),
    ('rogue', 'expertiseSkill3', 'Especialização 3', 6, 12),
    ('rogue', 'expertiseSkill4', 'Especialização 4', 6, 13),
    ('bard', 'expertiseSkill1', 'Especialização 1', 2, 10),
    ('bard', 'expertiseSkill2', 'Especialização 2', 2, 11),
    ('bard', 'expertiseSkill3', 'Especialização 3', 9, 12),
    ('bard', 'expertiseSkill4', 'Especialização 4', 9, 13),
    ('ranger', 'expertiseSkill1', 'Especialização 1', 2, 10),
    ('ranger', 'expertiseSkill2', 'Especialização 2', 9, 11),
    ('ranger', 'expertiseSkill3', 'Especialização 3', 9, 12),
    ('wizard', 'expertiseSkill1', 'Especialização (erudição)', 2, 10)
) AS v(class_slug, option_key, label, unlock_level, sort_order)
  ON c.slug = v.class_slug
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
