-- Bônus de atributo do antecedente PHB 2024 (+2 / +1)

ALTER TABLE rpg.player_character
  ADD COLUMN IF NOT EXISTS background_boost_plus2_ability_slug TEXT
    REFERENCES rpg.phb_ability(slug),
  ADD COLUMN IF NOT EXISTS background_boost_plus1_ability_slug TEXT
    REFERENCES rpg.phb_ability(slug);
