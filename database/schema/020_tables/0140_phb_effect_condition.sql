-- Condição / pending aplicada por effect (ex.: Topple → prone; pending-only OK).
CREATE TABLE rpg.phb_effect_condition (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  condition_slug rpg.condition_slug NULL,
  pending_kind TEXT NULL
    CHECK (pending_kind IS NULL OR length(trim(pending_kind)) > 0),
  CONSTRAINT phb_effect_condition_payload_check CHECK (
    condition_slug IS NOT NULL OR pending_kind IS NOT NULL
  )
);
