-- Colunas estruturadas: salvaguarda e ataque mágico nas magias.

ALTER TABLE rpg.phb_spell
  ADD COLUMN IF NOT EXISTS save_ability_id BIGINT REFERENCES rpg.phb_ability(id),
  ADD COLUMN IF NOT EXISTS requires_attack_roll BOOLEAN NOT NULL DEFAULT FALSE;
