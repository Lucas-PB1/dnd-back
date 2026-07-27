-- Seed Gunslinger weapon proficiencies
-- Fonte: Simple + Martial Ranged → simple + martial (catálogo atual)

INSERT INTO rpg.phb_class_weapon_proficiency (class_id, proficiency_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'gunslinger'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-marciais'))
ON CONFLICT DO NOTHING;
