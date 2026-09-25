-- Payloads de "concede referência" (magia, talento, idioma, proficiência, tipo de dano).
CREATE TABLE rpg.phb_effect_grant_ref (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  grant_kind TEXT NOT NULL
    CHECK (grant_kind IN ('spell', 'feat', 'language', 'proficiency', 'damage_type')),
  option_key TEXT NULL,
  spell_id BIGINT NULL REFERENCES rpg.phb_spell(id) ON DELETE CASCADE,
  spell_level INTEGER NULL CHECK (spell_level IS NULL OR spell_level BETWEEN 0 AND 9),
  feat_category TEXT NULL
    CHECK (feat_category IS NULL OR length(trim(feat_category)) > 0),
  language_slug TEXT NULL REFERENCES rpg.phb_language(slug),
  choice_count INTEGER NULL CHECK (choice_count IS NULL OR choice_count >= 1),
  proficiency_kind rpg.effect_proficiency_kind NULL,
  damage_type_slug TEXT NULL
    CHECK (damage_type_slug IS NULL OR length(trim(damage_type_slug)) > 0),
  CONSTRAINT phb_effect_grant_ref_columns_by_kind CHECK (
    (grant_kind = 'spell' OR (spell_id IS NULL AND spell_level IS NULL))
    AND (grant_kind = 'feat' OR feat_category IS NULL)
    AND (grant_kind = 'language' OR (language_slug IS NULL AND choice_count IS NULL))
    AND (grant_kind = 'proficiency' OR proficiency_kind IS NULL)
    AND (grant_kind = 'damage_type' OR damage_type_slug IS NULL)
  ),
  CONSTRAINT phb_effect_grant_ref_target CHECK (
    (grant_kind = 'spell' AND (spell_id IS NOT NULL OR option_key IS NOT NULL))
    OR (grant_kind = 'feat' AND option_key IS NOT NULL)
    OR (grant_kind = 'language' AND choice_count IS NOT NULL
        AND (language_slug IS NOT NULL OR option_key IS NOT NULL))
    OR (grant_kind = 'proficiency' AND option_key IS NOT NULL AND proficiency_kind IS NOT NULL)
    OR (grant_kind = 'damage_type' AND (damage_type_slug IS NOT NULL OR option_key IS NOT NULL))
  )
);
