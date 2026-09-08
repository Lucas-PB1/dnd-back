CREATE TABLE rpg.phb_metamagic (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  cost SMALLINT NOT NULL CHECK (cost IN (1, 2)),
  stacks_with_other BOOLEAN NOT NULL DEFAULT FALSE,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_phb_metamagic_sort
  ON rpg.phb_metamagic(sort_order);

-- Recover 1dN ao Descanso Longo (amanhecer) para pools de cargas de item.


-- Fase 6: liga economy action → magia do catálogo (cast de item).


CREATE INDEX idx_class_economy_action_spell
  ON rpg.phb_class_economy_action(spell_slug)
  WHERE spell_slug IS NOT NULL;

-- Tabelas 1d100 de propriedades aleatórias de Artefato (DMG Treasure).
