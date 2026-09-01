-- Iniciado Sangromântico: escolha de magia de Sangromancia (Cap. 4)

INSERT INTO rpg.phb_option_def (
  scope,
  owner_id,
  option_key,
  label,
  value_type,
  sort_order,
  spell_max_level,
  spell_school_slugs
)
VALUES (
  'feat'::rpg.option_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'sangromantic-initiate'),
  'bloodMagicSpell',
  'Magia de Sangue',
  'spell'::rpg.option_value_type,
  1,
  NULL,
  ARRAY['sangromancia']::text[]
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order,
  spell_max_level = EXCLUDED.spell_max_level,
  spell_school_slugs = EXCLUDED.spell_school_slugs;
