-- Ladrão Sanguíneo: conjuração 1/3 (lista Mago + Sangromancia na app; INT)

INSERT INTO rpg.phb_subclass_spellcasting (
  subclass_id, casting_type, ability_id, focus_label, focus_item_id,
  spell_list_class_id, spell_slot_pattern_id, ritual
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief'),
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
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief');

-- Mesma tabela do Trapaceiro Arcano (3 truques → 4 no nv. 10; preparadas 1/3)
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
WHERE sc.slug = 'sanguine-thief';

UPDATE rpg.phb_subclass_feature
SET feature_kind = 'spellcasting'::rpg.subclass_feature_kind
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief')
  AND level = 3
  AND name = 'Conjuração';

UPDATE rpg.phb_subclass_feature
SET feature_kind = 'resource'::rpg.subclass_feature_kind
WHERE subclass_id = (SELECT id FROM rpg.phb_subclass WHERE slug = 'sanguine-thief')
  AND level = 3
  AND name = 'Roubado Poder';
