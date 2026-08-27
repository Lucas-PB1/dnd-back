-- Vehicle spawn: gravar parent_character_id; boarded_actor_id no state do PC

ALTER TABLE rpg.player_character_state
  ADD COLUMN IF NOT EXISTS boarded_actor_id uuid
    REFERENCES rpg.game_actor(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_player_character_state_boarded_actor
  ON rpg.player_character_state(boarded_actor_id)
  WHERE boarded_actor_id IS NOT NULL;

CREATE OR REPLACE FUNCTION rpg.spawn_game_actor_from_template(
  p_template_slug text,
  p_owner_user_id uuid,
  p_actor_kind rpg.actor_kind,
  p_campaign_id uuid DEFAULT NULL,
  p_parent_character_id uuid DEFAULT NULL,
  p_name_override text DEFAULT NULL
)
RETURNS uuid
LANGUAGE plpgsql
AS $$
DECLARE
  v_actor_id uuid := gen_random_uuid();
  v_creature rpg.phb_creature_template%ROWTYPE;
  v_vehicle rpg.phb_vehicle_template%ROWTYPE;
BEGIN
  IF p_actor_kind IN ('creature', 'mount', 'companion') THEN
    SELECT * INTO v_creature
    FROM rpg.phb_creature_template
    WHERE slug = p_template_slug;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'Creature template % not found', p_template_slug;
    END IF;

    INSERT INTO rpg.game_actor (
      id,
      owner_user_id,
      campaign_id,
      parent_character_id,
      actor_kind,
      template_slug,
      name,
      hit_points_max,
      hit_points_current,
      armor_class,
      initiative_modifier,
      proficiency_bonus,
      ability_scores,
      size_slug,
      spellcasting_ability_slug,
      spell_save_dc,
      spell_attack_bonus
    ) VALUES (
      v_actor_id,
      p_owner_user_id,
      p_campaign_id,
      p_parent_character_id,
      p_actor_kind,
      p_template_slug,
      COALESCE(p_name_override, v_creature.name),
      v_creature.hit_points_avg,
      v_creature.hit_points_avg,
      v_creature.armor_class,
      v_creature.initiative_modifier,
      v_creature.proficiency_bonus,
      COALESCE(v_creature.ability_scores, '{"forca":10,"destreza":10,"constituicao":10,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb),
      v_creature.size_slug,
      v_creature.spellcasting_ability_slug,
      v_creature.spell_save_dc,
      v_creature.spell_attack_bonus
    );

    INSERT INTO rpg.game_actor_speed (actor_id, movement_kind, speed_ft)
    SELECT v_actor_id, movement_kind, speed_ft
    FROM rpg.phb_creature_template_speed
    WHERE template_slug = p_template_slug;

    INSERT INTO rpg.game_actor_action (
      actor_id, name, action_bucket, attack_bonus, damage_expression, reach_ft, description, sort_order
    )
    SELECT
      v_actor_id, name, action_bucket, attack_bonus, damage_expression, reach_ft, description, sort_order
    FROM rpg.phb_creature_template_action
    WHERE template_slug = p_template_slug;

    INSERT INTO rpg.game_actor_spell (
      actor_id, spell_slug, usage_kind, uses_per_day, slot_level, recharge_dice, sort_order
    )
    SELECT
      v_actor_id, spell_slug, usage_kind, uses_per_day, slot_level, recharge_dice, sort_order
    FROM rpg.phb_creature_template_spell
    WHERE template_slug = p_template_slug;

  ELSIF p_actor_kind = 'vehicle' THEN
    SELECT * INTO v_vehicle
    FROM rpg.phb_vehicle_template
    WHERE slug = p_template_slug;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'Vehicle template % not found', p_template_slug;
    END IF;

    INSERT INTO rpg.game_actor (
      id,
      owner_user_id,
      campaign_id,
      parent_character_id,
      actor_kind,
      template_slug,
      name,
      hit_points_max,
      hit_points_current,
      armor_class,
      initiative_modifier,
      ability_scores,
      damage_threshold,
      crew_capacity,
      passenger_capacity,
      cargo_capacity_lb
    ) VALUES (
      v_actor_id,
      p_owner_user_id,
      p_campaign_id,
      p_parent_character_id,
      'vehicle'::rpg.actor_kind,
      p_template_slug,
      COALESCE(p_name_override, v_vehicle.name),
      v_vehicle.hit_points,
      v_vehicle.hit_points,
      v_vehicle.armor_class,
      v_vehicle.initiative_modifier,
      COALESCE(v_vehicle.ability_scores, '{"forca":10,"destreza":10,"constituicao":10,"inteligencia":10,"sabedoria":10,"carisma":10}'::jsonb),
      v_vehicle.damage_threshold,
      v_vehicle.crew_capacity,
      v_vehicle.passenger_capacity,
      v_vehicle.cargo_capacity_lb
    );

    INSERT INTO rpg.game_actor_speed (actor_id, movement_kind, speed_ft)
    SELECT v_actor_id, movement_kind, speed_ft
    FROM rpg.phb_vehicle_template_speed
    WHERE template_slug = p_template_slug;

    INSERT INTO rpg.game_actor_action (
      actor_id, name, action_bucket, attack_bonus, damage_expression, reach_ft, description, sort_order
    )
    SELECT
      v_actor_id, name, action_bucket, attack_bonus, damage_expression, reach_ft, description, sort_order
    FROM rpg.phb_vehicle_template_action
    WHERE template_slug = p_template_slug;

  ELSE
    RAISE EXCEPTION 'Unsupported actor_kind % for spawn', p_actor_kind;
  END IF;

  INSERT INTO rpg.game_actor_state (actor_id)
  VALUES (v_actor_id);

  RETURN v_actor_id;
END;
$$;
