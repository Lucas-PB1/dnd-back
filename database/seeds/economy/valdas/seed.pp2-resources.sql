-- Recursos jogáveis Valdas Player Pack 2
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

-- Domínio do Dragão: Aspecto Lendário (3 usos / LR)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'legendary-aspect',
  'Aspecto Lendário',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
  17
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



-- Domínio do Dragão: Afinidade Cromática (mod. SAB / LR)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'chromatic-affinity',
  'Afinidade Cromática',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'dragon-domain'),
  3
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



-- Colégio do Glamour: Manto de Majestade (1 / LR)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'mantle-of-majesty',
  'Manto de Majestade',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'),
  6
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



-- Colégio do Glamour: Majestade Inquebrável (1 / SR)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'unbreakable-majesty',
  'Majestade Inquebrável',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'),
  14
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



-- Círculo da Cidade: Distorção de Muro (1 / LR)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'wall-warp',
  'Distorção de Muro',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'circle-of-the-city'),
  10
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



-- Colégio das Máscaras: Habilidade de Virtuoso (mod. Carisma / LR)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'virtuoso-skill',
  'Habilidade de Virtuoso',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'),
  6
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



-- Mago dos Mísseis: conjuração gratuita (mod. INT; 1 no Curto, todos no Longo)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'magic-missile-free',
  'Mísseis Mágicos Gratuitos',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'magic-missile-mage'),
  3
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



-- Escudo de Mísseis (1 / LR)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'missile-shield',
  'Escudo de Mísseis',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'magic-missile-mage'),
  10
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



-- Giga-Míssil (1 / LR)
INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES (
  'giga-missile',
  'Giga-Míssil',
  'subclass'::rpg.resource_scope,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'magic-missile-mage'),
  14
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



UPDATE rpg.phb_subclass_feature
SET feature_kind = 'resource'::rpg.subclass_feature_kind
WHERE subclass_id IN (
  SELECT id FROM rpg.phb_subclass WHERE slug IN (
    'dragon-domain', 'circle-of-the-city', 'college-of-masks', 'magic-missile-mage', 'glamour'
  )
)
AND name IN (
  'Aspecto Lendário',
  'Afinidade Cromática',
  'Distorção de Muro',
  'Habilidade de Virtuoso',
  'Sábio dos Mísseis Mágicos',
  'Escudo de Mísseis',
  'Giga-Míssil',
  'Manto de Majestade',
  'Majestade Inquebrável'
);
