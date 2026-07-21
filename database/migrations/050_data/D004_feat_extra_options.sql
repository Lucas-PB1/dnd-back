-- Opções extras de talentos (além de abilityIncrease em D003)

-- Analítico — perícia do Observador Atento
INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'Observador Atento (perícia)', 'catalog', 2)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'insight', 'Intuição', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'investigation', 'Investigação', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'observant'), 'attentiveSkill', 'perception', 'Percepção', 3)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- Mente Aguçada — Conhecimento Vasto
INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'Conhecimento Vasto (perícia)', 'catalog', 2)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'arcana', 'Arcanismo', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'history', 'História', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'investigation', 'Investigação', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'nature', 'Natureza', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'keen-mind'), 'vastKnowledgeSkill', 'religion', 'Religião', 5)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- Especialista em Perícia
INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'newSkill', 'Proficiência em perícia', 'proficiency', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'skill-expert'), 'expertiseSkill', 'Especialização (perícia proficiente)', 'proficiency', 3)
ON CONFLICT (feat_id, option_key) DO NOTHING;

-- Feérico / Sombrio — +1 atributo (D003) + magia bônus já em S077; ordenar ASI antes
UPDATE rpg.phb_feat_option_def
SET sort_order = 3
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched')
  AND option_key = 'bonusSpell';

UPDATE rpg.phb_feat_option_def
SET sort_order = 4
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'fey-touched')
  AND option_key = 'castingAbility';

UPDATE rpg.phb_feat_option_def
SET sort_order = 3
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched')
  AND option_key = 'bonusSpell';

UPDATE rpg.phb_feat_option_def
SET sort_order = 4
WHERE feat_id = (SELECT id FROM rpg.phb_feat WHERE slug = 'shadow-touched')
  AND option_key = 'castingAbility';

-- Dádiva da Resistência à Energia — dois tipos de dano
INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'resistanceType1', 'Resistência 1 (tipo de dano)', 'catalog', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-energy-resistance'), 'resistanceType2', 'Resistência 2 (tipo de dano)', 'catalog', 3)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
SELECT f.id, v.option_key, v.value_id, v.label, v.sort_order
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
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;

-- Dádiva da Proficiência em Perícia — especialização
INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'boon-of-skill-proficiency'), 'expertiseSkill', 'Especialização', 'proficiency', 3)
ON CONFLICT (feat_id, option_key) DO NOTHING;
