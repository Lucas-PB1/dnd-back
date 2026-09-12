-- Gaps veículos/companions: slug barco-de-quilha + colunas de escala de companion.

-- Renomeia item tipográfico (quilla → quilha) preservando inventário / FKs por slug.
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM rpg.phb_item WHERE slug = 'barco-de-quilla'
  ) AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_item WHERE slug = 'barco-de-quilha'
  ) THEN
    UPDATE rpg.player_character_item
      SET item_slug = 'barco-de-quilha'
      WHERE item_slug = 'barco-de-quilla';
    UPDATE rpg.player_character_equipment
      SET item_slug = 'barco-de-quilha'
      WHERE item_slug = 'barco-de-quilla';
    UPDATE rpg.phb_item_catalog_stats
      SET item_slug = 'barco-de-quilha'
      WHERE item_slug = 'barco-de-quilla';
    UPDATE rpg.phb_item
      SET slug = 'barco-de-quilha'
      WHERE slug = 'barco-de-quilla';
  ELSIF EXISTS (
    SELECT 1 FROM rpg.phb_item WHERE slug = 'barco-de-quilla'
  ) AND EXISTS (
    SELECT 1 FROM rpg.phb_item WHERE slug = 'barco-de-quilha'
  ) THEN
    -- Ambos presentes (seed parcial): aponta runtime para o canônico e remove o typo.
    UPDATE rpg.player_character_item
      SET item_slug = 'barco-de-quilha'
      WHERE item_slug = 'barco-de-quilla';
    UPDATE rpg.player_character_equipment
      SET item_slug = 'barco-de-quilha'
      WHERE item_slug = 'barco-de-quilla';
    DELETE FROM rpg.phb_item_catalog_stats WHERE item_slug = 'barco-de-quilla';
    DELETE FROM rpg.phb_item WHERE slug = 'barco-de-quilla';
  END IF;
END $$;

-- Escala de companheiro (Beast Master / Primal Spirit): HP = base + per_level × nível; AC = base + mod da habilidade.
ALTER TABLE rpg.phb_creature_template
  ADD COLUMN IF NOT EXISTS companion_hp_base INT
    CHECK (companion_hp_base IS NULL OR companion_hp_base >= 0),
  ADD COLUMN IF NOT EXISTS companion_hp_per_level INT
    CHECK (companion_hp_per_level IS NULL OR companion_hp_per_level >= 0),
  ADD COLUMN IF NOT EXISTS companion_ac_ability_slug TEXT
    REFERENCES rpg.phb_ability(slug);

COMMENT ON COLUMN rpg.phb_creature_template.companion_hp_base IS
  'Quando preenchido com companion_hp_per_level: HP máx do actor = base + per_level × nível do personagem.';
COMMENT ON COLUMN rpg.phb_creature_template.companion_ac_ability_slug IS
  'Quando preenchido: AC do actor = armor_class + modificador dessa habilidade do personagem.';
