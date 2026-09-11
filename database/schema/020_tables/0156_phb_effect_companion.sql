-- Sync / restore de companheiro na mesa.
CREATE TABLE rpg.phb_effect_companion (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  restore_hp BOOLEAN NOT NULL DEFAULT false
);
