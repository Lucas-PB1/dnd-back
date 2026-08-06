-- Cavaleiro Místico: conjuração de 1/3 (lista Mago, INT)
-- Garante o pattern `third` aqui (pack subclass roda antes de valdas-gunslinger/G023).

INSERT INTO rpg.phb_spell_slot_pattern (slug, name, description)
VALUES (
  'third',
  'Conjurador de um terço',
  'Slots de magia de 1/3 caster (Cavaleiro Místico, Spellslinger, etc.). Começa no nível 3.'
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
  (3, 1, 2),
  (4, 1, 3),
  (5, 1, 3),
  (6, 1, 3),
  (7, 1, 4), (7, 2, 2),
  (8, 1, 4), (8, 2, 2),
  (9, 1, 4), (9, 2, 2),
  (10, 1, 4), (10, 2, 3),
  (11, 1, 4), (11, 2, 3),
  (12, 1, 4), (12, 2, 3),
  (13, 1, 4), (13, 2, 3), (13, 3, 2),
  (14, 1, 4), (14, 2, 3), (14, 3, 2),
  (15, 1, 4), (15, 2, 3), (15, 3, 2),
  (16, 1, 4), (16, 2, 3), (16, 3, 3),
  (17, 1, 4), (17, 2, 3), (17, 3, 3),
  (18, 1, 4), (18, 2, 3), (18, 3, 3),
  (19, 1, 4), (19, 2, 3), (19, 3, 3), (19, 4, 1),
  (20, 1, 4), (20, 2, 3), (20, 3, 3), (20, 4, 1)
) AS v(level, circle, slot_count)
WHERE p.slug = 'third';

INSERT INTO rpg.phb_subclass_spellcasting (
  subclass_id, casting_type, ability_id, focus_label, focus_item_id,
  spell_list_class_id, spell_slot_pattern_id, ritual
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight'),
  'third'::rpg.casting_type,
  (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'),
  'Foco Arcano ou sua arma vinculada',
  (SELECT id FROM rpg.phb_item WHERE slug = 'foco-arcano'),
  (SELECT id FROM rpg.phb_class WHERE slug = 'wizard'),
  (SELECT id FROM rpg.phb_spell_slot_pattern WHERE slug = 'third'),
  FALSE
)
ON CONFLICT (subclass_id) DO UPDATE SET
  casting_type = EXCLUDED.casting_type,
  ability_id = EXCLUDED.ability_id,
  focus_label = EXCLUDED.focus_label,
  focus_item_id = EXCLUDED.focus_item_id,
  spell_list_class_id = EXCLUDED.spell_list_class_id,
  spell_slot_pattern_id = EXCLUDED.spell_slot_pattern_id,
  ritual = EXCLUDED.ritual;

DELETE FROM rpg.phb_subclass_progression
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'eldritch-knight');

INSERT INTO rpg.phb_subclass_progression (subclass_id, level, cantrips, prepared_spells)
SELECT sc.id, v.level, v.cantrips, v.prepared
FROM rpg.phb_subclass sc
CROSS JOIN (VALUES
  (3, 2, 3),
  (4, 2, 4),
  (5, 2, 4),
  (6, 2, 4),
  (7, 2, 5),
  (8, 2, 6),
  (9, 2, 6),
  (10, 3, 7),
  (11, 3, 8),
  (12, 3, 8),
  (13, 3, 9),
  (14, 3, 10),
  (15, 3, 10),
  (16, 3, 11),
  (17, 3, 11),
  (18, 3, 11),
  (19, 3, 12),
  (20, 3, 13)
) AS v(level, cantrips, prepared)
WHERE sc.slug = 'eldritch-knight';
