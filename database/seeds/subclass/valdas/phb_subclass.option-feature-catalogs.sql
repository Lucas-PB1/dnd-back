-- GEN-7: catálogos de feature → option_def/value
-- College of Masks / Beastborne / Dungeoneer (antes tabelas dedicadas).

-- —— Persona masks ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  'personaMask',
  'Máscaras de Persona',
  3,
  'catalog'::rpg.option_value_type,
  1
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT
  'subclass'::rpg.option_scope,
  s.id,
  'personaMask',
  v.value_id,
  v.label,
  v.sort_order
FROM rpg.phb_subclass s
CROSS JOIN (VALUES
  ('persona-mask-angel', 'Anjo', 1),
  ('persona-mask-archmage', 'Arquimago', 2),
  ('persona-mask-devil', 'Diabo', 3),
  ('persona-mask-dragon', 'Dragão', 4),
  ('persona-mask-faceless', 'Sem Rosto', 5),
  ('persona-mask-gladiator', 'Gladiador', 6),
  ('persona-mask-hierophant', 'Hierofante', 7),
  ('persona-mask-jester', 'Bobão', 8),
  ('persona-mask-noble', 'Nobre', 9)
) AS v(value_id, label, sort_order)
WHERE s.slug = 'college-of-masks'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

-- —— Beastborne aspect benefits ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'beastborne'),
  'bestialAspect',
  'Aspecto Bestial',
  3,
  'catalog'::rpg.option_value_type,
  1
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, benefit, sort_order)
SELECT
  'subclass'::rpg.option_scope,
  s.id,
  'bestialAspect',
  v.value_id,
  v.label,
  v.benefit,
  v.sort_order
FROM rpg.phb_subclass s
CROSS JOIN (VALUES
  ('1', 'Aspecto 1', 'Carnificina: +2 nas jogadas de dano com armas e Ataques Desarmados.', 1),
  ('2', 'Aspecto 2', 'Movimento Rápido: Deslocamento +3 m.', 2),
  ('3', 'Aspecto 3', 'Frenesi Sangrento: Vantagem em ataques contra criaturas sem PV cheios.', 3),
  ('4', 'Aspecto 4', 'Pele Espessa: +2 CA se não empunhar Escudo.', 4),
  ('5', 'Aspecto 5', 'Retaliação: Reação para atacar corpo a corpo quem causar dano a ≤1,5 m.', 5)
) AS v(value_id, label, benefit, sort_order)
WHERE s.slug = 'beastborne'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  benefit = EXCLUDED.benefit,
  sort_order = EXCLUDED.sort_order;

-- —— Dungeoneer slayer types ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, unlock_level, value_type, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'),
  'slayerType',
  'Tipo de Predador',
  3,
  'catalog'::rpg.option_value_type,
  1
)
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  label = EXCLUDED.label,
  unlock_level = EXCLUDED.unlock_level,
  value_type = EXCLUDED.value_type,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT
  'subclass'::rpg.option_scope,
  s.id,
  'slayerType',
  v.value_id,
  v.label,
  v.sort_order
FROM rpg.phb_subclass s
CROSS JOIN (VALUES
  ('aberration', 'Aberração', 1),
  ('dragon', 'Dragão', 2),
  ('fey', 'Feérico', 3),
  ('fiend', 'Corruptor', 4),
  ('monstrosity', 'Monstruosidade', 5),
  ('ooze', 'Gosma', 6),
  ('undead', 'Morto-vivo', 7)
) AS v(value_id, label, sort_order)
WHERE s.slug = 'dungeoneer'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;
