-- DMG §0 #8f: Acrobata + Poder + Magi (fecha lote cajados)
-- Ver docs/source/dmg-item-mesa-taxonomy-staves.yaml
-- +2 ataque mágico / Vantagem vs magias = passive-note

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
  v.short_all,
  TRUE
FROM (VALUES
  ('cajado-do-acrobata', 'cajadoAcrobataDeflexaoUse', 1, TRUE),
  ('cajado-do-poder', 'cajadoPoderCharges', 20, FALSE),
  ('cajado-dos-magi', 'cajadoMagiCharges', 50, FALSE)
) AS v(item_slug, resource_slug, fixed_max, short_all)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;

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
