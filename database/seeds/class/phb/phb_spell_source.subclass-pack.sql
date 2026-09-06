-- Seed rpg.phb_spell_source
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('life-domain', (SELECT name FROM rpg.phb_subclass WHERE slug = 'life'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'life'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('light-domain', (SELECT name FROM rpg.phb_subclass WHERE slug = 'light'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'light'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('trickery-domain', (SELECT name FROM rpg.phb_subclass WHERE slug = 'trickery'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickery'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('war-domain', (SELECT name FROM rpg.phb_subclass WHERE slug = 'war'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'war'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('moon-circle', (SELECT name FROM rpg.phb_subclass WHERE slug = 'moon'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'moon'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('sea-circle', (SELECT name FROM rpg.phb_subclass WHERE slug = 'sea'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'sea'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('land-circle', (SELECT name FROM rpg.phb_subclass WHERE slug = 'land'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'druid'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'land'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('devotion-oath', (SELECT name FROM rpg.phb_subclass WHERE slug = 'devotion'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'devotion'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('ancients-oath', (SELECT name FROM rpg.phb_subclass WHERE slug = 'ancients'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'ancients'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('glory-oath', (SELECT name FROM rpg.phb_subclass WHERE slug = 'glory'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'glory'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('vengeance-oath', (SELECT name FROM rpg.phb_subclass WHERE slug = 'vengeance'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'paladin'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'vengeance'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('archfey-pact', (SELECT name FROM rpg.phb_subclass WHERE slug = 'archfey'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'archfey'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('fiend-pact', (SELECT name FROM rpg.phb_subclass WHERE slug = 'fiend'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'fiend'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('celestial-pact', (SELECT name FROM rpg.phb_subclass WHERE slug = 'celestial'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'celestial'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('great-old-one-pact', (SELECT name FROM rpg.phb_subclass WHERE slug = 'great-old-one'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'warlock'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'great-old-one'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('fey-wanderer-spells', (SELECT name FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'fey-wanderer'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('gloom-stalker-spells', (SELECT name FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'ranger'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'gloom-stalker'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('draconic-sorcery', (SELECT name FROM rpg.phb_subclass WHERE slug = 'draconic'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('aberrant-sorcery', (SELECT name FROM rpg.phb_subclass WHERE slug = 'aberrant'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'aberrant'))
     ON CONFLICT (slug) DO NOTHING;

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, class_id, subclass_id)
     VALUES ('clockwork-sorcery', (SELECT name FROM rpg.phb_subclass WHERE slug = 'clockwork'),
       'subclass'::rpg.spell_source_origin,
       (SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'),
       (SELECT id FROM rpg.phb_subclass WHERE slug = 'clockwork'))
     ON CONFLICT (slug) DO NOTHING;
