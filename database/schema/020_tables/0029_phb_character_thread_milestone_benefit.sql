CREATE TABLE rpg.phb_character_thread_milestone_benefit (
  id BIGSERIAL PRIMARY KEY,
  milestone_id BIGINT NOT NULL REFERENCES rpg.phb_character_thread_milestone(id) ON DELETE CASCADE,
  benefit_key TEXT NOT NULL CHECK (char_length(benefit_key) BETWEEN 1 AND 64),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
  choice_group TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  bracket_max_kept INTEGER CHECK (bracket_max_kept IS NULL OR bracket_max_kept >= 1),
  bracket_roll_kinds TEXT[],
  bracket_trigger_note TEXT
    CHECK (bracket_trigger_note IS NULL OR length(trim(bracket_trigger_note)) > 0),
  spend_side_effect_note TEXT
    CHECK (spend_side_effect_note IS NULL OR length(trim(spend_side_effect_note)) > 0),
  UNIQUE (milestone_id, benefit_key)
);

CREATE INDEX idx_phb_character_thread_goal_thread
  ON rpg.phb_character_thread_goal(thread_slug);
CREATE INDEX idx_phb_character_thread_milestone_thread
  ON rpg.phb_character_thread_milestone(thread_slug);
CREATE INDEX idx_phb_character_thread_milestone_benefit_ms
  ON rpg.phb_character_thread_milestone_benefit(milestone_id);
