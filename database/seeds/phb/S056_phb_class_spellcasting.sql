-- Seed rpg.phb_class_spellcasting
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_spellcasting (class_id, casting_type, ability_id, focus_label, focus_item_id, ritual)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'full'::rpg.casting_type, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 'Instrumento Musical', (SELECT id FROM rpg.phb_item WHERE slug = 'instrumento-musical'), FALSE),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'pact'::rpg.casting_type, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 'Foco Arcano', (SELECT id FROM rpg.phb_item WHERE slug = 'foco-arcano'), FALSE),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'full'::rpg.casting_type, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 'Símbolo Sagrado', (SELECT id FROM rpg.phb_item WHERE slug = 'simbolo-sagrado'), TRUE),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'full'::rpg.casting_type, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 'Foco Druídico', (SELECT id FROM rpg.phb_item WHERE slug = 'foco-druidico'), TRUE),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'full'::rpg.casting_type, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 'Foco Arcano', (SELECT id FROM rpg.phb_item WHERE slug = 'foco-arcano'), FALSE),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'half'::rpg.casting_type, (SELECT id FROM rpg.phb_ability WHERE slug = 'sabedoria'), 'Foco Druídico', (SELECT id FROM rpg.phb_item WHERE slug = 'foco-druidico'), FALSE),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'full'::rpg.casting_type, (SELECT id FROM rpg.phb_ability WHERE slug = 'inteligencia'), 'Foco Arcano', (SELECT id FROM rpg.phb_item WHERE slug = 'foco-arcano'), TRUE),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'half'::rpg.casting_type, (SELECT id FROM rpg.phb_ability WHERE slug = 'carisma'), 'Símbolo Sagrado', (SELECT id FROM rpg.phb_item WHERE slug = 'simbolo-sagrado'), FALSE);
