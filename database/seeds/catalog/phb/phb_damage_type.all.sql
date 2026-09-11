-- Tipos de dano (rótulos PT).

INSERT INTO rpg.phb_damage_type (slug, label_pt, sort_order)
VALUES
  ('bludgeoning', 'Contundente', 1),
  ('piercing', 'Perfurante', 2),
  ('slashing', 'Cortante', 3),
  ('acid', 'Ácido', 4),
  ('cold', 'Gélido', 5),
  ('fire', 'Ígneo', 6),
  ('force', 'Força', 7),
  ('lightning', 'Elétrico', 8),
  ('necrotic', 'Necrótico', 9),
  ('poison', 'Venenoso', 10),
  ('psychic', 'Psíquico', 11),
  ('radiant', 'Radiante', 12),
  ('thunder', 'Trovejante', 13)
ON CONFLICT (slug) DO UPDATE SET
  label_pt = EXCLUDED.label_pt,
  sort_order = EXCLUDED.sort_order;
