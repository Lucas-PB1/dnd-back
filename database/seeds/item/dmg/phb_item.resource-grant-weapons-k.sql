-- DMG §0 #9k: resources + permanentEffects (armas únicas restantes)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Cast/link magia = fase 6 · artefatos = PE + botões chave + lembretes
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'macaTerrorCharges',
    'Cargas — Maça do Terror',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'maca-do-terror'),
    1
  ),
  (
    'tridenteComandarPeixesCharges',
    'Cargas — Tridente de Comandar Peixes',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'tridente-de-comandar-peixes'),
    1
  ),
  (
    'ondaComandoAquaticoCharges',
    'Cargas — Onda (Comando Aquático)',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'onda'),
    1
  ),
  (
    'ondaGloboUse',
    'Globo de Invulnerabilidade — Onda',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'onda'),
    1
  ),
  (
    'opressorDetectarBemMalUse',
    'Detectar Bem e Mal — Opressor',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'),
    1
  ),
  (
    'opressorLocalizarObjetoUse',
    'Localizar Objeto — Opressor',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'),
    1
  ),
  (
    'opressorOndaChoqueUse',
    'Onda de Choque — Opressor',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'opressor'),
    1
  ),
  (
    'machadoElementalTerraUse',
    'Elemental da Terra — Machado dos Senhores Anões',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'machado-dos-senhores-anoes'),
    1
  ),
  (
    'machadoTeleporteUse',
    'Teleporte — Machado dos Senhores Anões',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'machado-dos-senhores-anoes'),
    1
  ),
  (
    'tacapeTerremotoUse',
    'Terremoto — Tacape Trovejante',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'tacape-trovejante'),
    1
  ),
  (
    'lunaminaBrilhoUse',
    'Brilho — Lunâmina (prop. 86–95)',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'lunamina'),
    1
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  item_id = EXCLUDED.item_id,
  min_level = EXCLUDED.min_level;



UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"permanentEffects":{"attackBonus":3,"damageBonus":3}}'::jsonb
WHERE slug IN (
  'espada-das-respostas',
  'espada-de-kas',
  'laminegra',
  'martelo-arremessavel-dos-anoes',
  'onda',
  'opressor'
);

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"permanentEffects":{"attackBonus":2,"damageBonus":2}}'::jsonb
WHERE slug = 'lamina-solar';

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{"permanentEffects":{"attackBonus":1,"damageBonus":1}}'::jsonb
WHERE slug IN ('lunamina', 'maca-da-destruicao');

UPDATE rpg.phb_item
SET properties = COALESCE(properties, '{}'::jsonb) || '{
  "permanentEffects": {
    "attackBonus": 3,
    "damageBonus": 3,
    "abilityBonuses": { "constituicao": 2 }
  }
}'::jsonb
WHERE slug = 'machado-dos-senhores-anoes';
