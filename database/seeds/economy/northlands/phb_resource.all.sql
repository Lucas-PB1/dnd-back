-- Recursos jogáveis — Northlands Heroes of the Sagas
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES
  (
    'norn-skeins',
    'Fios (Skeins)',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'nornbound'),
    3
  ),
  (
    'battle-sagas',
    'Sagas de Batalha',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'skald'),
    14
  ),
  (
    'marauders-reprisal',
    'Represália do Saqueador',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'),
    15
  ),
  (
    'unstoppable-assault',
    'Assalto Imparável',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'viking'),
    18
  ),
  (
    'spirit-of-the-valkyrie',
    'Espírito da Valquíria',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-valhalla'),
    20
  ),
  (
    'spirit-guidance',
    'Orientação Espiritual',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'),
    3
  ),
  (
    'spirit-aura',
    'Aura Espiritual',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'),
    6
  ),
  (
    'spirit-secrets',
    'Segredos Espirituais',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'spirit-caller'),
    14
  ),
  (
    'context-switch',
    'Troca de Contexto',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'),
    3
  ),
  (
    'harbinger-of-chaos',
    'Arauto do Caos',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'trickster'),
    14
  ),
  (
    'children-of-great-wolf',
    'Filhos do Grande Lobo',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-fenris'),
    14
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;

-- Nornbound: 2 fios / Descanso Longo


-- Skald: Sagas 1× / Descanso Curto ou Longo


-- Viking: Represália = PB / DL


-- Viking: Assalto Imparável 1× / DL


-- Valhalla: Espírito da Valquíria 1× / DL


-- Spirit Caller: Orientação = mod. Carisma


-- Spirit Caller: Aura 2× / DL


-- Spirit Caller: Segredos = mod. Carisma


-- Trickster: Troca de Contexto = mod. Carisma


-- Trickster: Arauto do Caos 1× / Descanso Curto


-- Fenris: Filhos do Grande Lobo 1× / dia (DL)

