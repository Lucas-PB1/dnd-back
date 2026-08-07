-- Seed rpg.phb_option_* (scope = 'feat') — canônico (baseline)
-- Lote C: migrado para phb_option_def/value unificado
-- Idempotente após db:migrate (ON CONFLICT / UPDATE seguros)

-- --- D002_elemental_adept_feat_options.sql ---
-- Adepto Elemental — +1 INT/SAB/CAR e tipo de dano (Domínio Elemental)

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'Domínio Elemental (tipo de dano)', 'catalog', 2)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'acid', 'Ácido', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'lightning', 'Elétrico', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'cold', 'Gélido', 3),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'fire', 'Ígneo', 4),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'thunder', 'Trovejante', 5)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- --- D003_feat_ability_increase_bulk.sql ---
-- Dados canônicos de opções de talento — 53 talentos

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1
FROM rpg.phb_feat f
WHERE f.slug IN (
  'charger', 'observant', 'spell-sniper', 'athlete', 'actor', 'chef',
  'mounted-combatant', 'war-caster', 'ritual-caster', 'boon-of-fortitude',
  'boon-of-combat-prowess', 'boon-of-skill-proficiency', 'boon-of-spell-recall',
  'boon-of-recovery', 'boon-of-energy-resistance', 'boon-of-speed',
  'boon-of-dimensional-travel', 'boon-of-truesight', 'boon-of-irresistible-offense',
  'boon-of-fate', 'boon-of-the-night-spirit', 'defensive-duelist', 'poisoner',
  'crusher', 'dual-wielder', 'lightly-armored', 'moderately-armored',
  'heavily-armored', 'crossbow-expert', 'skill-expert', 'mage-slayer',
  'grappler', 'inspiring-leader', 'keen-mind', 'weapon-master',
  'medium-armor-master', 'heavy-armor-master', 'polearm-master',
  'great-weapon-master', 'shield-master', 'sharpshooter', 'piercer',
  'resilient', 'durable', 'sentinel', 'stealthy', 'slasher',
  'telekinetic', 'telepathic', 'shadow-touched', 'fey-touched',
  'martial-weapon-training', 'mobile'
)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- Ability increase values for each feat (compact form using CROSS JOIN)
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('forca', 'Força', 1),
  ('destreza', 'Destreza', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug IN ('charger', 'athlete', 'mounted-combatant', 'dual-wielder', 'lightly-armored', 'moderately-armored', 'mage-slayer', 'grappler', 'weapon-master', 'medium-armor-master', 'polearm-master', 'piercer', 'resilient', 'sentinel', 'slasher', 'martial-weapon-training')
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('inteligencia', 'Inteligência', 1),
  ('sabedoria', 'Sabedoria', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'observant'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('inteligencia', 'Inteligência', 1),
  ('sabedoria', 'Sabedoria', 2),
  ('carisma', 'Carisma', 3)
) AS v(value_id, label, sort_order)
WHERE f.slug IN ('spell-sniper', 'war-caster', 'ritual-caster', 'boon-of-spell-recall', 'telekinetic', 'telepathic', 'shadow-touched', 'fey-touched')
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'actor'), 'abilityIncrease', 'carisma', 'Carisma', 1)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('constituicao', 'Constituição', 1),
  ('sabedoria', 'Sabedoria', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'chef'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- All 6 abilities for boon feats
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('forca', 'Força', 1),
  ('destreza', 'Destreza', 2),
  ('constituicao', 'Constituição', 3),
  ('inteligencia', 'Inteligência', 4),
  ('sabedoria', 'Sabedoria', 5),
  ('carisma', 'Carisma', 6)
) AS v(value_id, label, sort_order)
WHERE f.slug IN ('boon-of-fortitude', 'boon-of-combat-prowess', 'boon-of-skill-proficiency', 'boon-of-recovery', 'boon-of-energy-resistance', 'boon-of-speed', 'boon-of-dimensional-travel', 'boon-of-truesight', 'boon-of-fate', 'boon-of-the-night-spirit', 'skill-expert', 'resilient')
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('forca', 'Força', 1),
  ('destreza', 'Destreza', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'boon-of-irresistible-offense'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'defensive-duelist'), 'abilityIncrease', 'destreza', 'Destreza', 1)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('destreza', 'Destreza', 1),
  ('inteligencia', 'Inteligência', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'poisoner'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('forca', 'Força', 1),
  ('constituicao', 'Constituição', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug IN ('crusher', 'heavily-armored', 'heavy-armor-master')
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'crossbow-expert'), 'abilityIncrease', 'destreza', 'Destreza', 1)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('sabedoria', 'Sabedoria', 1),
  ('carisma', 'Carisma', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'inspiring-leader'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'great-weapon-master'), 'abilityIncrease', 'forca', 'Força', 1)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'shield-master'), 'abilityIncrease', 'forca', 'Força', 1)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'sharpshooter'), 'abilityIncrease', 'destreza', 'Destreza', 1)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'durable'), 'abilityIncrease', 'constituicao', 'Constituição', 1)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'stealthy'), 'abilityIncrease', 'destreza', 'Destreza', 1)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, 'abilityIncrease', v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (VALUES
  ('destreza', 'Destreza', 1),
  ('constituicao', 'Constituição', 2)
) AS v(value_id, label, sort_order)
WHERE f.slug = 'mobile'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- --- D004_feat_extra_options.sql ---
-- Opções extras de talentos (além de abilityIncrease em D003)

-- Analítico — perícia do Observador Atento
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'Observador Atento (perícia)', 'catalog', 2)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'insight', 'Intuição', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'investigation', 'Investigação', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'perception', 'Percepção', 3)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Mente Aguçada — Conhecimento Vasto
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'Conhecimento Vasto (perícia)', 'catalog', 2)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'arcana', 'Arcanismo', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'history', 'História', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'investigation', 'Investigação', 3),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'nature', 'Natureza', 4),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'religion', 'Religião', 5)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Especialista em Perícia
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'newSkill', 'Proficiência em perícia', 'proficiency', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'expertiseSkill', 'Especialização (perícia proficiente)', 'proficiency', 3)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- Feérico / Sombrio — +1 atributo (D003) + magia bônus já em S057; ordenar ASI antes
UPDATE rpg.phb_option_def
SET sort_order = 3
WHERE scope = 'feat'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched')
  AND option_key = 'bonusSpell';

UPDATE rpg.phb_option_def
SET sort_order = 4
WHERE scope = 'feat'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched')
  AND option_key = 'castingAbility';

UPDATE rpg.phb_option_def
SET sort_order = 3
WHERE scope = 'feat'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched')
  AND option_key = 'bonusSpell';

UPDATE rpg.phb_option_def
SET sort_order = 4
WHERE scope = 'feat'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched')
  AND option_key = 'castingAbility';

-- Dádiva da Resistência à Energia — dois tipos de dano
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'resistanceType1', 'Resistência 1 (tipo de dano)', 'catalog', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'resistanceType2', 'Resistência 2 (tipo de dano)', 'catalog', 3)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, f.id, v.option_key, v.value_id, v.label, v.sort_order
FROM rpg.phb_feat f
CROSS JOIN (
  VALUES
    ('resistanceType1', 'acid', 'Ácido', 1),
    ('resistanceType1', 'lightning', 'Elétrico', 2),
    ('resistanceType1', 'cold', 'Gélido', 3),
    ('resistanceType1', 'fire', 'Ígneo', 4),
    ('resistanceType1', 'necrotic', 'Necrótico', 5),
    ('resistanceType1', 'psychic', 'Psíquico', 6),
    ('resistanceType1', 'radiant', 'Radiante', 7),
    ('resistanceType1', 'thunder', 'Trovejante', 8),
    ('resistanceType1', 'poison', 'Venenoso', 9),
    ('resistanceType2', 'acid', 'Ácido', 1),
    ('resistanceType2', 'lightning', 'Elétrico', 2),
    ('resistanceType2', 'cold', 'Gélido', 3),
    ('resistanceType2', 'fire', 'Ígneo', 4),
    ('resistanceType2', 'necrotic', 'Necrótico', 5),
    ('resistanceType2', 'psychic', 'Psíquico', 6),
    ('resistanceType2', 'radiant', 'Radiante', 7),
    ('resistanceType2', 'thunder', 'Trovejante', 8),
    ('resistanceType2', 'poison', 'Venenoso', 9)
) AS v(option_key, value_id, label, sort_order)
WHERE f.slug = 'boon-of-energy-resistance'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- Dádiva da Proficiência em Perícia — especialização
INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'), 'expertiseSkill', 'Especialização', 'proficiency', 3)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- --- D005_feat_artisan_musician_weapon_master.sql ---
-- Artesão, Músico, Mestre das Armas — opções de origem / nível 4

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'), 'artisanTool1', 'Ferramenta de artesão 1', 'proficiency', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'), 'artisanTool2', 'Ferramenta de artesão 2', 'proficiency', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'), 'artisanTool3', 'Ferramenta de artesão 3', 'proficiency', 3),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'musician'), 'musicalInstrument1', 'Instrumento musical 1', 'proficiency', 1),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'musician'), 'musicalInstrument2', 'Instrumento musical 2', 'proficiency', 2),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'musician'), 'musicalInstrument3', 'Instrumento musical 3', 'proficiency', 3),
  ('feat'::rpg.option_scope, (SELECT id FROM rpg.phb_feat WHERE slug = 'weapon-master'), 'masteryWeapon', 'Arma (propriedade de maestria)', 'catalog', 2)
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- Mestre das Armas — armas com masteryId no catálogo
INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT
  'feat'::rpg.option_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'weapon-master'),
  'masteryWeapon',
  i.slug,
  i.name,
  ROW_NUMBER() OVER (ORDER BY i.name)::int
FROM rpg.phb_item i
WHERE i.item_type = 'weapon'::rpg.item_type
  AND COALESCE(i.properties->>'masteryId', '') <> ''
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT
  'feat'::rpg.option_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'artisan'),
  v.option_key,
  i.slug,
  i.name,
  ROW_NUMBER() OVER (PARTITION BY v.option_key ORDER BY i.name)::int
FROM rpg.phb_item i
JOIN rpg.phb_tool t ON t.item_id = i.id
JOIN rpg.phb_tool_category c ON c.id = t.category_id
CROSS JOIN (
  VALUES ('artisanTool1'), ('artisanTool2'), ('artisanTool3')
) AS v(option_key)
WHERE c.slug = 'artisan'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT
  'feat'::rpg.option_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'musician'),
  v.option_key,
  i.slug,
  i.name,
  ROW_NUMBER() OVER (PARTITION BY v.option_key ORDER BY i.name)::int
FROM rpg.phb_item i
JOIN rpg.phb_tool t ON t.item_id = i.id
JOIN rpg.phb_tool_category c ON c.id = t.category_id
CROSS JOIN (
  VALUES
    ('musicalInstrument1'),
    ('musicalInstrument2'),
    ('musicalInstrument3')
) AS v(option_key)
WHERE c.slug = 'instrument'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- --- D006_ritual_caster_feat_options.sql ---
-- Conjurador Ritualista — magias ritual de 1º círculo (quantidade = BP no nível do personagem)

INSERT INTO rpg.phb_option_def (
  scope,
  owner_id,
  option_key,
  label,
  value_type,
  sort_order,
  spell_max_level,
  spell_ritual_only
)
SELECT
  'feat'::rpg.option_scope,
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
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

-- --- D007_telekinetic_casting_ability.sql ---
-- Telecinético — atributo de conjuração explícito (deve coincidir com abilityIncrease / +1)

UPDATE rpg.phb_option_def
SET label = 'Aumento de atributo (+1)'
WHERE scope = 'feat'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic')
  AND option_key = 'abilityIncrease';

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic'),
    'castingAbility',
    'Atributo de conjuração (Mãos Mágicas)',
    'catalog',
    2
  )
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, owner_id, 'castingAbility', value_id, label, sort_order
FROM rpg.phb_option_value
WHERE scope = 'feat'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'telekinetic')
  AND option_key = 'abilityIncrease'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- --- D008_telepathic_casting_ability.sql ---
-- Telepático — atributo de conjuração explícito (deve coincidir com abilityIncrease / +1)

UPDATE rpg.phb_option_def
SET label = 'Aumento de atributo (+1)'
WHERE scope = 'feat'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic')
  AND option_key = 'abilityIncrease';

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic'),
    'castingAbility',
    'Atributo de conjuração (Detectar Pensamentos)',
    'catalog',
    2
  )
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'feat'::rpg.option_scope, owner_id, 'castingAbility', value_id, label, sort_order
FROM rpg.phb_option_value
WHERE scope = 'feat'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'telepathic')
  AND option_key = 'abilityIncrease'
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- --- D009_ability_score_improvement_feat_options.sql ---
-- Aumento no Valor de Atributo (feat) — +2 em um ou +1 em dois atributos

INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, label, value_type, sort_order)
VALUES
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'distributionMode',
    'Distribuição',
    'catalog',
    1
  ),
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'primaryAbility',
    'Atributo principal',
    'ability',
    2
  ),
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'secondaryAbility',
    'Segundo atributo (+1)',
    'ability',
    3
  )
ON CONFLICT (scope, owner_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'distributionMode',
    'plus2',
    '+2 em um atributo',
    1
  ),
  (
    'feat'::rpg.option_scope,
    (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
    'distributionMode',
    'plus1plus1',
    '+1 em dois atributos',
    2
  )
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT
  'feat'::rpg.option_scope,
  (SELECT id FROM rpg.phb_feat WHERE slug = 'ability-score-improvement'),
  v.option_key,
  a.slug,
  a.name,
  ROW_NUMBER() OVER (PARTITION BY v.option_key ORDER BY a.slug)::int
FROM rpg.phb_ability a
CROSS JOIN (VALUES ('primaryAbility'), ('secondaryAbility')) AS v(option_key)
ON CONFLICT (scope, owner_id, option_key, value_id) DO NOTHING;

-- --- D010_resilient_feat_option_label.sql ---
-- Resiliente — rótulo da opção de atributo (regra: sem prof. em salvaguarda da classe)

UPDATE rpg.phb_option_def
SET label = 'Atributo (+1, sem proficiência em salvaguarda)'
WHERE scope = 'feat'::rpg.option_scope
  AND owner_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'resilient')
  AND option_key = 'abilityIncrease';
