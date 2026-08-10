-- DMG lote §0 #2: permanentEffects (passivo numérico puro)
-- Ver docs/source/dmg-item-mesa-taxonomy-passives.yaml

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "acBonus": 1,
    "savingThrowBonuses": {
      "forca": 1,
      "destreza": 1,
      "constituicao": 1,
      "inteligencia": 1,
      "sabedoria": 1,
      "carisma": 1
    }
  }
}'::jsonb
WHERE slug IN (
  'anel-de-protecao',
  'manto-de-protecao'
);
