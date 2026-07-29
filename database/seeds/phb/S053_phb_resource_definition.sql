-- Seed rpg.phb_resource_definition
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_resource_definition (slug, name, scope, species_id, class_id, min_level)
VALUES
  ('breathWeapon', 'Sopro Dracônico', 'species'::rpg.resource_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), NULL, 1),
  ('dragonFlight', 'Voo Dracônico', 'species'::rpg.resource_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dragonborn'), NULL, 5),
  ('giantAncestry', 'Ancestralidade Gigante', 'species'::rpg.resource_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), NULL, 1),
  ('largeForm', 'Forma Grande', 'species'::rpg.resource_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'goliath'), NULL, 5),
  ('adrenalineSurge', 'Surto de Adrenalina', 'species'::rpg.resource_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'orc'), NULL, 1),
  ('relentlessEndurance', 'Persistência Implacável', 'species'::rpg.resource_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'orc'), NULL, 1),
  ('healingHands', 'Mãos Curativas', 'species'::rpg.resource_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), NULL, 1),
  ('celestialRevelation', 'Revelação Celestial', 'species'::rpg.resource_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'aasimar'), NULL, 3),
  ('stonecunning', 'Percepção de Pedra', 'species'::rpg.resource_scope, (SELECT id FROM rpg.phb_species WHERE slug = 'dwarf'), NULL, 1),
  ('rage', 'Fúria', 'class'::rpg.resource_scope, NULL, (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 1),
  ('channelDivinity', 'Canalizar Divindade', 'class'::rpg.resource_scope, NULL, (SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 1),
  ('focusPoints', 'Pontos de Foco', 'class'::rpg.resource_scope, NULL, (SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 1);
