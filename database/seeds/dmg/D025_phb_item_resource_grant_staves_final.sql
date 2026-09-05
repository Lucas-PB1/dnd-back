-- DMG §0 #8f: Acrobata + Poder + Magi (fecha lote cajados)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- +2 ataque mágico / Vantagem vs magias = passive-note
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'cajadoAcrobataDeflexaoUse',
    'Deflexão — Cajado do Acrobata',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-acrobata'),
    1
  ),
  (
    'cajadoPoderCharges',
    'Cargas — Cajado do Poder',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-do-poder'),
    1
  ),
  (
    'cajadoMagiCharges',
    'Cargas — Cajado dos Magi',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'cajado-dos-magi'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;



UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "attackBonus": 2,
    "damageBonus": 2
  }
}'::jsonb
WHERE slug = 'cajado-do-acrobata';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "attackBonus": 2,
    "damageBonus": 2,
    "acBonus": 2,
    "savingThrowBonuses": {
      "forca": 2,
      "destreza": 2,
      "constituicao": 2,
      "inteligencia": 2,
      "sabedoria": 2,
      "carisma": 2
    }
  }
}'::jsonb
WHERE slug = 'cajado-do-poder';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "attackBonus": 2,
    "damageBonus": 2
  }
}'::jsonb
WHERE slug = 'cajado-dos-magi';
