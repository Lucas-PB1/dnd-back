-- Longships Northlands (Cap. 5) — itens de transporte alinhados a M003 (phb_vehicle_template).
-- Fonte: docs/source/northlands-cap5-extract.json (sem preço de tabela no livro;
-- custos aproximados vs. Navio Longo PHB 10.000 PO, por porte/tripulação).
-- Slugs = templates: drakkar, karvi, knarr, skeid, snekkja (+ trenó ogre-war-sled).

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
  (
    'karvi',
    'other'::rpg.item_type,
    'Karvi',
    '{"text":"5.000 PO"}'::jsonb,
    '—',
    'Menor longship de quilha rasa — rios e costa. Northlands Worldbook.',
    '{"kind":"large-vehicle","speed":"3 mph","crew":16,"passengers":4,"cargoTons":25,"ac":15,"hp":100,"damageThreshold":10,"source":"northlands-heroes"}'::jsonb
  ),
  (
    'knarr',
    'other'::rpg.item_type,
    'Knarr',
    '{"text":"8.000 PO"}'::jsonb,
    '—',
    'Longship de carga com quilha profunda (não serve em rios rasos). Northlands Worldbook.',
    '{"kind":"large-vehicle","speed":"2 mph","crew":10,"passengers":15,"cargoTons":50,"ac":15,"hp":200,"damageThreshold":10,"source":"northlands-heroes"}'::jsonb
  ),
  (
    'snekkja',
    'other'::rpg.item_type,
    'Snekkja',
    '{"text":"12.000 PO"}'::jsonb,
    '—',
    'Longship ágil de guerra/raide. Northlands Worldbook.',
    '{"kind":"large-vehicle","speed":"5 mph","crew":30,"passengers":10,"cargoTons":10,"ac":15,"hp":250,"damageThreshold":10,"source":"northlands-heroes"}'::jsonb
  ),
  (
    'skeid',
    'other'::rpg.item_type,
    'Skeid',
    '{"text":"15.000 PO"}'::jsonb,
    '—',
    'Longship de guerra com balista. Northlands Worldbook.',
    '{"kind":"large-vehicle","speed":"5 mph","crew":50,"passengers":30,"cargoTons":20,"ac":15,"hp":350,"damageThreshold":15,"source":"northlands-heroes"}'::jsonb
  ),
  (
    'drakkar',
    'other'::rpg.item_type,
    'Drakkar',
    '{"text":"30.000 PO"}'::jsonb,
    '—',
    'Maior longship (“navio-dragão”), encomenda de jarls. Northlands Worldbook.',
    '{"kind":"large-vehicle","speed":"4 mph","crew":80,"passengers":20,"cargoTons":60,"ac":15,"hp":400,"damageThreshold":20,"source":"northlands-heroes"}'::jsonb
  ),
  (
    'ogre-war-sled',
    'other'::rpg.item_type,
    'Trenó de Guerra Ogre',
    '{"text":"1.800 PO"}'::jsonb,
    '—',
    'Veículo terrestre puxado por dois worgs. Northlands Worldbook.',
    '{"kind":"drawn-vehicle","speed":"4 mph","crew":2,"ac":17,"hp":175,"damageThreshold":10,"source":"northlands-heroes"}'::jsonb
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties,
  item_type = EXCLUDED.item_type;
