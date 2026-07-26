-- Catálogo estruturado de bônus permanentes de PV e Defesa sem Armadura
-- (antes hardcoded em hit-points.calc.ts e armor-class.ts)

-- Bônus permanentes de PV máximo vindos de espécie, subclasse ou talento.
-- Exatamente uma origem por linha (species/subclass/feat).
CREATE TABLE IF NOT EXISTS rpg.phb_hp_bonus_source (
  id BIGSERIAL PRIMARY KEY,
  species_id BIGINT REFERENCES rpg.phb_species(id) ON DELETE CASCADE,
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  feat_id BIGINT REFERENCES rpg.phb_feat(id) ON DELETE CASCADE,
  label TEXT NOT NULL,
  flat_bonus INTEGER NOT NULL DEFAULT 0,
  per_level_bonus INTEGER NOT NULL DEFAULT 0,
  from_level INTEGER NOT NULL DEFAULT 1 CHECK (from_level >= 1),
  CONSTRAINT phb_hp_bonus_source_single_owner CHECK (
    (species_id IS NOT NULL)::int
    + (subclass_id IS NOT NULL)::int
    + (feat_id IS NOT NULL)::int = 1
  )
);

-- Defesa sem Armadura por classe ou subclasse (substitui a CA base sem armadura).
-- Exatamente uma origem por linha (class/subclass).
CREATE TABLE IF NOT EXISTS rpg.phb_unarmored_defense (
  id BIGSERIAL PRIMARY KEY,
  class_id BIGINT REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  label TEXT NOT NULL,
  second_ability_slug TEXT NOT NULL REFERENCES rpg.phb_ability(slug),
  allows_shield BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT phb_unarmored_defense_single_owner CHECK (
    (class_id IS NOT NULL)::int + (subclass_id IS NOT NULL)::int = 1
  )
);
