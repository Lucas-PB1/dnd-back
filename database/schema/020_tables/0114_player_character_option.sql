CREATE TABLE rpg.player_character_option (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  scope rpg.option_scope NOT NULL,
  owner_slug TEXT NOT NULL,
  option_key TEXT NOT NULL,
  value_id TEXT NOT NULL,
  instance_index INTEGER NOT NULL DEFAULT 0 CHECK (instance_index >= 0),
  UNIQUE (character_id, scope, owner_slug, instance_index, option_key)
);
