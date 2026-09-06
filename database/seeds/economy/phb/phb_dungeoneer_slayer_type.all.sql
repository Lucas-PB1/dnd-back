-- Seed: Dungeoneer Monster Slayer creature types

INSERT INTO rpg.phb_dungeoneer_slayer_type (slug, label, sort_order)
VALUES
  ('aberration', 'Aberração', 1),
  ('dragon', 'Dragão', 2),
  ('fey', 'Feérico', 3),
  ('fiend', 'Corruptor', 4),
  ('monstrosity', 'Monstruosidade', 5),
  ('ooze', 'Gosma', 6),
  ('undead', 'Morto-vivo', 7)
ON CONFLICT (slug) DO UPDATE
  SET label = EXCLUDED.label,
      sort_order = EXCLUDED.sort_order;
