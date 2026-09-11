-- Toggle de flag de combate na mesa (Fúria / Imprudente).
CREATE TABLE rpg.phb_effect_combat_flag (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  flag TEXT NOT NULL CHECK (flag IN ('rage', 'reckless')),
  spend_on_enter BOOLEAN NOT NULL DEFAULT true,
  force_enter BOOLEAN NOT NULL DEFAULT false
);
