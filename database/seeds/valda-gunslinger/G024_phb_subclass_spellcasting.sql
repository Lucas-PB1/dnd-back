-- Seed: Spellslinger subclass spellcasting (INT, lista Wizard, pattern third)

INSERT INTO rpg.phb_subclass_spellcasting (
  subclass_id, casting_type, ability_id, focus_label, focus_item_id,
  spell_list_class_id, spell_slot_pattern_id, ritual
)
VALUES (
  (SELECT id FROM rpg.phb_subclass WHERE slug = 'spellslinger'),
  'third'::rpg.casting_type,
  (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'),
  'Arcane Focus or a Ranged weapon',
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
