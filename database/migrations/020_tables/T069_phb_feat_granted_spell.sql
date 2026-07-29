-- Magias estruturadas de espécie/linhagem/legado + talentos com magia fixa

-- Talentos com magia fixa além das opções (fey/shadow touched)
CREATE TABLE IF NOT EXISTS rpg.phb_feat_granted_spell (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  spell_id BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  PRIMARY KEY (feat_id, spell_id)
);
