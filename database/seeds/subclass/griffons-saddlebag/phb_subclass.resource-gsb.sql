-- Recursos de combate — Griffon's Saddlebag Book One (11 subclasses restantes)
-- Grants: SSOT em effects/E007 (species) / E012 (subclass) / E013 (item) / E00* feats

INSERT INTO rpg.phb_resource_definition (slug, name, scope, subclass_id, min_level)
VALUES
  ('planar-reach', 'Alcance Planar', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-domain'), 3),
  ('mercy-dice', 'Dados de Misericórdia', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'couatl-herald'), 3),
  ('magic-snare', 'Armadilha Mágica', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'winter-trapper'), 11),
  ('rune-points', 'Pontos de Runa', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'runetagger'), 3),
  ('astral-clarity', 'Clareza Astral', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'astral-griffon-patron'), 10),
  ('burning-spirit', 'Espírito Flamejante', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'oath-of-the-hearth'), 20),
  ('cube-detonation', 'Detonação de Cubo', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 3),
  ('rematerialize', 'Rematerializar', 'subclass'::rpg.resource_scope,
    (SELECT id FROM rpg.phb_subclass WHERE slug = 'materializer'), 14)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  scope = EXCLUDED.scope,
  subclass_id = EXCLUDED.subclass_id,
  min_level = EXCLUDED.min_level;
















