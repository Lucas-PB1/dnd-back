-- Runtime: fichas de mesa além do personagem jogador (criatura, montaria, veículo, companion)

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

CREATE TRIGGER tr_game_actor_updated_at
  BEFORE UPDATE ON rpg.game_actor
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();

CREATE TABLE rpg.game_actor_speed (
  actor_id UUID NOT NULL REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  movement_kind TEXT NOT NULL CHECK (char_length(movement_kind) BETWEEN 1 AND 32),
  speed_ft INT NOT NULL CHECK (speed_ft >= 0),
  PRIMARY KEY (actor_id, movement_kind)
);

CREATE TABLE rpg.game_actor_action (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_id UUID NOT NULL REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  name TEXT NOT NULL CHECK (char_length(name) BETWEEN 1 AND 120),
  action_bucket rpg.actor_action_bucket NOT NULL DEFAULT 'action',
  attack_bonus INT,
  damage_expression TEXT,
  reach_ft INT CHECK (reach_ft IS NULL OR reach_ft >= 0),
  sort_order INT NOT NULL DEFAULT 0
);

CREATE INDEX idx_game_actor_action_actor_id ON rpg.game_actor_action(actor_id);

CREATE TABLE rpg.game_actor_spell (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_id UUID NOT NULL REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  spell_slug TEXT NOT NULL REFERENCES rpg.phb_spell(slug),
  usage_kind rpg.innate_spell_usage NOT NULL,
  uses_per_day INT CHECK (uses_per_day IS NULL OR uses_per_day >= 1),
  slot_level INT CHECK (slot_level IS NULL OR slot_level BETWEEN 0 AND 9),
  recharge_dice TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  UNIQUE (actor_id, spell_slug, usage_kind, slot_level)
);

CREATE TABLE rpg.game_actor_state (
  actor_id UUID PRIMARY KEY REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  conditions TEXT[] NOT NULL DEFAULT '{}',
  temp_hp INT NOT NULL DEFAULT 0 CHECK (temp_hp >= 0),
  concentrating_on TEXT,
  innate_spell_uses JSONB NOT NULL DEFAULT '{}'::jsonb,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TRIGGER tr_game_actor_state_updated_at
  BEFORE UPDATE ON rpg.game_actor_state
  FOR EACH ROW EXECUTE FUNCTION rpg.set_updated_at();
