-- DMG §0 #9a: resources maravilhosos simples (dawn + pools pequenos)
-- Ver docs/source/extracts/dmg/wiring-status.md
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

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


