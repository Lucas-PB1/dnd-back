-- Perícias dos antecedentes Northlands

INSERT INTO rpg.phb_background_skill (background_id, skill_id)
VALUES
  ((SELECT id FROM rpg.phb_background WHERE slug = 'dancing-bear-guide'), (SELECT id FROM rpg.phb_skill WHERE slug = 'persuasion')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'dancing-bear-guide'), (SELECT id FROM rpg.phb_skill WHERE slug = 'survival')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'doomed'), (SELECT id FROM rpg.phb_skill WHERE slug = 'athletics')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'doomed'), (SELECT id FROM rpg.phb_skill WHERE slug = 'persuasion')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'former-captive'), (SELECT id FROM rpg.phb_skill WHERE slug = 'insight')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'former-captive'), (SELECT id FROM rpg.phb_skill WHERE slug = 'persuasion')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'ice-nomad'), (SELECT id FROM rpg.phb_skill WHERE slug = 'nature')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'ice-nomad'), (SELECT id FROM rpg.phb_skill WHERE slug = 'survival')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'northlands-reaver'), (SELECT id FROM rpg.phb_skill WHERE slug = 'athletics')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'northlands-reaver'), (SELECT id FROM rpg.phb_skill WHERE slug = 'survival')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'preordained-hero'), (SELECT id FROM rpg.phb_skill WHERE slug = 'athletics')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'preordained-hero'), (SELECT id FROM rpg.phb_skill WHERE slug = 'persuasion')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'seafarer'), (SELECT id FROM rpg.phb_skill WHERE slug = 'acrobatics')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'seafarer'), (SELECT id FROM rpg.phb_skill WHERE slug = 'athletics')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'seer'), (SELECT id FROM rpg.phb_skill WHERE slug = 'arcana')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'seer'), (SELECT id FROM rpg.phb_skill WHERE slug = 'religion')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'shipwright'), (SELECT id FROM rpg.phb_skill WHERE slug = 'acrobatics')),
  ((SELECT id FROM rpg.phb_background WHERE slug = 'shipwright'), (SELECT id FROM rpg.phb_skill WHERE slug = 'sleight-of-hand'))
ON CONFLICT (background_id, skill_id) DO NOTHING;
