-- Enrich weapon item.properties with versatileDamage (PHB 2024)

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || jsonb_build_object('versatileDamage', v.dmg)
FROM (VALUES
  ('quarterstaff', '1d8'),
  ('spear', '1d8'),
  ('trident', '1d8'),
  ('longsword', '1d10'),
  ('battleaxe', '1d10'),
  ('warhammer', '1d10'),
  ('war-pick', '1d10')
) AS v(slug, dmg)
WHERE rpg.phb_item.slug = v.slug
  AND rpg.phb_item.item_type = 'weapon'::rpg.item_type;

-- Blowgun range (metros)
UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"range":{"normal":7.5,"max":30}}'::jsonb
WHERE slug = 'blowgun'
  AND item_type = 'weapon'::rpg.item_type;
