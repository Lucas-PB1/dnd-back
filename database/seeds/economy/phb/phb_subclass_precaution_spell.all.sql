-- Seed: Subclass precaution spells (Dungeoneer)

INSERT INTO rpg.phb_subclass_precaution_spell (subclass_id, spell_id)
VALUES
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'), (SELECT id FROM rpg.phb_spell WHERE slug = 'alarme')),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'), (SELECT id FROM rpg.phb_spell WHERE slug = 'compreender-idiomas')),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'), (SELECT id FROM rpg.phb_spell WHERE slug = 'detectar-magia')),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'), (SELECT id FROM rpg.phb_spell WHERE slug = 'detectar-veneno-e-doenca')),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'), (SELECT id FROM rpg.phb_spell WHERE slug = 'encontrar-armadilhas')),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'), (SELECT id FROM rpg.phb_spell WHERE slug = 'identificar')),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'dungeoneer'), (SELECT id FROM rpg.phb_spell WHERE slug = 'purificar-alimentos-e-bebidas'))
ON CONFLICT (subclass_id, spell_id) DO NOTHING;
