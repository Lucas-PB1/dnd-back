CREATE TABLE rpg.game_actor (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_user_id UUID NOT NULL,
  campaign_id UUID REFERENCES rpg.campaign(id) ON DELETE SET NULL,
  parent_character_id UUID REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  actor_kind rpg.actor_kind NOT NULL,
  template_slug TEXT,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  hit_points_max INT CHECK (hit_points_max IS NULL OR hit_points_max >= 0),
  hit_points_current INT CHECK (hit_points_current IS NULL OR hit_points_current >= 0),
  armor_class INT,
  initiative_modifier INT,
  proficiency_bonus INT CHECK (proficiency_bonus IS NULL OR proficiency_bonus BETWEEN 0 AND 9),
  ability_scores JSONB NOT NULL DEFAULT '{"forca":10,"destreza":10,"constituicao":10,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb,
  size_slug TEXT,
  notes TEXT,
  spellcasting_ability_slug TEXT REFERENCES rpg.phb_ability(slug),
  spell_save_dc INT CHECK (spell_save_dc IS NULL OR spell_save_dc BETWEEN 1 AND 40),
  spell_attack_bonus INT CHECK (spell_attack_bonus IS NULL OR spell_attack_bonus BETWEEN -10 AND 30),
  damage_threshold INT CHECK (damage_threshold IS NULL OR damage_threshold >= 0),
  crew_capacity INT CHECK (crew_capacity IS NULL OR crew_capacity >= 0),
  cargo_capacity_lb INT CHECK (cargo_capacity_lb IS NULL OR cargo_capacity_lb >= 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  passenger_capacity INT CHECK (passenger_capacity IS NULL OR passenger_capacity >= 0),
  CONSTRAINT game_actor_hp_current_lte_max CHECK (
    hit_points_current IS NULL
    OR hit_points_max IS NULL
    OR hit_points_current <= hit_points_max
  ),
  CONSTRAINT game_actor_companion_requires_parent CHECK (
    actor_kind <> 'companion'::rpg.actor_kind
    OR parent_character_id IS NOT NULL
  )
);

CREATE INDEX idx_game_actor_owner_user_id ON rpg.game_actor(owner_user_id);
CREATE INDEX idx_game_actor_campaign_id ON rpg.game_actor(campaign_id)
  WHERE campaign_id IS NOT NULL;
CREATE INDEX idx_game_actor_parent_character_id ON rpg.game_actor(parent_character_id)
  WHERE parent_character_id IS NOT NULL;
