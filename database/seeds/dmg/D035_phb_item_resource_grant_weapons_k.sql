-- DMG §0 #9k: resources + permanentEffects (armas únicas restantes)
-- Ver docs/source/dmg-wiring-status.md
-- Cast/link magia = fase 6 · artefatos = PE + botões chave + lembretes

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

INSERT INTO rpg.phb_resource_grant (
  owner_kind, owner_id, resource_id, unlock_level, max_formula, fixed_max,
  recover_one_on_short, recover_all_on_short, recover_all_on_long
)
SELECT
  'item'::rpg.resource_owner_kind,
  i.id,
  rd.id,
  1,
  'fixed'::rpg.resource_max_formula,
  v.fixed_max,
  FALSE,
  v.recover_short,
  v.recover_long
FROM (VALUES
  ('maca-do-terror', 'macaTerrorCharges', 3, FALSE, TRUE),
  ('tridente-de-comandar-peixes', 'tridenteComandarPeixesCharges', 3, FALSE, TRUE),
  ('onda', 'ondaComandoAquaticoCharges', 3, FALSE, TRUE),
  ('onda', 'ondaGloboUse', 1, FALSE, TRUE),
  ('opressor', 'opressorDetectarBemMalUse', 1, FALSE, TRUE),
  ('opressor', 'opressorLocalizarObjetoUse', 1, FALSE, TRUE),
  ('opressor', 'opressorOndaChoqueUse', 1, FALSE, TRUE),
  ('machado-dos-senhores-anoes', 'machadoElementalTerraUse', 1, FALSE, TRUE),
  ('machado-dos-senhores-anoes', 'machadoTeleporteUse', 1, FALSE, FALSE),
  ('tacape-trovejante', 'tacapeTerremotoUse', 1, FALSE, TRUE),
  ('lunamina', 'lunaminaBrilhoUse', 1, TRUE, TRUE)
) AS v(item_slug, resource_slug, fixed_max, recover_short, recover_long)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

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
