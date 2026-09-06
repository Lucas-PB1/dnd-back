-- Magias always_prepared de subclasse — complemento (S028 gaps)

INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
VALUES
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'), 3, (SELECT id FROM rpg.phb_spell WHERE slug = 'enfeiticar-pessoa'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'), 3, (SELECT id FROM rpg.phb_spell WHERE slug = 'reflexos'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'glamour'), 6, (SELECT id FROM rpg.phb_spell WHERE slug = 'comando'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'), 3, (SELECT id FROM rpg.phb_spell WHERE slug = 'orientacao'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'stars'), 3, (SELECT id FROM rpg.phb_spell WHERE slug = 'raio-guia'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'), 6, (SELECT id FROM rpg.phb_spell WHERE slug = 'convocar-feerico'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'), 6, (SELECT id FROM rpg.phb_spell WHERE slug = 'invocar-fera'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'illusionist'), 3, (SELECT id FROM rpg.phb_spell WHERE slug = 'ilusao-menor'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'elements'), 3, (SELECT id FROM rpg.phb_spell WHERE slug = 'elementalismo'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'shadow'), 3, (SELECT id FROM rpg.phb_spell WHERE slug = 'ilusao-menor'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'), 10, (SELECT id FROM rpg.phb_spell WHERE slug = 'contramagia'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'abjurer'), 10, (SELECT id FROM rpg.phb_spell WHERE slug = 'dissipar-magia'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'psi-warrior'), 18, (SELECT id FROM rpg.phb_spell WHERE slug = 'telecinese'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'), 3, (SELECT id FROM rpg.phb_spell WHERE slug = 'falar-com-animais'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'), 3, (SELECT id FROM rpg.phb_spell WHERE slug = 'sentido-feral'), NULL),
  ((SELECT id FROM rpg.phb_subclass WHERE slug = 'wild-heart'), 10, (SELECT id FROM rpg.phb_spell WHERE slug = 'comunhao-com-a-natureza'), NULL)
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
