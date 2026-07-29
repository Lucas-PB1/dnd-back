-- Seed rpg.phb_language
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_language (slug, name, script, typical_speakers, is_rare)
VALUES
  ('common', 'Comum', NULL, NULL, FALSE),
  ('sign-language', 'Língua de Sinais Comum', NULL, NULL, FALSE),
  ('draconic', 'Dracônico', NULL, NULL, FALSE),
  ('dwarvish', 'Anão', NULL, NULL, FALSE),
  ('elvish', 'Élfico', NULL, NULL, FALSE),
  ('giant', 'Gigante', NULL, NULL, FALSE),
  ('gnomish', 'Gnômico', NULL, NULL, FALSE),
  ('goblin', 'Goblin', NULL, NULL, FALSE),
  ('halfling', 'Pequenino', NULL, NULL, FALSE),
  ('orc', 'Orc', NULL, NULL, FALSE),
  ('abyssal', 'Abissal', NULL, NULL, TRUE),
  ('celestial', 'Celestial', NULL, NULL, TRUE),
  ('deep-speech', 'Dialeto Obscuro', NULL, NULL, TRUE),
  ('druidic', 'Druídico', NULL, NULL, TRUE),
  ('thieves-cant', 'Gíria dos Ladrões', NULL, NULL, TRUE),
  ('infernal', 'Infernal', NULL, NULL, TRUE),
  ('primordial', 'Primordial', NULL, NULL, TRUE),
  ('sylvan', 'Silvestre', NULL, NULL, TRUE),
  ('undercommon', 'Subcomum', NULL, NULL, TRUE);
