CREATE TABLE rpg.player_character_state (
  character_id UUID PRIMARY KEY REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  spell_slots_used JSONB NOT NULL DEFAULT '{}',
  concentrating_on TEXT,
  conditions TEXT[] NOT NULL DEFAULT '{}',
  temp_hp INT NOT NULL DEFAULT 0 CHECK (temp_hp >= 0),
  hit_dice_current INT NOT NULL DEFAULT 0 CHECK (hit_dice_current >= 0),
  resources_used JSONB NOT NULL DEFAULT '{}'::jsonb,
  death_save_successes INT NOT NULL DEFAULT 0 CHECK (death_save_successes BETWEEN 0 AND 3),
  death_save_failures INT NOT NULL DEFAULT 0 CHECK (death_save_failures BETWEEN 0 AND 3),
  inspiration BOOLEAN NOT NULL DEFAULT FALSE,
  granted_spell_uses JSONB NOT NULL DEFAULT '{}'::jsonb,
  high_elf_cantrip_swap_available BOOLEAN NOT NULL DEFAULT false,
  firearm_chambers JSONB NOT NULL DEFAULT '{}'::jsonb,
  rage_active BOOLEAN NOT NULL DEFAULT FALSE,
  reckless_active BOOLEAN NOT NULL DEFAULT FALSE,
  persona_masks JSONB NOT NULL DEFAULT '[]'::jsonb,
  bestial_aspect_level INTEGER NOT NULL DEFAULT 0 CHECK (bestial_aspect_level >= 0 AND bestial_aspect_level <= 5),
  missile_shield_armed BOOLEAN NOT NULL DEFAULT false,
  giga_missile_armed BOOLEAN NOT NULL DEFAULT false,
  starry_form_active BOOLEAN NOT NULL DEFAULT FALSE,
  stellar_constellation TEXT NULL,
  /** Mutação Aberrante ativa (Cap. 6): chitinous-shell | eldritch-limbs | slimy-form. */
  aberrant_mutation_active TEXT NULL,
  boarded_actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE SET NULL
);

CREATE INDEX idx_player_character_state_concentration
  ON rpg.player_character_state(concentrating_on)
  WHERE concentrating_on IS NOT NULL;

CREATE INDEX idx_player_character_state_boarded_actor
  ON rpg.player_character_state(boarded_actor_id)
  WHERE boarded_actor_id IS NOT NULL;
