-- Estado de mesa (slots gastos, concentração, condições, HP temporário)

CREATE TABLE rpg.phb_condition (
  slug TEXT PRIMARY KEY,
  name TEXT NOT NULL
);

INSERT INTO rpg.phb_condition (slug, name) VALUES
  ('blinded', 'Cegueira'),
  ('charmed', 'Enfeitiçado'),
  ('deafened', 'Surdez'),
  ('exhaustion', 'Exaustão'),
  ('frightened', 'Amedrontado'),
  ('grappled', 'Agarrado'),
  ('incapacitated', 'Incapacitado'),
  ('invisible', 'Invisível'),
  ('paralyzed', 'Paralisado'),
  ('petrified', 'Petrificado'),
  ('poisoned', 'Envenenado'),
  ('prone', 'Caído'),
  ('restrained', 'Restringido'),
  ('stunned', 'Atordoado'),
  ('unconscious', 'Inconsciente');

CREATE TABLE rpg.player_character_state (
  character_id UUID PRIMARY KEY REFERENCES rpg.player_character(id) ON DELETE CASCADE,
  spell_slots_used JSONB NOT NULL DEFAULT '{}',
  concentrating_on TEXT,
  conditions TEXT[] NOT NULL DEFAULT '{}',
  temp_hp INT NOT NULL DEFAULT 0 CHECK (temp_hp >= 0)
);

CREATE INDEX idx_player_character_state_concentration
  ON rpg.player_character_state(concentrating_on)
  WHERE concentrating_on IS NOT NULL;

-- RLS (Supabase)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.schemata WHERE schema_name = 'auth') THEN
    RAISE NOTICE 'Skipping player_character_state RLS — auth schema not present';
    RETURN;
  END IF;

  ALTER TABLE rpg.player_character_state ENABLE ROW LEVEL SECURITY;

  DROP POLICY IF EXISTS player_character_state_own ON rpg.player_character_state;
  CREATE POLICY player_character_state_own ON rpg.player_character_state
    FOR ALL USING (
      character_id IN (SELECT id FROM rpg.player_character WHERE user_id = auth.uid())
    );
END $$;
