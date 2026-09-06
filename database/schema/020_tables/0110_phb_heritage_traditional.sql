CREATE TABLE rpg.phb_heritage_traditional (
  id BIGSERIAL PRIMARY KEY,
  heritage_id BIGINT NOT NULL REFERENCES rpg.phb_heritage(id) ON DELETE CASCADE,
  trait_id BIGINT NOT NULL REFERENCES rpg.phb_heritage_trait(id) ON DELETE CASCADE,
  sort_order INTEGER NOT NULL DEFAULT 0,
  category_hint rpg.heritage_trait_category,
  UNIQUE (heritage_id, trait_id)
);

CREATE INDEX idx_phb_heritage_traditional_heritage
  ON rpg.phb_heritage_traditional(heritage_id, sort_order);

COMMENT ON TABLE rpg.phb_heritage_traditional IS
  'Preset recomendado por heranÃ§a (3+3+2 combate/exploraÃ§Ã£o/interpretaÃ§Ã£o) â€” atalho no wizard.';



-- FunÃ§Ã£o de auditoria updated_at
