-- Persona masks for College of Masks (Bard)

CREATE TABLE rpg.phb_persona_mask (
  id            BIGSERIAL PRIMARY KEY,
  slug          TEXT UNIQUE NOT NULL,
  name          TEXT NOT NULL,
  subclass_id   BIGINT NOT NULL REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE
);

CREATE INDEX idx_persona_mask_slug ON rpg.phb_persona_mask(slug);
CREATE INDEX idx_persona_mask_subclass ON rpg.phb_persona_mask(subclass_id);
