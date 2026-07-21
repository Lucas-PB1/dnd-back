-- Aumento no Valor de Atributo (feat) — +2 em um ou +1 em dois atributos

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'distributionMode',
    'Distribuição',
    'catalog',
    1
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'primaryAbility',
    'Atributo principal',
    'ability',
    2
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'secondaryAbility',
    'Segundo atributo (+1)',
    'ability',
    3
  )
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'distributionMode',
    'plus2',
    '+2 em um atributo',
    1
  ),
  (
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'distributionMode',
    'plus1plus1',
    '+1 em dois atributos',
    2
  )
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT
  (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
  v.option_key,
  a.slug,
  a.name,
  ROW_NUMBER() OVER (PARTITION BY v.option_key ORDER BY a.slug)::int
FROM rpg.phb_ability a
CROSS JOIN (VALUES ('primaryAbility'), ('secondaryAbility')) AS v(option_key)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;
