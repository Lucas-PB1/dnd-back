-- Seed rpg.phb_armor
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'padded'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light'), 11, '11 + modificador de Des', NULL, TRUE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'leather'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light'), 11, '11 + modificador de Des', NULL, FALSE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'studded-leather'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'light'), 12, '12 + modificador de Des', NULL, FALSE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'hide'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium'), 12, '12 + modificador de Des (máx. 2)', NULL, FALSE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'chain-shirt'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium'), 13, '13 + modificador de Des (máx. 2)', NULL, FALSE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'scale-mail'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium'), 14, '14 + Modificador de Des (máx. 2)', NULL, TRUE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'breastplate'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium'), 14, '14 + Modificador de Des (máx. 2)', NULL, FALSE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'half-plate'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'medium'), 15, '15 + Modificador de Des (máx. 2)', NULL, TRUE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'ring-mail'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy'), 14, '14', NULL, TRUE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'chain-mail'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy'), 16, '16', 13, TRUE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'splint'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy'), 17, '17', 15, TRUE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'plate'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'heavy'), 18, '18', 15, TRUE) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_armor (item_id, category_id, ac_base, ac_formula, strength_req, stealth_disadvantage) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'shield'), (SELECT id FROM rpg.phb_armor_category WHERE slug = 'shield'), NULL, '+2', NULL, FALSE) ON CONFLICT (item_id) DO NOTHING;
