-- Perícias dos antecedentes Eldritch Hunt

INSERT INTO rpg.phb_background_skill (background_id, skill_id)
VALUES
  ((SELECT id FROM rpg.phb_background WHERE slug = 'beast-hunter'), (SELECT id FROM rpg.phb_skill WHERE slug = 'athletics')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'beast-hunter'), (SELECT id FROM rpg.phb_skill WHERE slug = 'survival')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'inquisitor'), (SELECT id FROM rpg.phb_skill WHERE slug = 'religion')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'inquisitor'), (SELECT id FROM rpg.phb_skill WHERE slug = 'intimidation')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'marked-for-death'), (SELECT id FROM rpg.phb_skill WHERE slug = 'arcana')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'marked-for-death'), (SELECT id FROM rpg.phb_skill WHERE slug = 'survival'))
ON CONFLICT (background_id, skill_id) DO NOTHING;
