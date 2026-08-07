-- Lote G: bônus permanentes de PV e Defesa sem Armadura unificados

CREATE TABLE rpg.phb_combat_modifier (
  id BIGSERIAL PRIMARY KEY,
  kind rpg.combat_modifier_kind NOT NULL,
  owner_kind rpg.combat_modifier_owner NOT NULL,
  owner_id BIGINT NOT NULL,
  label TEXT NOT NULL,
  flat_bonus INTEGER NOT NULL DEFAULT 0,
  per_level_bonus INTEGER NOT NULL DEFAULT 0,
  from_level INTEGER NOT NULL DEFAULT 1 CHECK (from_level >= 1),
  second_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  allows_shield BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT pcm_kind_fields CHECK (
    (kind = 'hp_bonus' AND second_ability_slug IS NULL
      AND owner_kind IN ('species', 'subclass', 'feat'))
    OR (kind = 'unarmored_defense' AND second_ability_slug IS NOT NULL
      AND flat_bonus = 0 AND per_level_bonus = 0
      AND owner_kind IN ('class', 'subclass'))
  )
);

CREATE INDEX idx_phb_combat_modifier_owner
  ON rpg.phb_combat_modifier(kind, owner_kind, owner_id);
