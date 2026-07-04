-- Filtro de escolas para opções de magia em talentos (Fey/Shadow Touched)

ALTER TABLE rpg.phb_feat_option_def
  ADD COLUMN IF NOT EXISTS spell_school_slugs TEXT[] NULL;
