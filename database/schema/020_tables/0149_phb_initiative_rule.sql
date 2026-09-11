-- Regras de iniciativa por classe/subclasse (bônus de atributo ou vantagem).

CREATE TABLE IF NOT EXISTS rpg.phb_initiative_rule (
  id BIGSERIAL PRIMARY KEY,
  owner_kind TEXT NOT NULL CHECK (owner_kind IN ('class', 'subclass')),
  class_id BIGINT REFERENCES rpg.phb_class(id) ON DELETE CASCADE,
  subclass_id BIGINT REFERENCES rpg.phb_subclass(id) ON DELETE CASCADE,
  unlock_level INTEGER NOT NULL CHECK (unlock_level BETWEEN 1 AND 20),
  rule_kind TEXT NOT NULL CHECK (rule_kind IN ('ability_bonus', 'advantage')),
  ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  label TEXT NOT NULL,
  CONSTRAINT phb_initiative_rule_owner CHECK (
    (owner_kind = 'class' AND class_id IS NOT NULL AND subclass_id IS NULL)
    OR (owner_kind = 'subclass' AND subclass_id IS NOT NULL AND class_id IS NULL)
  ),
  CONSTRAINT phb_initiative_rule_ability CHECK (
    (rule_kind = 'ability_bonus' AND ability_slug IS NOT NULL)
    OR (rule_kind = 'advantage' AND ability_slug IS NULL)
  )
);

CREATE UNIQUE INDEX idx_phb_initiative_rule_class_unique
  ON rpg.phb_initiative_rule (class_id, rule_kind, unlock_level, COALESCE(ability_slug, ''))
  WHERE class_id IS NOT NULL;

CREATE UNIQUE INDEX idx_phb_initiative_rule_subclass_unique
  ON rpg.phb_initiative_rule (subclass_id, rule_kind, unlock_level, COALESCE(ability_slug, ''))
  WHERE subclass_id IS NOT NULL;
