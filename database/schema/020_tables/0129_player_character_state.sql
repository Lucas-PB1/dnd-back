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
  wild_shape_actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE SET NULL,
  boarded_actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE SET NULL,
  /** Transe do Cavaleiro da Pele (Primal Spirit nv.10): companheiro possuído. */
  skinrider_actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE SET NULL,
  /** Circunstâncias de mesa (snow_ice | in_water | extreme_cold) — toggles de ficha. */
  mesa_circumstances TEXT[] NOT NULL DEFAULT '{}',
  /**
   * Estado por feature, esparso (chave ausente = default). Chaves e defaults em
   * src/game/session/domain/character-feature-state.ts — poder novo = chave nova, não coluna.
   */
  feature_state JSONB NOT NULL DEFAULT '{}'::jsonb,
  CONSTRAINT player_character_state_feature_state_object
    CHECK (jsonb_typeof(feature_state) = 'object'),
  CONSTRAINT player_character_state_bestial_aspect_level
    CHECK (
      NOT feature_state ? 'bestialAspectLevel'
      OR (feature_state->>'bestialAspectLevel')::int BETWEEN 0 AND 5
    )
);

CREATE INDEX idx_player_character_state_concentration
  ON rpg.player_character_state(concentrating_on)
  WHERE concentrating_on IS NOT NULL;

CREATE INDEX idx_player_character_state_boarded_actor
  ON rpg.player_character_state(boarded_actor_id)
  WHERE boarded_actor_id IS NOT NULL;

CREATE INDEX idx_player_character_state_skinrider_actor
  ON rpg.player_character_state(skinrider_actor_id)
  WHERE skinrider_actor_id IS NOT NULL;
