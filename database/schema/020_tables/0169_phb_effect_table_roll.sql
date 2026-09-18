-- Extras de table_roll: escala do total e apply pós-roll (Aspecto Bestial).
CREATE TABLE rpg.phb_effect_table_roll (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  result_scale INTEGER NULL
    CHECK (result_scale IS NULL OR result_scale >= 1),
  apply_bestial_aspect BOOLEAN NOT NULL DEFAULT false
);
