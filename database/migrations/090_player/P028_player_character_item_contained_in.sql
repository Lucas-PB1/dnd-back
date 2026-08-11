-- Compartimentos de inventário: item contido em outro (bolsa/saca/cesta).
-- Nullable = mochila raiz (compatível com inventário existente).
ALTER TABLE rpg.player_character_item
  ADD COLUMN IF NOT EXISTS contained_in_item_slug TEXT NULL;

COMMENT ON COLUMN rpg.player_character_item.contained_in_item_slug IS
  'Slug do recipiente no mesmo personagem; NULL = raiz (Equipado/Mochila).';

CREATE INDEX IF NOT EXISTS idx_player_character_item_contained_in
  ON rpg.player_character_item (character_id, contained_in_item_slug)
  WHERE contained_in_item_slug IS NOT NULL;
