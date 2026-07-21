-- Conjurador Ritualista — magias ritual de 1º círculo (quantidade = BP no nível do personagem)

INSERT INTO rpg.phb_feat_option_def (
  feat_id,
  option_key,
  label,
  value_type,
  sort_order,
  spell_max_level,
  spell_ritual_only
)
SELECT
  f.id,
  v.option_key,
  v.label,
  'spell'::rpg.option_value_type,
  v.sort_order,
  1,
  TRUE
FROM rpg.phb_feat f
CROSS JOIN (
  VALUES
    ('ritualSpell1', 'Magia ritual 1', 2),
    ('ritualSpell2', 'Magia ritual 2', 3),
    ('ritualSpell3', 'Magia ritual 3', 4),
    ('ritualSpell4', 'Magia ritual 4', 5),
    ('ritualSpell5', 'Magia ritual 5', 6),
    ('ritualSpell6', 'Magia ritual 6', 7)
) AS v(option_key, label, sort_order)
WHERE f.slug = 'ritual-caster'
ON CONFLICT (feat_id, option_key) DO NOTHING;
