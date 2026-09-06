-- Steinhardt Eldritch Hunt — magias Osteomancia ↔ listas de classe
-- SSOT: H004. Osteomancer (wizard); listas de subclasse prepared ficam em H005.

INSERT INTO rpg.phb_spell_class (spell_id, class_id)
VALUES
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'brittle-bone-throw'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'gravity-spike'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'fractured-shell'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'phalangeal-shot'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'spectral-slash'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'arm-cannon'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'blind-ambush'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'calcified-memories'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'skeletal-tail'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'displacing-maw'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'osseous-impalement'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'spectral-fury'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'dread-scarecrow'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'maiden-of-bones'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'marrow-transplant'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard')),
  ((SELECT id FROM rpg.phb_spell WHERE slug = 'forest-of-dread'), (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'))
ON CONFLICT DO NOTHING;
