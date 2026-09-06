CREATE TABLE rpg.phb_character_thread_milestone_benefit (
  id BIGSERIAL PRIMARY KEY,
  milestone_id BIGINT NOT NULL REFERENCES rpg.phb_character_thread_milestone(id) ON DELETE CASCADE,
  benefit_key TEXT NOT NULL CHECK (char_length(benefit_key) BETWEEN 1 AND 64),
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  description TEXT NOT NULL,
  choice_group TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  UNIQUE (milestone_id, benefit_key)
);

CREATE INDEX idx_phb_character_thread_goal_thread
  ON rpg.phb_character_thread_goal(thread_slug);
CREATE INDEX idx_phb_character_thread_milestone_thread
  ON rpg.phb_character_thread_milestone(thread_slug);
CREATE INDEX idx_phb_character_thread_milestone_benefit_ms
  ON rpg.phb_character_thread_milestone_benefit(milestone_id);
