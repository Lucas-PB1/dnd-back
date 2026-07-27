-- Dados de vida (Hit Point Dice) no estado de mesa

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS hit_dice_current INT NOT NULL DEFAULT 0
    CHECK (hit_dice_current >= 0);

UPDATE rpg.player_character_state s
SET hit_dice_current = c.level
FROM rpg.player_character c
WHERE c.id = s.character_id
  AND s.hit_dice_current = 0;
