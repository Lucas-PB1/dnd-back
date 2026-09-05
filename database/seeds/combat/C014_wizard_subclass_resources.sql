-- Recursos de subclasse do Mago (não estão em S002 gerado).
-- Economia/painel: C009 / C010. Idempotente.
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES
  (
    'third-eye',
    'O Terceiro Olho',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'diviner'),
    10
  ),
  (
    'spectral-summon',
    'Criaturas Espectrais',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
    6
  ),
  (
    'illusory-self',
    'Autoimagem Ilusória',
    'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'),
    10
  )
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;






