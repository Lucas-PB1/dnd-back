-- DMG §0 #9j: resources + permanentEffects (escudos / armaduras únicas)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- +2 CA vs à distância (Apanhador) = lembrete (não cabe em acBonus flat)

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
  FALSE,
  TRUE
FROM (VALUES
  ('armadura-de-invulnerabilidade', 'armaduraInvulnerabilidadeCarapacaUse', 1),
  ('escudo-do-cavaleiro', 'escudoCavaleiroCampoUse', 1),
  ('loriga-de-escamas-draconicas', 'lorigaEscamasDraconicasDetectarUse', 1)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

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
