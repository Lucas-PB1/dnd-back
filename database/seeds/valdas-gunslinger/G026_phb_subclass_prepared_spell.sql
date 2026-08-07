-- Seed: Bang You're Dead! — Finger Guns always prepared at Creed unlock
-- A magia finger-guns deve existir no catálogo antes deste seed

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger') AS subclass_id,
  3 AS unlock_level,
  (SELECT id FROM rpg.phb_spell WHERE slug = 'finger-guns') AS spell_id,
  NULL::rpg.druid_land_terrain AS terrain
WHERE EXISTS (SELECT 1 FROM rpg.phb_spell WHERE slug = 'finger-guns')
ON CONFLICT DO NOTHING;
