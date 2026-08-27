-- Encontro: combatente actor (FK game_actor) substitui criatura manual

ALTER TABLE rpg.campaign_encounter_combatant
  ADD COLUMN IF NOT EXISTS actor_id UUID REFERENCES rpg.game_actor(id) ON DELETE CASCADE;

-- Backfill: criaturas manuais → game_actor + kind=actor
DO $$
DECLARE
  r RECORD;
  new_actor_id UUID;
BEGIN
  FOR r IN
    SELECT
      cec.id AS combatant_id,
      cec.display_name,
      cec.hp_max,
      cec.hp_current,
      cec.armor_class,
      cec.initiative_modifier,
      ce.created_by,
      ce.campaign_id
    FROM rpg.campaign_encounter_combatant cec
    JOIN rpg.campaign_encounter ce ON ce.id = cec.encounter_id
    WHERE cec.kind = 'creature'
  LOOP
    new_actor_id := gen_random_uuid();

    INSERT INTO rpg.game_actor (
      id,
      owner_user_id,
      campaign_id,
      actor_kind,
      name,
      hit_points_max,
      hit_points_current,
      armor_class,
      initiative_modifier
    ) VALUES (
      new_actor_id,
      r.created_by,
      r.campaign_id,
      'creature'::rpg.actor_kind,
      r.display_name,
      r.hp_max,
      r.hp_current,
      r.armor_class,
      r.initiative_modifier
    );

    INSERT INTO rpg.game_actor_state (actor_id)
    VALUES (new_actor_id);

    UPDATE rpg.campaign_encounter_combatant
    SET
      kind = 'actor',
      actor_id = new_actor_id,
      display_name = NULL,
      hp_current = NULL,
      hp_max = NULL,
      armor_class = NULL
    WHERE id = r.combatant_id;
  END LOOP;
END $$;

ALTER TABLE rpg.campaign_encounter_combatant
  DROP CONSTRAINT IF EXISTS campaign_encounter_combatant_shape_check;

ALTER TABLE rpg.campaign_encounter_combatant
  DROP CONSTRAINT IF EXISTS campaign_encounter_combatant_kind_check;

ALTER TABLE rpg.campaign_encounter_combatant
  ADD CONSTRAINT campaign_encounter_combatant_kind_check
  CHECK (kind IN ('pc', 'actor'));

ALTER TABLE rpg.campaign_encounter_combatant
  ADD CONSTRAINT campaign_encounter_combatant_shape_check CHECK (
    (kind = 'pc' AND character_id IS NOT NULL AND actor_id IS NULL)
    OR (kind = 'actor' AND actor_id IS NOT NULL AND character_id IS NULL)
  );

CREATE UNIQUE INDEX IF NOT EXISTS uq_encounter_actor
  ON rpg.campaign_encounter_combatant(encounter_id, actor_id)
  WHERE actor_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_campaign_encounter_combatant_actor_id
  ON rpg.campaign_encounter_combatant(actor_id)
  WHERE actor_id IS NOT NULL;

ALTER TABLE rpg.campaign_encounter_combatant
  DROP COLUMN IF EXISTS display_name,
  DROP COLUMN IF EXISTS hp_current,
  DROP COLUMN IF EXISTS hp_max,
  DROP COLUMN IF EXISTS armor_class;
