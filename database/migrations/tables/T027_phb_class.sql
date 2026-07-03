-- Tabela rpg.phb_class

CREATE TABLE rpg.phb_class (
  id BIGSERIAL PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  tagline TEXT,
  summary TEXT,
  description TEXT,
  primary_ability_label TEXT,
  primary_ability_operator TEXT CHECK (primary_ability_operator IN ('or', 'and')),
  hit_die_id BIGINT NOT NULL REFERENCES rpg.phb_hit_die(id),
  hp_level1_die_value INTEGER CHECK (hp_level1_die_value >= 0),
  hp_fixed_per_level INTEGER CHECK (hp_fixed_per_level >= 0),
  hp_minimum_gain_per_level INTEGER CHECK (hp_minimum_gain_per_level >= 1),
  hp_constitution_mod_applies BOOLEAN NOT NULL DEFAULT TRUE,
  subclass_unlock_level INTEGER NOT NULL DEFAULT 3 CHECK (subclass_unlock_level >= 1),
  subclass_label TEXT,
  skill_choice_count INTEGER CHECK (skill_choice_count >= 1),
  skill_choice_from TEXT CHECK (skill_choice_from IN ('any')),
  spell_slot_pattern_id BIGINT REFERENCES rpg.phb_spell_slot_pattern(id),
  source_citation_id BIGINT REFERENCES rpg.phb_source_citation(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
