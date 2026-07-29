-- Seed rpg.phb_weapon_property_link
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'dagger'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'finesse')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'dagger'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'thrown')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'dagger'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'javelin'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'thrown')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'quarterstaff'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'versatile')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'club'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'greatclub'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'sickle'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'spear'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'thrown')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'spear'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'versatile')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'handaxe'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'thrown')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'handaxe'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'light-hammer'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'thrown')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'light-hammer'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'shortbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'shortbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'light-crossbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'light-crossbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'light-crossbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'loading')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'dart'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'finesse')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'dart'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'thrown')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'sling'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'halberd'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'halberd'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reach')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'halberd'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'whip'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'finesse')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'whip'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reach')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'scimitar'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'finesse')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'scimitar'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'shortsword'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'finesse')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'shortsword'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'greatsword'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'greatsword'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'longsword'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'versatile')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'glaive'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'glaive'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reach')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'glaive'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'lance'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'lance'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reach')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'lance'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'pike'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'pike'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'reach')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'pike'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'battleaxe'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'versatile')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'greataxe'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'greataxe'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'maul'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'maul'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'warhammer'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'versatile')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'war-pick'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'versatile')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'rapier'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'finesse')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'trident'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'thrown')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'trident'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'versatile')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'longbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'longbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'longbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'hand-crossbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'light')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'hand-crossbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'hand-crossbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'loading')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'heavy-crossbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'heavy-crossbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'heavy-crossbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'heavy')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'heavy-crossbow'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'loading')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'musket'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'two-handed')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'musket'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'musket'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'loading')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'pistol'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'pistol'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'loading')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'blowgun'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'ammunition')) ON CONFLICT DO NOTHING;

INSERT INTO rpg.phb_weapon_property_link (weapon_id, property_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'blowgun'), (SELECT id FROM rpg.phb_weapon_property WHERE slug = 'loading')) ON CONFLICT DO NOTHING;
