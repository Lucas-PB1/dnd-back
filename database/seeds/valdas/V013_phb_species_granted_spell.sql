-- Seed rpg.phb_spell_grant
-- Magias concedidas Mandrágora (Magia das Raízes)

INSERT INTO rpg.phb_spell_grant (origin_type, origin_id, spell_id, unlock_level)
VALUES
  (
    'species'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'bordao-mistico'),
    1
  ),
  (
    'species'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'bom-fruto'),
    3
  ),
  (
    'species'::rpg.spell_grant_origin,
    (SELECT id FROM rpg.phb_species WHERE slug = 'mandrake'),
    (SELECT id FROM rpg.phb_spell WHERE slug = 'pele-casca'),
    5
  )
ON CONFLICT (origin_type, origin_id, spell_id, unlock_level) DO NOTHING;
