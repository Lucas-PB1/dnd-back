CREATE TABLE IF NOT EXISTS rpg.skirmish (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  character_id UUID NOT NULL REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'finished')),
  round INT NOT NULL DEFAULT 1 CHECK (round >= 1),
  turn_attacks_remaining INT CHECK (turn_attacks_remaining IS NULL OR turn_attacks_remaining >= 0),
  current_combatant_id UUID,
  combat_log JSONB NOT NULL DEFAULT '[]'::jsonb,
  winner_kind TEXT CHECK (winner_kind IS NULL OR winner_kind IN ('pc', 'actor')),
  end_reason TEXT CHECK (end_reason IS NULL OR end_reason IN ('hp', 'forfeit')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_skirmish_user_id ON rpg.skirmish(user_id);
CREATE INDEX IF NOT EXISTS idx_skirmish_character_id ON rpg.skirmish(character_id);

CREATE UNIQUE INDEX IF NOT EXISTS uq_skirmish_one_active_per_user
  ON rpg.skirmish(user_id)
  WHERE status = 'active';

CREATE TABLE IF NOT EXISTS rpg.skirmish_combatant (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  skirmish_id UUID NOT NULL REFERENCES rpg.skirmish(id) ON DELETE CASCADE,
  kind TEXT NOT NULL CHECK (kind IN ('pc', 'actor')),
  character_id UUID REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE CASCADE,
  display_name TEXT NOT NULL CHECK (char_length(display_name) BETWEEN 1 AND 120),
  initiative_total INT,
  initiative_modifier INT,
  sort_order INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT skirmish_combatant_shape_check CHECK (
    (kind = 'pc' AND character_id IS NOT NULL AND actor_id IS NULL)
    OR (kind = 'actor' AND actor_id IS NOT NULL AND character_id IS NULL)
  )
);

CREATE INDEX IF NOT EXISTS idx_skirmish_combatant_skirmish_id
  ON rpg.skirmish_combatant(skirmish_id);

CREATE UNIQUE INDEX IF NOT EXISTS uq_skirmish_pc
  ON rpg.skirmish_combatant(skirmish_id, character_id)
  WHERE character_id IS NOT NULL;

CREATE UNIQUE INDEX IF NOT EXISTS uq_skirmish_actor
  ON rpg.skirmish_combatant(skirmish_id, actor_id)
  WHERE actor_id IS NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'skirmish_current_combatant_fk'
  ) THEN
    ALTER TABLE rpg.skirmish
      ADD CONSTRAINT skirmish_current_combatant_fk
      FOREIGN KEY (current_combatant_id)
      REFERENCES rpg.skirmish_combatant(id)
      ON DELETE SET NULL;
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping skirmish RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.skirmish ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.skirmish_combatant ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS skirmish_owner_select ON rpg.skirmish;
  CREATE POLICY skirmish_owner_select ON rpg.skirmish
    FOR SELECT USING (user_id = auth.uid());

  DROP POLICY IF EXISTS skirmish_owner_insert ON rpg.skirmish;
  CREATE POLICY skirmish_owner_insert ON rpg.skirmish
    FOR INSERT WITH CHECK (
      user_id = auth.uid()
      AND character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS skirmish_owner_update ON rpg.skirmish;
  CREATE POLICY skirmish_owner_update ON rpg.skirmish
    FOR UPDATE USING (user_id = auth.uid());

  DROP POLICY IF EXISTS skirmish_owner_delete ON rpg.skirmish;
  CREATE POLICY skirmish_owner_delete ON rpg.skirmish
    FOR DELETE USING (user_id = auth.uid());

  DROP POLICY IF EXISTS skirmish_combatant_owner_select ON rpg.skirmish_combatant;
  CREATE POLICY skirmish_combatant_owner_select ON rpg.skirmish_combatant
    FOR SELECT USING (
      skirmish_id IN (SELECT id FROM rpg.skirmish WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS skirmish_combatant_owner_write ON rpg.skirmish_combatant;
  CREATE POLICY skirmish_combatant_owner_write ON rpg.skirmish_combatant
    FOR ALL USING (
      skirmish_id IN (SELECT id FROM rpg.skirmish WHERE user_id = auth.uid())
    )
    WITH CHECK (
      skirmish_id IN (SELECT id FROM rpg.skirmish WHERE user_id = auth.uid())
    );
END $$;
