-- Beastborne Aspect benefits by level (Barbarian)

CREATE TABLE rpg.phb_beastborne_aspect_benefit (
  aspect_level  INT PRIMARY KEY CHECK (aspect_level BETWEEN 1 AND 5),
  note          TEXT NOT NULL
);
