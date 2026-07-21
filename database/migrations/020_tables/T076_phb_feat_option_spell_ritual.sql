-- Filtro ritual para opções de magia em talentos (Conjurador Ritualista)

ALTER TABLE rpg.phb_feat_option_def
  ADD COLUMN IF NOT EXISTS spell_ritual_only BOOLEAN NOT NULL DEFAULT FALSE;
