-- Tabela rpg.phb_feat_benefit

CREATE TABLE rpg.phb_feat_benefit (
  id BIGSERIAL PRIMARY KEY,
  feat_id BIGINT NOT NULL REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  sort_order INTEGER NOT NULL CHECK (sort_order >= 1),
  name TEXT,
  description TEXT NOT NULL,
  UNIQUE (feat_id, sort_order)
);
