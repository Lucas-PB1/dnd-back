-- Recursos — Sangromante: Renovação Rubra (1× por descanso longo).
-- Ao usar a ação de mesa, o handler restaura metade do nível (mín. 1)
-- de Dados de Sangromancia (+ nota para Dados de Vida).
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, class_id, subclass_id, min_level)
VALUES (
  'red-renewal',
  'Renovação Rubra',
  'subclass'::rpg.resource_scope,
  NULL,
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
  14
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;


