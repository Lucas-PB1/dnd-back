-- Magias estruturadas de espécie/linhagem/legado + talentos com magia fixa

-- Elfo / Tiferino: truque L1 (antes só em level1_benefit texto)
ALTER TABLE rpg.phb_elf_lineage
  ADD COLUMN IF NOT EXISTS spell_level1_id BIGINT REFERENCES rpg.phb_spell(id);

ALTER TABLE rpg.phb_infernal_legacy
  ADD COLUMN IF NOT EXISTS spell_level1_id BIGINT REFERENCES rpg.phb_spell(id);

-- Gnomo: até 2 magias da linhagem (antes só em level1_benefit texto)
ALTER TABLE rpg.phb_gnome_lineage
  ADD COLUMN IF NOT EXISTS spell_1_id BIGINT REFERENCES rpg.phb_spell(id),
  ADD COLUMN IF NOT EXISTS spell_2_id BIGINT REFERENCES rpg.phb_spell(id);

-- Traço de espécie com magia fixa (aasimar Luz, tiferino Taumaturgia)
ALTER TABLE rpg.phb_species_trait
  ADD COLUMN IF NOT EXISTS spell_id BIGINT REFERENCES rpg.phb_spell(id);

-- Talentos com magia fixa além das opções (fey/shadow touched)
CREATE TABLE IF NOT EXISTS rpg.phb_feat_granted_spell (
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  spell_id BIGINT NOT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  PRIMARY KEY (feat_id, spell_id)
);
