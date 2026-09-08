DO $$
BEGIN
  ALTER TABLE rpg.player_character_thread ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_thread_milestone ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_thread_own ON rpg.player_character_thread;
  CREATE POLICY player_character_thread_own ON rpg.player_character_thread
    FOR ALL USING (
      character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    )
    WITH CHECK (
      character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS player_character_thread_milestone_own ON rpg.player_character_thread_milestone;
  CREATE POLICY player_character_thread_milestone_own ON rpg.player_character_thread_milestone
    FOR ALL USING (
      character_thread_id IN (
        SELECT t.id
          FROM rpg.player_character_thread t
          JOIN rpg.player_character c ON c.id = t.character_id
         WHERE c.user_id = auth.uid()
      )
    )
    WITH CHECK (
      character_thread_id IN (
        SELECT t.id
          FROM rpg.player_character_thread t
          JOIN rpg.player_character c ON c.id = t.character_id
         WHERE c.user_id = auth.uid()
      )
    );
EXCEPTION
  WHEN undefined_function THEN
    -- auth.uid() pode não existir em Postgres local sem Supabase
    NULL;
END $$;

-- Personagem: origem PHB species XOR herança GH + picks modulares









CREATE INDEX idx_player_character_heritage_slug
  ON rpg.player_character(heritage_slug)
  WHERE heritage_slug IS NOT NULL;
