-- Seed: Beastborne aspect benefits (levels 1–5)

INSERT INTO rpg.phb_beastborne_aspect_benefit (aspect_level, note)
VALUES
  (1, 'Carnificina: +2 nas jogadas de dano com armas e Ataques Desarmados.'),
  (2, 'Movimento Rápido: Deslocamento +3 m.'),
  (3, 'Frenesi Sangrento: Vantagem em ataques contra criaturas sem PV cheios.'),
  (4, 'Pele Espessa: +2 CA se não empunhar Escudo.'),
  (5, 'Retaliação: Reação para atacar corpo a corpo quem causar dano a ≤1,5 m.')
ON CONFLICT (aspect_level) DO UPDATE
  SET note = EXCLUDED.note;
