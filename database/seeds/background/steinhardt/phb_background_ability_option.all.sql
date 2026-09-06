-- Opções de atributo dos antecedentes Eldritch Hunt

INSERT INTO rpg.phb_background_ability_option (background_id, ability_id, sort_order)
VALUES
  ((SELECT id FROM rpg.phb_background WHERE slug = 'beast-hunter'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'beast-hunter'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'beast-hunter'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 3),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'inquisitor'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'inquisitor'), (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'inquisitor'), (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 3),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'marked-for-death'), (SELECT id FROM rpg.phb_ability WHERE slug = 'forca'), 1),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'marked-for-death'), (SELECT id FROM rpg.phb_ability WHERE slug = 'destreza'), 2),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'marked-for-death'), (SELECT id FROM rpg.phb_ability WHERE slug = 'constituicao'), 3)
ON CONFLICT (background_id, ability_id) DO UPDATE SET
  sort_order = EXCLUDED.sort_order;
