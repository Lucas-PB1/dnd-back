-- Faixas de CR da Forma Selvagem base (PHB 2024).
-- Moon usa fórmula floor(nível/3) no domínio — não nesta tabela.

CREATE TABLE rpg.phb_wild_shape_cr_band (
  min_level INT PRIMARY KEY CHECK (min_level BETWEEN 1 AND 20),
  cr_max TEXT NOT NULL,
  allow_fly BOOLEAN NOT NULL DEFAULT FALSE
);
