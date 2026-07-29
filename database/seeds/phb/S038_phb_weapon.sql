-- Seed rpg.phb_weapon
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'dagger'), 'simple'::rpg.weapon_category, '1d4', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'nick')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'javelin'), 'simple'::rpg.weapon_category, '1d6', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'quarterstaff'), 'simple'::rpg.weapon_category, '1d6', 'Contundente', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'topple')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'club'), 'simple'::rpg.weapon_category, '1d4', 'Contundente', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'greatclub'), 'simple'::rpg.weapon_category, '1d8', 'Contundente', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'push')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'sickle'), 'simple'::rpg.weapon_category, '1d4', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'nick')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'spear'), 'simple'::rpg.weapon_category, '1d6', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'sap')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'mace'), 'simple'::rpg.weapon_category, '1d6', 'Contundente', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'sap')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'handaxe'), 'simple'::rpg.weapon_category, '1d6', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'light-hammer'), 'simple'::rpg.weapon_category, '1d4', 'Contundente', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'nick')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'shortbow'), 'simple'::rpg.weapon_category, '1d6', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'light-crossbow'), 'simple'::rpg.weapon_category, '1d8', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'dart'), 'simple'::rpg.weapon_category, '1d4', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'sling'), 'simple'::rpg.weapon_category, '1d4', 'Contundente', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'halberd'), 'martial'::rpg.weapon_category, '1d10', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'cleave')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'whip'), 'martial'::rpg.weapon_category, '1d4', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'scimitar'), 'martial'::rpg.weapon_category, '1d6', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'nick')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'shortsword'), 'martial'::rpg.weapon_category, '1d6', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'greatsword'), 'martial'::rpg.weapon_category, '2d6', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'graze')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'longsword'), 'martial'::rpg.weapon_category, '1d8', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'sap')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'glaive'), 'martial'::rpg.weapon_category, '1d10', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'graze')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'lance'), 'martial'::rpg.weapon_category, '1d10', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'topple')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'pike'), 'martial'::rpg.weapon_category, '1d10', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'push')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'morningstar'), 'martial'::rpg.weapon_category, '1d8', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'sap')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'battleaxe'), 'martial'::rpg.weapon_category, '1d8', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'topple')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'greataxe'), 'martial'::rpg.weapon_category, '1d12', 'Cortante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'cleave')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'maul'), 'martial'::rpg.weapon_category, '2d6', 'Contundente', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'topple')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'flail'), 'martial'::rpg.weapon_category, '1d8', 'Contundente', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'sap')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'warhammer'), 'martial'::rpg.weapon_category, '1d8', 'Contundente', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'push')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'war-pick'), 'martial'::rpg.weapon_category, '1d8', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'sap')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'rapier'), 'martial'::rpg.weapon_category, '1d8', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'trident'), 'martial'::rpg.weapon_category, '1d8', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'topple')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'longbow'), 'martial'::rpg.weapon_category, '1d8', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'hand-crossbow'), 'martial'::rpg.weapon_category, '1d6', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'heavy-crossbow'), 'martial'::rpg.weapon_category, '1d10', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'push')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'musket'), 'martial'::rpg.weapon_category, '1d12', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'slow')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'pistol'), 'martial'::rpg.weapon_category, '1d10', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')) ON CONFLICT (item_id) DO NOTHING;

INSERT INTO rpg.phb_weapon (item_id, category, damage, damage_type, mastery_id) VALUES ((SELECT id FROM rpg.phb_item WHERE slug = 'blowgun'), 'martial'::rpg.weapon_category, '1', 'Perfurante', (SELECT id FROM rpg.phb_weapon_mastery WHERE slug = 'vex')) ON CONFLICT (item_id) DO NOTHING;
