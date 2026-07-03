-- Seed rpg.phb_class_weapon_proficiency
-- Gerado automaticamente — não editar à mão

INSERT INTO rpg.phb_class_weapon_proficiency (class_id, proficiency_id)
VALUES
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-marciais')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'bard'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'warlock'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'cleric'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'druid'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'adagas')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'dardos')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'fundas')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'bordoes')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'sorcerer'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'bestas-leves')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'ranger'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-marciais')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'fighter'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-marciais')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'bestas-de-mao')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'espada-longa')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'rapieira')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'rogue'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'espada-curta')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'adagas')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'dardos')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'fundas')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'bordoes')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'wizard'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'bestas-leves')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'monk'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-marciais-leves')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-simples')),
  ((SELECT id FROM rpg.phb_class WHERE slug = 'paladin'), (SELECT id FROM rpg.phb_weapon_proficiency WHERE slug = 'armas-marciais'));
