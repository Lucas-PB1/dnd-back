-- Ferramenta escolhida (ou fixa) do antecedente PHB 2024

ALTER TABLE rpg.player_character
  ADD COLUMN IF NOT EXISTS background_tool_item_slug TEXT
    REFERENCES rpg.phb_item(slug);
