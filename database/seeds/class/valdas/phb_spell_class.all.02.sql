-- Seed Gunslinger pack spell ↔ class

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
VALUES
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'antiballistics-field'), (SELECT id FROM rpg.phb_class WHERE slug = 'cleric')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'antiballistics-field'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'ballistic-smite'), (SELECT id FROM rpg.phb_class WHERE slug = 'paladin')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'concealed-shot'), (SELECT id FROM rpg.phb_class WHERE slug = 'bard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'concealed-shot'), (SELECT id FROM rpg.phb_class WHERE slug = 'druid')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'concealed-shot'), (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'concealed-shot'), (SELECT id FROM rpg.phb_class WHERE slug = 'warlock')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'concealed-shot'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'conjure-cannonball'), (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'conjure-cannonball'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'conjure-cover'), (SELECT id FROM rpg.phb_class WHERE slug = 'druid')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'conjure-cover'), (SELECT id FROM rpg.phb_class WHERE slug = 'paladin')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'conjure-cover'), (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'conjure-cover'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'jam-weapon'), (SELECT id FROM rpg.phb_class WHERE slug = 'bard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'jam-weapon'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'jethro-s-instant-reload'), (SELECT id FROM rpg.phb_class WHERE slug = 'bard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'jethro-s-instant-reload'), (SELECT id FROM rpg.phb_class WHERE slug = 'ranger')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'jethro-s-instant-reload'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'perforating-shot'), (SELECT id FROM rpg.phb_class WHERE slug = 'paladin')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'perforating-shot'), (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'))
ON CONFLICT DO NOTHING;
