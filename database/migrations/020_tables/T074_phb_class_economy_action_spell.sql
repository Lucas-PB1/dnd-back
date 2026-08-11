-- Fase 6: liga economy action → magia do catálogo (cast de item).
ALTER TABLE rpg.phb_class_economy_action
  ADD COLUMN IF NOT EXISTS spell_slug TEXT NULL
  REFERENCES rpg.phb_spell(slug);

CREATE INDEX IF NOT EXISTS idx_class_economy_action_spell
  ON rpg.phb_class_economy_action(spell_slug)
  WHERE spell_slug IS NOT NULL;
