-- Seed: Persona masks (College of Masks)

INSERT INTO rpg.phb_persona_mask (slug, name, subclass_id)
VALUES
  ('persona-mask-angel', 'Anjo', (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks')),
  ('persona-mask-archmage', 'Arquimago', (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks')),
  ('persona-mask-devil', 'Diabo', (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks')),
  ('persona-mask-dragon', 'Dragão', (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks')),
  ('persona-mask-faceless', 'Sem Rosto', (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks')),
  ('persona-mask-gladiator', 'Gladiador', (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks')),
  ('persona-mask-hierophant', 'Hierofante', (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks')),
  ('persona-mask-jester', 'Bobão', (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks')),
  ('persona-mask-noble', 'Nobre', (SELECT id FROM rpg.phb_subclass WHERE slug = 'college-of-masks'))
ON CONFLICT (slug) DO UPDATE
  SET name = EXCLUDED.name,
      subclass_id = EXCLUDED.subclass_id;
