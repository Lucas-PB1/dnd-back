CREATE TABLE rpg.player_character_equipment (
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  source TEXT NOT NULL CHECK (source IN ('class', 'background')),
  package_slug TEXT NOT NULL,
  package_id BIGINT REFERENCES rpg.phb_starting_package(id),
  item_slug TEXT REFERENCES rpg.phb_item(slug),
  quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity >= 1),
  sort_order INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (character_id, source, sort_order)
);
