-- DMG §0 #9d: Braceletes de Defesa (acBonus +2; só sem armadura/escudo — lembrete)
-- Ver docs/source/dmg-item-mesa-taxonomy-marvelous-simple.yaml

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "acBonus": 2
  }
}'::jsonb
WHERE slug = 'braceletes-de-defesa';
