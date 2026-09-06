CREATE TABLE rpg.phb_background_boost_option (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  label TEXT NOT NULL
);

-- Character Threads (Northlands) â€” catÃ¡logo (antes de resource_definition para FK)
