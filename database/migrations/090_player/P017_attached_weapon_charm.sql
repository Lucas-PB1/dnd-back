-- Encanto de arma preso a um item do inventário (slug do phb_item do encanto).
ALTER TABLE rpg.player_character_item
  ADD COLUMN IF NOT EXISTS attached_charm_slug TEXT NULL;

ALTER TABLE rpg.player_character_item
  DROP CONSTRAINT IF EXISTS player_character_item_attached_charm_slug_check;

-- Soft check: null ou slug de encanto; sem FK (catálogo pode atrasar).
ALTER TABLE rpg.player_character_item
  ADD CONSTRAINT player_character_item_attached_charm_slug_check
  CHECK (
    attached_charm_slug IS NULL
    OR attached_charm_slug LIKE 'weapon-charm-%'
  );
