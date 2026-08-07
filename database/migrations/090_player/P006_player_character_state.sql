-- Estado de mesa (slots gastos, concentração, condições, HP temporário)
-- Lote A: phb_condition is now a VALUES view (enum rpg.condition_slug defined in 002_types)

DROP VIEW IF EXISTS rpg.v_phb_condition;

CREATE VIEW rpg.v_phb_condition AS
SELECT slug, name FROM (VALUES
  ('blinded'::rpg.condition_slug, 'Cegueira'),
  ('charmed'::rpg.condition_slug, 'Enfeitiçado'),
  ('deafened'::rpg.condition_slug, 'Surdez'),
  ('exhaustion'::rpg.condition_slug, 'Exaustão'),
  ('frightened'::rpg.condition_slug, 'Amedrontado'),
  ('grappled'::rpg.condition_slug, 'Agarrado'),
  ('incapacitated'::rpg.condition_slug, 'Incapacitado'),
  ('invisible'::rpg.condition_slug, 'Invisível'),
  ('paralyzed'::rpg.condition_slug, 'Paralisado'),
  ('petrified'::rpg.condition_slug, 'Petrificado'),
  ('poisoned'::rpg.condition_slug, 'Envenenado'),
  ('prone'::rpg.condition_slug, 'Caído'),
  ('restrained'::rpg.condition_slug, 'Restringido'),
  ('stunned'::rpg.condition_slug, 'Atordoado'),
  ('unconscious'::rpg.condition_slug, 'Inconsciente')
) AS t(slug, name);

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
  high_elf_cantrip_swap_available BOOLEAN NOT NULL DEFAULT false
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
