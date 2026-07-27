-- RLS para campanhas (Supabase — requer schema auth)

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping campaign RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.campaign ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.campaign_member ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.campaign_character ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS campaign_member_select ON rpg.campaign;
  CREATE POLICY campaign_member_select ON rpg.campaign
    FOR SELECT USING (
      id IN (SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS campaign_creator_insert ON rpg.campaign;
  CREATE POLICY campaign_creator_insert ON rpg.campaign
    FOR INSERT WITH CHECK (created_by = auth.uid());

  DROP POLICY IF EXISTS campaign_dm_update ON rpg.campaign;
  CREATE POLICY campaign_dm_update ON rpg.campaign
    FOR UPDATE USING (
      id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role = 'dm'
      )
    );

  DROP POLICY IF EXISTS campaign_dm_delete ON rpg.campaign;
  CREATE POLICY campaign_dm_delete ON rpg.campaign
    FOR DELETE USING (
      id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role = 'dm'
      )
    );

  DROP POLICY IF EXISTS campaign_member_own ON rpg.campaign_member;
  CREATE POLICY campaign_member_own ON rpg.campaign_member
    FOR SELECT USING (
      user_id = auth.uid()
      OR campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_member_dm_write ON rpg.campaign_member;
  CREATE POLICY campaign_member_dm_write ON rpg.campaign_member
    FOR ALL USING (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role = 'dm'
      )
      OR user_id = auth.uid()
    )
    WITH CHECK (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role = 'dm'
      )
      OR user_id = auth.uid()
    );

  DROP POLICY IF EXISTS campaign_character_member_select ON rpg.campaign_character;
  CREATE POLICY campaign_character_member_select ON rpg.campaign_character
    FOR SELECT USING (
      campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_character_link ON rpg.campaign_character;
  CREATE POLICY campaign_character_link ON rpg.campaign_character
    FOR INSERT WITH CHECK (
      linked_by = auth.uid()
      AND character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
      AND campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member WHERE user_id = auth.uid()
      )
    );

  DROP POLICY IF EXISTS campaign_character_unlink ON rpg.campaign_character;
  CREATE POLICY campaign_character_unlink ON rpg.campaign_character
    FOR DELETE USING (
      linked_by = auth.uid()
      OR character_id IN (
        SELECT id FROM rpg.player_character WHERE user_id = auth.uid()
      )
      OR campaign_id IN (
        SELECT campaign_id FROM rpg.campaign_member
        WHERE user_id = auth.uid() AND role IN ('dm', 'assistant')
      )
    );

  -- Leitura de personagem por membros da campanha (além do dono).
  DROP POLICY IF EXISTS player_character_campaign_read ON rpg.player_character;
  CREATE POLICY player_character_campaign_read ON rpg.player_character
    FOR SELECT USING (
      user_id = auth.uid()
      OR id IN (
        SELECT cc.character_id
        FROM rpg.campaign_character cc
        JOIN rpg.campaign_member cm ON cm.campaign_id = cc.campaign_id
        WHERE cm.user_id = auth.uid()
      )
    );

  -- Escrita por mestre/auxiliar na campanha (dono já coberto por player_character_own).
  DROP POLICY IF EXISTS player_character_campaign_write ON rpg.player_character;
  CREATE POLICY player_character_campaign_write ON rpg.player_character
    FOR UPDATE USING (
      user_id = auth.uid()
      OR id IN (
        SELECT cc.character_id
        FROM rpg.campaign_character cc
        JOIN rpg.campaign_member cm ON cm.campaign_id = cc.campaign_id
        WHERE cm.user_id = auth.uid() AND cm.role IN ('dm', 'assistant')
      )
    );
END $$;
