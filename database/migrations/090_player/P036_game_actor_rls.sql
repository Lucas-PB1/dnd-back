-- RLS para game_actor* (espelha player_character; dono + campanha via app)

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping game_actor RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.game_actor ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.game_actor_speed ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.game_actor_action ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.game_actor_spell ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.game_actor_state ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS game_actor_own ON rpg.game_actor;
  CREATE POLICY game_actor_own ON rpg.game_actor
    FOR ALL USING (owner_user_id = auth.uid())
    WITH CHECK (owner_user_id = auth.uid());

  DROP POLICY IF EXISTS game_actor_speed_own ON rpg.game_actor_speed;
  CREATE POLICY game_actor_speed_own ON rpg.game_actor_speed
    FOR ALL USING (
      actor_id IN (SELECT id FROM rpg.game_actor WHERE owner_user_id = auth.uid())
    );

  DROP POLICY IF EXISTS game_actor_action_own ON rpg.game_actor_action;
  CREATE POLICY game_actor_action_own ON rpg.game_actor_action
    FOR ALL USING (
      actor_id IN (SELECT id FROM rpg.game_actor WHERE owner_user_id = auth.uid())
    );

  DROP POLICY IF EXISTS game_actor_spell_own ON rpg.game_actor_spell;
  CREATE POLICY game_actor_spell_own ON rpg.game_actor_spell
    FOR ALL USING (
      actor_id IN (SELECT id FROM rpg.game_actor WHERE owner_user_id = auth.uid())
    );

  DROP POLICY IF EXISTS game_actor_state_own ON rpg.game_actor_state;
  CREATE POLICY game_actor_state_own ON rpg.game_actor_state
    FOR ALL USING (
      actor_id IN (SELECT id FROM rpg.game_actor WHERE owner_user_id = auth.uid())
    );
END $$;
