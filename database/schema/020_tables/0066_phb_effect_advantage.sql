-- Vantagem em teste (perícia/atributo/circunstância) ou em salvaguarda (atributos/condição).
CREATE TABLE rpg.phb_effect_advantage (
  effect_id BIGINT PRIMARY KEY
    REFERENCES rpg.phb_effect(id) ON DELETE CASCADE,
  advantage_kind TEXT NOT NULL CHECK (advantage_kind IN ('check', 'save')),
  skill_slug TEXT NULL,
  circumstance_tag TEXT NULL,
  ability_slug TEXT NULL,
  ability_slugs TEXT[] NULL,
  condition_slug TEXT NULL
    CHECK (condition_slug IS NULL OR length(trim(condition_slug)) > 0),
  CONSTRAINT phb_effect_advantage_shape CHECK (
    (advantage_kind = 'check'
      AND (skill_slug IS NOT NULL OR circumstance_tag IS NOT NULL OR ability_slug IS NOT NULL)
      AND ability_slugs IS NULL AND condition_slug IS NULL)
    OR (advantage_kind = 'save'
      AND (ability_slugs IS NOT NULL OR condition_slug IS NOT NULL)
      AND skill_slug IS NULL AND circumstance_tag IS NULL AND ability_slug IS NULL)
  )
);
