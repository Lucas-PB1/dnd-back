-- Escala opcional 1:1 do template (binding por nível do personagem ou círculo do slot).

CREATE TABLE rpg.phb_creature_scale_by_level (
  template_slug TEXT PRIMARY KEY
    REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  hp_base INT NOT NULL CHECK (hp_base >= 0),
  hp_per_level INT NOT NULL CHECK (hp_per_level >= 0),
  ac_ability_slug TEXT REFERENCES rpg.phb_ability(slug)
);

CREATE TABLE rpg.phb_creature_scale_by_slot (
  template_slug TEXT PRIMARY KEY
    REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  scale_min_slot INT NOT NULL CHECK (scale_min_slot BETWEEN 0 AND 20),
  ac_base INT NOT NULL CHECK (ac_base BETWEEN 0 AND 40),
  ac_per_slot INT NOT NULL CHECK (ac_per_slot BETWEEN 0 AND 10),
  hp_base INT NOT NULL CHECK (hp_base >= 0),
  hp_per_slot INT NOT NULL CHECK (hp_per_slot >= 0),
  hp_mode TEXT NOT NULL CHECK (hp_mode IN ('per_slot', 'above_min'))
);
