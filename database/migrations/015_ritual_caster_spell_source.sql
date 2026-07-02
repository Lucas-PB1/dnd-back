-- Fonte de magia: Conjurador Ritualista

INSERT INTO rpg.phb_spell_source (slug, label, origin_type, feat_id)
VALUES
  ('ritual-caster', 'Conjurador Ritualista', 'feat', (SELECT id FROM rpg.phb_feat WHERE slug = 'ritual-caster'))
ON CONFLICT (slug) DO NOTHING;
