-- Escala tipada fora do template (binding ≠ identidade).
-- by_level: companion BM/Primal · by_slot: Summon / Find Steed.

CREATE TABLE IF NOT EXISTS rpg.phb_creature_scale_by_level (
  template_slug TEXT PRIMARY KEY
    REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  hp_base INT NOT NULL CHECK (hp_base >= 0),
  hp_per_level INT NOT NULL CHECK (hp_per_level >= 0),
  ac_ability_slug TEXT REFERENCES rpg.phb_ability(slug)
);

COMMENT ON TABLE rpg.phb_creature_scale_by_level IS
  'Escala de combate por nível do personagem (CA base = template.armor_class + mod do atributo).';

CREATE TABLE IF NOT EXISTS rpg.phb_creature_scale_by_slot (
  template_slug TEXT PRIMARY KEY
    REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  scale_min_slot INT NOT NULL CHECK (scale_min_slot BETWEEN 0 AND 20),
  ac_base INT NOT NULL CHECK (ac_base BETWEEN 0 AND 40),
  ac_per_slot INT NOT NULL CHECK (ac_per_slot BETWEEN 0 AND 10),
  hp_base INT NOT NULL CHECK (hp_base >= 0),
  hp_per_slot INT NOT NULL CHECK (hp_per_slot >= 0),
  hp_mode TEXT NOT NULL CHECK (hp_mode IN ('per_slot', 'above_min'))
);

COMMENT ON TABLE rpg.phb_creature_scale_by_slot IS
  'Escala de combate por círculo do slot: AC = ac_base + ac_per_slot × L; HP per_slot ou above_min.';

-- Migrar dados existentes (se colunas legadas ainda existirem).
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'rpg' AND table_name = 'phb_creature_template'
      AND column_name = 'companion_hp_base'
  ) THEN
    INSERT INTO rpg.phb_creature_scale_by_level (
      template_slug, hp_base, hp_per_level, ac_ability_slug
    )
    SELECT slug, companion_hp_base, companion_hp_per_level, companion_ac_ability_slug
    FROM rpg.phb_creature_template
    WHERE companion_hp_base IS NOT NULL
      AND companion_hp_per_level IS NOT NULL
    ON CONFLICT (template_slug) DO UPDATE SET
      hp_base = EXCLUDED.hp_base,
      hp_per_level = EXCLUDED.hp_per_level,
      ac_ability_slug = EXCLUDED.ac_ability_slug;

    ALTER TABLE rpg.phb_creature_template
      DROP COLUMN IF EXISTS companion_hp_base,
      DROP COLUMN IF EXISTS companion_hp_per_level,
      DROP COLUMN IF EXISTS companion_ac_ability_slug;
  END IF;

  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'rpg' AND table_name = 'phb_creature_template'
      AND column_name = 'spirit_hp_base'
  ) THEN
    INSERT INTO rpg.phb_creature_scale_by_slot (
      template_slug, scale_min_slot, ac_base, ac_per_slot,
      hp_base, hp_per_slot, hp_mode
    )
    SELECT slug,
      COALESCE(spirit_scale_min_slot, 0),
      spirit_ac_base,
      spirit_ac_per_slot,
      spirit_hp_base,
      spirit_hp_per_slot,
      spirit_hp_mode
    FROM rpg.phb_creature_template
    WHERE spirit_ac_base IS NOT NULL
      AND spirit_ac_per_slot IS NOT NULL
      AND spirit_hp_base IS NOT NULL
      AND spirit_hp_per_slot IS NOT NULL
      AND spirit_hp_mode IS NOT NULL
    ON CONFLICT (template_slug) DO UPDATE SET
      scale_min_slot = EXCLUDED.scale_min_slot,
      ac_base = EXCLUDED.ac_base,
      ac_per_slot = EXCLUDED.ac_per_slot,
      hp_base = EXCLUDED.hp_base,
      hp_per_slot = EXCLUDED.hp_per_slot,
      hp_mode = EXCLUDED.hp_mode;

    ALTER TABLE rpg.phb_creature_template
      DROP COLUMN IF EXISTS spirit_scale_min_slot,
      DROP COLUMN IF EXISTS spirit_ac_base,
      DROP COLUMN IF EXISTS spirit_ac_per_slot,
      DROP COLUMN IF EXISTS spirit_hp_base,
      DROP COLUMN IF EXISTS spirit_hp_per_slot,
      DROP COLUMN IF EXISTS spirit_hp_mode;
  END IF;
END $$;
