-- Seed rpg.phb_class_proficiency (weapon)
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_proficiency (class_id, kind, ref_slug)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), 'weapon'::rpg.class_proficiency_kind, 'armas-marciais'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'weapon'::rpg.class_proficiency_kind, 'adagas'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'weapon'::rpg.class_proficiency_kind, 'dardos'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'weapon'::rpg.class_proficiency_kind, 'fundas'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'weapon'::rpg.class_proficiency_kind, 'bordoes'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), 'weapon'::rpg.class_proficiency_kind, 'bestas-leves'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), 'weapon'::rpg.class_proficiency_kind, 'armas-marciais'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), 'weapon'::rpg.class_proficiency_kind, 'armas-marciais'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'weapon'::rpg.class_proficiency_kind, 'bestas-de-mao'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'weapon'::rpg.class_proficiency_kind, 'espada-longa'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'weapon'::rpg.class_proficiency_kind, 'rapieira'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), 'weapon'::rpg.class_proficiency_kind, 'espada-curta'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'weapon'::rpg.class_proficiency_kind, 'adagas'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'weapon'::rpg.class_proficiency_kind, 'dardos'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'weapon'::rpg.class_proficiency_kind, 'fundas'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'weapon'::rpg.class_proficiency_kind, 'bordoes'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), 'weapon'::rpg.class_proficiency_kind, 'bestas-leves'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), 'weapon'::rpg.class_proficiency_kind, 'armas-marciais-leves'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'weapon'::rpg.class_proficiency_kind, 'armas-simples'),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), 'weapon'::rpg.class_proficiency_kind, 'armas-marciais');
