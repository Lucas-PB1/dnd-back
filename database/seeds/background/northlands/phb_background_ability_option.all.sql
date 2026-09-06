-- Opções de atributo dos antecedentes Northlands

INSERT INTO rpg.phb_background_ability_option (background_id, ability_id, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_background WHERE slug = 'dancing-bear-guide'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'dancing-bear-guide'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'dancing-bear-guide'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 3),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'doomed'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'doomed'), (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'doomed'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 3),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'former-captive'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'former-captive'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'former-captive'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 3),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'ice-nomad'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'ice-nomad'), (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'ice-nomad'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 3),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'northlands-reaver'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'northlands-reaver'), (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'northlands-reaver'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 3),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'preordained-hero'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'preordained-hero'), (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'preordained-hero'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 3),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'seafarer'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'seafarer'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'seafarer'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 3),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'seer'), (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'seer'), (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'seer'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 3),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'shipwright'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'shipwright'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'shipwright'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 3)
ON CONFLICT (background_id, ability_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order;
