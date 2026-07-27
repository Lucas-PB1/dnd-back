-- Seed: Bang You're Dead! — Finger Guns always prepared at Creed unlock

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain_id)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  3,
  (SELECT id FROM rpg.phb_spell WHERE slug = 'finger-guns'),
  NULL
)
ON CONFLICT DO NOTHING;
