-- Trapaceiro Arcano: conjuração de 1/3 (lista Mago, INT)
-- O pattern `third` já é garantido por S008 (mesmo pack, roda antes).

INSERT INTO rpg.phb_subclass_spellcasting (
  subclass_id, casting_type, ability_id, focus_label, focus_item_id,
  spell_list_class_id, spell_slot_pattern_id, ritual
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster'),
  'third'::rpg.casting_type,
  (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'),
  'Foco Arcano',
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
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'arcane-trickster');

-- Truques incluem Mãos Mágicas (3 → 4 no nível 10); preparadas iguais ao 1/3 caster
INSERT INTO rpg.phb_subclass_progression (subclass_id, level, cantrips, prepared_spells)
SELECT sc.id, v.level, v.cantrips, v.prepared
FROM rpg.phb_subclass sc
CROSS JOIN (VALUES
  (3, 3, 3),
  (4, 3, 4),
  (5, 3, 4),
  (6, 3, 4),
  (7, 3, 5),
  (8, 3, 6),
  (9, 3, 6),
  (10, 4, 7),
  (11, 4, 8),
  (12, 4, 8),
  (13, 4, 9),
  (14, 4, 10),
  (15, 4, 10),
  (16, 4, 11),
  (17, 4, 11),
  (18, 4, 11),
  (19, 4, 12),
  (20, 4, 13)
) AS v(level, cantrips, prepared)
WHERE sc.slug = 'arcane-trickster';

-- Mãos Mágicas é sempre conhecida/preparada e não pode ser trocada
INSERT INTO rpg.phb_subclass_prepared_spell (subclass_id, unlock_level, spell_id, terrain)
SELECT s.id, 3, sp.id, NULL
FROM rpg.phb_subclass s, rpg.phb_spell sp
WHERE s.slug = 'arcane-trickster' AND sp.slug = 'maos-magicas'
ON CONFLICT ON CONSTRAINT uq_subclass_prepared_spell DO NOTHING;
