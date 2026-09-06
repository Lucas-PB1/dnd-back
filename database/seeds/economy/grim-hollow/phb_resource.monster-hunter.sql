-- Recursos de combate — Caçador de Monstros (guildas + classe)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, class_id, subclass_id, min_level)
VALUES
  (
    'devourer-portion',
    'Porções de Monstro',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'devourer-guild'),
    3
  ),
  (
    'grave-strike',
    'Golpe Sepulcral',
    'class'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_class WHERE slug = 'monster-hunter'),
    NULL,
    20
  ),
  (
    'trapper-phase-leap',
    'Salto de Fase',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
    15
  ),
  (
    'trapper-regen-dice',
    'Dados de Regeneração (Armadura)',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
    15
  ),
  (
    'trapper-rapid-tinker',
    'Engenho Rápido',
    'subclass'::rpg.resource_scope,
    NULL,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'trapper-guild'),
    18
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  class_id = EXCLUDED.class_id,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;



-- Class grave-strike grant → effects/E009_class.sql






