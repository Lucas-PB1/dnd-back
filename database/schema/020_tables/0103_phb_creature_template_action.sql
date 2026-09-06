CREATE TABLE rpg.phb_creature_template_action (
  id BIGSERIAL PRIMARY KEY,
  template_slug TEXT NOT NULL REFERENCES rpg.phb_creature_template(slug) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  action_bucket rpg.actor_action_bucket NOT NULL DEFAULT 'action',
  attack_bonus INT,
  damage_expression TEXT,
  reach_ft INT CHECK (reach_ft IS NULL OR reach_ft >= 0),
  sort_order INT NOT NULL DEFAULT 0,
  description TEXT
);

CREATE INDEX idx_phb_creature_template_action_slug
  ON rpg.phb_creature_template_action(template_slug);
