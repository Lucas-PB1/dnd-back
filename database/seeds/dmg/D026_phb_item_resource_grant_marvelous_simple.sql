-- DMG §0 #9a: resources maravilhosos simples (dawn + pools pequenos)
-- Ver docs/source/dmg-wiring-status.md

INSERT INTO rpg.phb_resource_definition (slug, name, scope, item_id, min_level)
VALUES
  (
    'elmoTelepatiaDetectarUse',
    'Detectar Pensamentos — Elmo de Telepatia',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-telepatia'),
    1
  ),
  (
    'elmoTelepatiaSugestaoUse',
    'Sugestão — Elmo de Telepatia',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'elmo-de-telepatia'),
    1
  ),
  (
    'chifreAlarmeSilenciosoCharges',
    'Cargas — Chifre do Alarme Silencioso',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'chifre-do-alarme-silencioso'),
    1
  ),
  (
    'botasAladasCharges',
    'Cargas — Botas Aladas',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'botas-aladas'),
    1
  ),
  (
    'mantoInvisibilidadeCharges',
    'Cargas — Manto de Invisibilidade',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'manto-de-invisibilidade'),
    1
  ),
  (
    'capaSaltimbancoUse',
    'Porta Dimensional — Capa do Saltimbanco',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'capa-do-saltimbanco'),
    1
  ),
  (
    'olhosEnfeiticarCharges',
    'Cargas — Olhos de Enfeitiçar',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'olhos-de-enfeiticar'),
    1
  ),
  (
    'pedrasMensageirasUse',
    'Remeter — Pedras Mensageiras',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'pedras-mensageiras'),
    1
  ),
  (
    'flautaAtormentadoraCharges',
    'Cargas — Flauta Atormentadora',
    'item'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_item WHERE slug = 'flauta-atormentadora'),
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
  ('elmo-de-telepatia', 'elmoTelepatiaDetectarUse', 1),
  ('elmo-de-telepatia', 'elmoTelepatiaSugestaoUse', 1),
  ('chifre-do-alarme-silencioso', 'chifreAlarmeSilenciosoCharges', 4),
  ('botas-aladas', 'botasAladasCharges', 4),
  ('manto-de-invisibilidade', 'mantoInvisibilidadeCharges', 3),
  ('capa-do-saltimbanco', 'capaSaltimbancoUse', 1),
  ('olhos-de-enfeiticar', 'olhosEnfeiticarCharges', 3),
  ('pedras-mensageiras', 'pedrasMensageirasUse', 1),
  ('flauta-atormentadora', 'flautaAtormentadoraCharges', 3)
) AS v(item_slug, resource_slug, fixed_max)
JOIN rpg.phb_item i ON i.slug = v.item_slug
JOIN rpg.phb_resource_definition rd
  ON rd.slug = v.resource_slug AND rd.item_id = i.id
ON CONFLICT DO NOTHING;
