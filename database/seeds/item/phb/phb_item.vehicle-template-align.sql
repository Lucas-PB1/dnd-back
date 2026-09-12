-- Alinha properties de veículos boardable ao template SSOT (reaplicável).
-- Tipografia: barco-de-quilha (não quilla).

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES (
  'barco-de-quilha',
  'other'::rpg.item_type,
  'Barco de Quilha',
  '{"text":"3.000 PO"}'::jsonb,
  '—',
  'Veículo grande.',
  '{"kind":"large-vehicle","speed":"1 mph","crew":1,"passengers":6,"cargoTons":0.5,"ac":15,"hp":100,"damageThreshold":10}'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties;

UPDATE rpg.phb_item SET properties = v.props::jsonb
FROM (VALUES
  ('carruagem', '{"kind":"drawn-vehicle","crew":1,"passengers":4,"ac":15,"hp":100}'),
  ('carroca', '{"kind":"drawn-vehicle","crew":1,"passengers":2,"ac":15,"hp":75}'),
  ('carro-de-guerra', '{"kind":"drawn-vehicle","crew":1,"passengers":1,"ac":16,"hp":50}'),
  ('treno', '{"kind":"drawn-vehicle","crew":1,"passengers":3,"ac":15,"hp":80}'),
  ('vagao', '{"kind":"drawn-vehicle","crew":1,"passengers":8,"ac":15,"hp":120}')
) AS v(slug, props)
WHERE rpg.phb_item.slug = v.slug;
