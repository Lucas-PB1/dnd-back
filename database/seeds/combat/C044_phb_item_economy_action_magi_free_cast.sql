-- Cajado dos Magi: magias custo 0 → cast-item-free + spell_slug
UPDATE rpg.phb_class_economy_action AS a
SET
  table_action = 'cast-item-free',
  spell_slug = v.spell_slug,
  summary = COALESCE(a.summary, v.summary)
FROM (VALUES
  ('item-cajado-dos-magi-luz', 'luz', 'Conjurar Luz (sem carga)'),
  ('item-cajado-dos-magi-maos-magicas', 'maos-magicas', 'Conjurar Mãos Mágicas (sem carga)'),
  ('item-cajado-dos-magi-detectar-magia', 'detectar-magia', 'Conjurar Detectar Magia (sem carga)'),
  ('item-cajado-dos-magi-aumentar-reduzir', 'aumentar-reduzir', 'Conjurar Aumentar/Reduzir (sem carga)'),
  ('item-cajado-dos-magi-protecao-bem-mal', 'protecao-contra-o-bem-e-o-mal', 'Conjurar Proteção contra o Bem e o Mal (sem carga)'),
  ('item-cajado-dos-magi-tranca-arcana', 'tranca-arcana', 'Conjurar Tranca Arcana (sem carga)')
) AS v(action_id, spell_slug, summary)
WHERE a.action_id = v.action_id;
