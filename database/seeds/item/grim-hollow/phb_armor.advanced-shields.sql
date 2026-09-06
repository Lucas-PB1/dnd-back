-- Escudos avançados Grim Hollow (Cap. 5) — phb_armor

INSERT INTO rpg.phb_item (slug, item_type, name, cost, weight, description, properties)
VALUES
  ('buckler-grim-hollow', 'armor'::rpg.item_type, 'Broquel', '{"text":"20 PO"}'::jsonb, '2 kg', 'Este escudo pequeno é usado no antebraço. Enquanto estiver equipado, concede +1 na CA e pode ser usado como arma corpo a corpo Marcial com a propriedade Leve que causa 1d4 de dano Contundente.', '{"source":"grim-hollow","editionSlug":"grim-hollow-players-guide-2024-en","citationSlug":"grim-hollow-players-guide-2024-en:chapter-5-advanced-weapons-equipment","catalogKind":"armor-shield","ddbKind":"armor","advancedRequirement":{"kind":"shield","notesPt":"Usável por qualquer personagem proficiente em escudos."},"shieldVariant":"buckler","shieldProficiencySlug":"shield"}'::jsonb),
  ('retractable-shield', 'armor'::rpg.item_type, 'Escudo Retrátil', '{"text":"300 PO"}'::jsonb, '3 kg', 'Este escudo mecanizado retrai em uma braçadeira no antebraço. Com um movimento rápido, expande-se no instante em que o oponente acredita ter acertado um golpe surpresa. Você pode usar o Escudo Retrátil como braçadeira no antebraço; enquanto retraído, não conta como mão ocupada. Como Reação a um ataque que o acerte, você pode estender o escudo e ganhar bônus na CA igual ao seu Bônus de Proficiência contra esse ataque. Se isso transformar um acerto em erro, você pode fazer um ataque corpo a corpo com uma arma ou um Ataque Desarmado contra a criatura provocadora, se estiver ao alcance. O escudo permanece estendido até o início do seu próximo turno. Como interação livre com um objeto no seu turno, você pode estender ou retrair o escudo. Enquanto estendido, ocupa a mão e concede +2 na CA.', '{"source":"grim-hollow","editionSlug":"grim-hollow-players-guide-2024-en","citationSlug":"grim-hollow-players-guide-2024-en:chapter-5-advanced-weapons-equipment","catalogKind":"armor-shield","ddbKind":"armor","advancedRequirement":{"kind":"shield","notesPt":"Usável por qualquer personagem proficiente em escudos."},"shieldVariant":"retractable","shieldProficiencySlug":"shield"}'::jsonb),
  ('tower-shield-grim-hollow', 'armor'::rpg.item_type, 'Escudo Torre', '{"text":"200 PO"}'::jsonb, '25 kg', 'Este escudo grande oferece mais proteção que um escudo comum. Enquanto empunhar um Escudo Torre, você ganha +3 na CA. Se usar uma ação para firmar o Escudo Torre, você tem Cobertura de Três Quartos até o início do seu próximo turno. Além disso, seu Deslocamento torna-se 0 e não pode ser aumentado nesse período. Para empunhar um Escudo Torre, você precisa de Força 15 ou superior; seu Deslocamento é reduzido em 3 m enquanto empunhar o escudo.', '{"source":"grim-hollow","editionSlug":"grim-hollow-players-guide-2024-en","citationSlug":"grim-hollow-players-guide-2024-en:chapter-5-advanced-weapons-equipment","catalogKind":"armor-shield","ddbKind":"armor","advancedRequirement":{"kind":"shield","notesPt":"Usável por qualquer personagem proficiente em escudos."},"shieldVariant":"tower","shieldProficiencySlug":"shield","speedPenaltyM":3}'::jsonb)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  cost = EXCLUDED.cost,
  weight = EXCLUDED.weight,
  description = EXCLUDED.description,
  properties = EXCLUDED.properties,
  item_type = EXCLUDED.item_type;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage)
VALUES
  ((SELECT id FROM rpg.phb_item WHERE slug = 'buckler-grim-hollow'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield'), NULL, '+1', NULL, FALSE),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'retractable-shield'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield'), NULL, '+2', NULL, FALSE),
  ((SELECT id FROM rpg.phb_item WHERE slug = 'tower-shield-grim-hollow'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield'), NULL, '+3', 15, FALSE)
ON CONFLICT (item_id) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  ac_base = EXCLUDED.ac_base,
  ac_formula = EXCLUDED.ac_formula,
  strength_req = EXCLUDED.strength_req,
  stealth_disadvantage = EXCLUDED.stealth_disadvantage;
