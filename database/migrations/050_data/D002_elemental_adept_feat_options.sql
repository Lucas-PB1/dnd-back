-- Adepto Elemental — +1 INT/SAB/CAR e tipo de dano (Domínio Elemental)

INSERT INTO rpg.phb_feat_option_def (feat_id, option_key, label, value_type, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'Aumento de atributo (+1)', 'ability', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'Domínio Elemental (tipo de dano)', 'catalog', 2)
ON CONFLICT (feat_id, option_key) DO NOTHING;

INSERT INTO rpg.phb_feat_option_value (feat_id, option_key, value_id, label, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'inteligencia', 'Inteligência', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'sabedoria', 'Sabedoria', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'abilityIncrease', 'carisma', 'Carisma', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'acid', 'Ácido', 1),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'lightning', 'Elétrico', 2),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'cold', 'Gélido', 3),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'fire', 'Ígneo', 4),
  ((SELECT id FROM rpg.phb_feat WHERE slug = 'elemental-adept'), 'damageType', 'thunder', 'Trovejante', 5)
ON CONFLICT (feat_id, option_key, value_id) DO NOTHING;
