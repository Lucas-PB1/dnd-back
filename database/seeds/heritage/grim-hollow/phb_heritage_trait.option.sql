INSERT INTO rpg.phb_option_def (scope, owner_id, option_key, value_type, label, sort_order)
SELECT 'heritage'::rpg.option_scope, ht.id, v.option_key, v.value_type::rpg.option_value_type, v.label, v.sort_order
FROM rpg.phb_heritage_trait ht
JOIN (VALUES
  ('damage-immunity', 'damageType', 'catalog', 'Tipo de dano', 1),
  ('potent-breath', 'damageType', 'catalog', 'Tipo de dano', 1),
  ('potent-breath', 'aoeShape', 'catalog', 'Área', 2),
  ('weapon-specialist', 'weapon1', 'catalog', 'Arma 1', 1),
  ('weapon-specialist', 'weapon2', 'catalog', 'Arma 2', 2),
  ('weapon-specialist', 'weapon3', 'catalog', 'Arma 3', 3),
  ('magical-savant', 'cantrip', 'spell', 'Truque', 1),
  ('focused-mastery', 'skill', 'skill', 'Perícia', 1),
  ('artisanal-expertise', 'artisanTool', 'catalog', 'Ferramenta de artesão', 1)
) AS v(trait_slug, option_key, value_type, label, sort_order)
  ON v.trait_slug = ht.slug
ON CONFLICT (scope, owner_id, option_key) DO UPDATE SET
  value_type = EXCLUDED.value_type,
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'heritage'::rpg.option_scope, ht.id, 'damageType', v.value_id, v.label, v.sort_order
FROM rpg.phb_heritage_trait ht
JOIN (VALUES
  (1, 'acid', 'Ácido'),
  (2, 'cold', 'Frio'),
  (3, 'fire', 'Fogo'),
  (4, 'lightning', 'Elétrico'),
  (5, 'poison', 'Veneno'),
  (6, 'thunder', 'Trovejante')
) AS v(sort_order, value_id, label) ON TRUE
WHERE ht.slug IN ('damage-immunity', 'potent-breath')
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'heritage'::rpg.option_scope, ht.id, 'aoeShape', v.value_id, v.label, v.sort_order
FROM rpg.phb_heritage_trait ht
JOIN (VALUES
  (1, 'line', 'Linha (1,5 m × 9 m)'),
  (2, 'cone', 'Cone (4,5 m)')
) AS v(sort_order, value_id, label) ON TRUE
WHERE ht.slug = 'potent-breath'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'heritage'::rpg.option_scope, ht.id, v.option_key, i.slug, i.name, row_number() OVER (PARTITION BY v.option_key ORDER BY i.name, i.slug)
FROM rpg.phb_heritage_trait ht
CROSS JOIN (VALUES ('weapon1'), ('weapon2'), ('weapon3')) AS v(option_key)
JOIN rpg.phb_weapon w ON TRUE
JOIN rpg.phb_item i ON i.id = w.item_id
WHERE ht.slug = 'weapon-specialist'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'heritage'::rpg.option_scope, ht.id, 'cantrip', s.slug, s.name, row_number() OVER (ORDER BY s.name, s.slug)
FROM rpg.phb_heritage_trait ht
JOIN rpg.phb_spell s ON s.level = 0
WHERE ht.slug = 'magical-savant'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'heritage'::rpg.option_scope, ht.id, 'skill', sk.slug, sk.name, row_number() OVER (ORDER BY sk.name, sk.slug)
FROM rpg.phb_heritage_trait ht
JOIN rpg.phb_skill sk ON TRUE
WHERE ht.slug = 'focused-mastery'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
SELECT 'heritage'::rpg.option_scope, ht.id, 'artisanTool', p.slug, p.name, row_number() OVER (ORDER BY p.name, p.slug)
FROM rpg.phb_heritage_trait ht
JOIN rpg.v_phb_tool_pool_item p ON p.pool = 'artisan'
WHERE ht.slug = 'artisanal-expertise'
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;
