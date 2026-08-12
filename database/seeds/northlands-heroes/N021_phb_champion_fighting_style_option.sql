-- Champion: estilos Northlands em additionalFightingStyle

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
  'additionalFightingStyle',
  'glima',
  'Glima',
  100
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
  'additionalFightingStyle',
  'raiders-rush',
  'Investida do Saqueador',
  101
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
  'additionalFightingStyle',
  'savagery',
  'Selvageria',
  102
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
  'additionalFightingStyle',
  'shield-wall',
  'Muralha de Escudos',
  103
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
  'additionalFightingStyle',
  'skirmisher',
  'Escaramuçador',
  104
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;

INSERT INTO rpg.phb_option_value (scope, owner_id, option_key, value_id, label, sort_order)
VALUES (
  'subclass'::rpg.option_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'champion'),
  'additionalFightingStyle',
  'underfoot',
  'Pelos Pés',
  105
)
ON CONFLICT (scope, owner_id, option_key, value_id) DO UPDATE SET
  label = EXCLUDED.label,
  sort_order = EXCLUDED.sort_order;
