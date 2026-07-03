-- RLS para tabelas de jogador (Supabase — requer schema auth)

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player RLS — auth schema not present (local Postgres)';
    RETURN;
  END IF;

  ALTER TABLE rpg.player_character ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_skill ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_species_choice ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_subclass_option ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_feat ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_spell ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_equipment ENABLE ROW LEVEL SECURITY;
  ALTER TABLE rpg.player_character_language ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_own ON rpg.player_character;
  CREATE POLICY player_character_own ON rpg.player_character
    FOR ALL USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());

  DROP POLICY IF EXISTS player_character_skill_own ON rpg.player_character_skill;
  CREATE POLICY player_character_skill_own ON rpg.player_character_skill
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_species_choice_own ON rpg.player_character_species_choice;
  CREATE POLICY player_character_species_choice_own ON rpg.player_character_species_choice
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_subclass_option_own ON rpg.player_character_subclass_option;
  CREATE POLICY player_character_subclass_option_own ON rpg.player_character_subclass_option
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_feat_own ON rpg.player_character_feat;
  CREATE POLICY player_character_feat_own ON rpg.player_character_feat
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_spell_own ON rpg.player_character_spell;
  CREATE POLICY player_character_spell_own ON rpg.player_character_spell
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_equipment_own ON rpg.player_character_equipment;
  CREATE POLICY player_character_equipment_own ON rpg.player_character_equipment
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );

  DROP POLICY IF EXISTS player_character_language_own ON rpg.player_character_language;
  CREATE POLICY player_character_language_own ON rpg.player_character_language
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );
END $$;
