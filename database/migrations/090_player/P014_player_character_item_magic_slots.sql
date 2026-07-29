-- Slots não exclusivos para itens mágicos vestíveis / carregados.

ALTER TABLE rpg.player_character_item
  DROP CONSTRAINT IF EXISTS player_character_item_equipment_slot_check;

ALTER TABLE rpg.player_character_item
  ADD CONSTRAINT player_character_item_equipment_slot_check CHECK (
    equipment_slot IS NULL
    OR equipment_slot IN (
      'armor',
      'main_hand',
      'off_hand',
      'shield',
      'worn',
      'carried'
    )
  );
