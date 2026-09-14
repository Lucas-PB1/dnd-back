-- Formas conhecidas da Forma Selvagem (PHB 2024).

CREATE TABLE rpg.phb_wild_shape_known_band (
  min_level INT PRIMARY KEY CHECK (min_level BETWEEN 1 AND 20),
  forms_known INT NOT NULL CHECK (forms_known BETWEEN 1 AND 20)
);
