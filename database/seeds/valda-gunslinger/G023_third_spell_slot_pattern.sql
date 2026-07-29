-- Seed: pattern third-caster + Spellslinger slots (níveis 3–20)

INSERT INTO rpg.phb_spell_slot_pattern (slug, name, description)
VALUES (
  'third',
  'Conjurador de um terço',
  'Slots de magia de 1/3 caster (Spellslinger; futuro EK/AT). Começa no nível 3.'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

DELETE FROM rpg.phb_spell_slot_by_level
WHERE pattern_id = (SELECT id FROM rpg.phb_spell_slot_pattern WHERE slug = 'third');

INSERT INTO rpg.phb_spell_slot_by_level (pattern_id, level, circle, slot_count)
SELECT p.id, v.level, v.circle, v.slot_count
FROM rpg.phb_spell_slot_pattern p
CROSS JOIN (VALUES
  -- L3: 2×1º
  (3, 1, 2),
  -- L4–6: 3×1º
  (4, 1, 3),
  (5, 1, 3),
  (6, 1, 3),
  -- L7–9: 4×1º + 2×2º
  (7, 1, 4), (7, 2, 2),
  (8, 1, 4), (8, 2, 2),
  (9, 1, 4), (9, 2, 2),
  -- L10–12: 4×1º + 3×2º
  (10, 1, 4), (10, 2, 3),
  (11, 1, 4), (11, 2, 3),
  (12, 1, 4), (12, 2, 3),
  -- L13–15: 4×1º + 3×2º + 2×3º
  (13, 1, 4), (13, 2, 3), (13, 3, 2),
  (14, 1, 4), (14, 2, 3), (14, 3, 2),
  (15, 1, 4), (15, 2, 3), (15, 3, 2),
  -- L16–18: 4×1º + 3×2º + 3×3º
  (16, 1, 4), (16, 2, 3), (16, 3, 3),
  (17, 1, 4), (17, 2, 3), (17, 3, 3),
  (18, 1, 4), (18, 2, 3), (18, 3, 3),
  -- L19–20: +1×4º
  (19, 1, 4), (19, 2, 3), (19, 3, 3), (19, 4, 1),
  (20, 1, 4), (20, 2, 3), (20, 3, 3), (20, 4, 1)
) AS v(level, circle, slot_count)
WHERE p.slug = 'third';
