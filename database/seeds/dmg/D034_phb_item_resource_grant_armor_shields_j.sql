-- DMG §0 #9j: resources + permanentEffects (escudos / armaduras únicas)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- +2 CA vs à distância (Apanhador) = lembrete (não cabe em acBonus flat)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'armaduraInvulnerabilidadeCarapacaUse',
    'Carapaça Metálica — Armadura de Invulnerabilidade',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'armadura-de-invulnerabilidade'),
    1
  ),
  (
    'escudoCavaleiroCampoUse',
    'Campo de Proteção — Escudo do Cavaleiro',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'escudo-do-cavaleiro'),
    1
  ),
  (
    'lorigaEscamasDraconicasDetectarUse',
    'Detectar Dragão — Loriga de Escamas Dracônicas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'loriga-de-escamas-draconicas'),
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
    "acBonus": 2
  }
}'::jsonb
WHERE slug = 'escudo-do-cavaleiro';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "acBonus": 1
  }
}'::jsonb
WHERE slug = 'loriga-de-escamas-draconicas';
