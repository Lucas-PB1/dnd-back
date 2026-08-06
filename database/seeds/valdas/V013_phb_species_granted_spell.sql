-- Seed rpg.phb_species_granted_spell
-- Magias concedidas Mandrágora (Magia das Raízes)

INSERT INTO rpg.phb_species_granted_spell (species_id, spell_id, unlock_level)
VALUES
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'bordao-mistico'),
    1
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'bom-fruto'),
    3
  ),
  (
    (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'pele-casca'),
    5
  )
ON CONFLICT (species_id, spell_id, unlock_level) DO NOTHING;
