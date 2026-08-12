-- Opções internas das Bênçãos de origem Northlands (casting + picks de magia/perícia/ferramenta)

-- —— castingAbility (INT/WIS/CHA) — bênçãos com conjuração ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'castingAbility', 'Atributo de conjuração', 'catalog', 1
FROM rpg.phb_feat f
WHERE f.slug IN (
  'blessing-of-baldur',
  'blessing-of-boreas',
  'blessing-of-freyr-and-freyja',
  'blessing-of-jormungandr',
  'blessing-of-loki',
  'blessing-of-sif',
  'blessing-of-thor',
  'blessing-of-volund',
  'blessing-of-wotan'
)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'castingAbility', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('inteligencia', 'Inteligência', 1),
  ('sabedoria', 'Sabedoria', 2),
  ('carisma', 'Carisma', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug IN (
  'blessing-of-baldur',
  'blessing-of-boreas',
  'blessing-of-freyr-and-freyja',
  'blessing-of-jormungandr',
  'blessing-of-loki',
  'blessing-of-sif',
  'blessing-of-thor',
  'blessing-of-volund',
  'blessing-of-wotan'
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Baldur: CHA fixo no texto — restringe castingAbility a Carisma
DELETE FROM rpg.phb_option_value
WHERE scope = 'feat'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-baldur')
  AND option_key = 'castingAbility'
  AND value_id <> 'carisma';

-- —— Boreas: L1 Armadura de Agathys | Faca de Gelo ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'), 'bonusSpell', 'Magia de inverno (1º)', 'catalog', 2)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'), 'bonusSpell', 'armadura-de-agathys', 'Armadura de Agathys', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-boreas'), 'bonusSpell', 'faca-de-gelo', 'Faca de Gelo', 2)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- —— Freyr: skill + L1 Enredar | Saraivada ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'), 'wildSkill', 'Conhecimento selvagem', 'catalog', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'), 'bonusSpell', 'Magia verde (1º)', 'catalog', 3)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'), 'wildSkill', 'animal-handling', 'Adestrar Animais', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'), 'wildSkill', 'nature', 'Natureza', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'), 'bonusSpell', 'emaranhar', 'Enredar', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-freyr-and-freyja'), 'bonusSpell', 'saraivada-de-espinhos', 'Saraivada de Espinhos', 2)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- —— Loki: L1 Disfarçar-se | Enfeitiçar Pessoa ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'), 'bonusSpell', 'Magia do trapaceiro (1º)', 'catalog', 2)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'), 'bonusSpell', 'disfarcar-se', 'Disfarçar-se', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-loki'), 'bonusSpell', 'enfeiticar-pessoa', 'Enfeitiçar Pessoa', 2)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- —— Sif: L1 Marca do Predador | Passos Longos ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'), 'bonusSpell', 'Proeza de Sif (1º)', 'catalog', 2)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'), 'bonusSpell', 'marca-do-predador', 'Marca do Predador', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-sif'), 'bonusSpell', 'passos-largos', 'Passos Longos', 2)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- —— Thor: cantrip Toque Chocante | Trovoada ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'), 'cantrip1', 'Truque da tempestade', 'catalog', 2)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'), 'cantrip1', 'toque-chocante', 'Toque Chocante', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-thor'), 'cantrip1', 'trovao', 'Trovoada', 2)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- —— Volund: ferramenta + L1 Mãos Flamejantes | Escudo ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'), 'artisanTool1', 'Ferramenta de artesão', 'proficiency', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'), 'bonusSpell', 'Magia da forja (1º)', 'catalog', 3)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'), 'bonusSpell', 'maos-flamejantes', 'Mãos Flamejantes', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-volund'), 'bonusSpell', 'escudo-arcano', 'Escudo', 2)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- —— Wotan: skill + qualquer L1 ——
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order, spell_max_level)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'), 'loreSkill', 'Amarrado ao saber', 'catalog', 2, NULL),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'), 'bonusSpell', 'Magia de 1º círculo', 'spell', 3, 1)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'), 'loreSkill', 'arcana', 'Arcanismo', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'), 'loreSkill', 'history', 'História', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'), 'loreSkill', 'nature', 'Natureza', 3),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'blessing-of-wotan'), 'loreSkill', 'religion', 'Religião', 4)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;
