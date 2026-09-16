-- Métricas ao vivo de veículo na ficha do actor (tripulação / passageiros / carga).

ALTER TABLE rpg.game_actor_state
  ADD COLUMN IF NOT EXISTS crew_current INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS passenger_current INT NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS cargo_current_lb INT NOT NULL DEFAULT 0;

ALTER TABLE rpg.game_actor_state
  DROP CONSTRAINT IF EXISTS game_actor_state_crew_current_check;
ALTER TABLE rpg.game_actor_state
  ADD CONSTRAINT game_actor_state_crew_current_check CHECK (crew_current >= 0);
ALTER TABLE rpg.game_actor_state
  DROP CONSTRAINT IF EXISTS game_actor_state_passenger_current_check;
ALTER TABLE rpg.game_actor_state
  ADD CONSTRAINT game_actor_state_passenger_current_check CHECK (passenger_current >= 0);
ALTER TABLE rpg.game_actor_state
  DROP CONSTRAINT IF EXISTS game_actor_state_cargo_current_lb_check;
ALTER TABLE rpg.game_actor_state
  ADD CONSTRAINT game_actor_state_cargo_current_lb_check CHECK (cargo_current_lb >= 0);

CREATE OR REPLACE FUNCTION rpg.get_game_actor_bundle(p_actor_id uuid)
RETURNS jsonb
LANGUAGE sql
STABLE
AS $$
  SELECT jsonb_build_object(
    'speeds', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'movementKind', s.movement_kind,
          'speedFt', s.speed_ft
        )
        ORDER BY s.movement_kind
      )
      FROM rpg.game_actor_speed s
      WHERE s.actor_id = p_actor_id
    ), '[]'::jsonb),
    'actions', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'id', a.id,
          'name', a.name,
          'actionBucket', a.action_bucket,
          'attackBonus', a.attack_bonus,
          'damageExpression', a.damage_expression,
          'reachFt', a.reach_ft,
          'description', a.description,
          'sortOrder', a.sort_order
        )
        ORDER BY a.sort_order, a.name
      )
      FROM rpg.game_actor_action a
      WHERE a.actor_id = p_actor_id
    ), '[]'::jsonb),
    'spells', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'spellSlug', sp.spell_slug,
          'usageKind', sp.usage_kind,
          'usesPerDay', sp.uses_per_day,
          'slotLevel', sp.slot_level,
          'rechargeDice', sp.recharge_dice,
          'sortOrder', sp.sort_order
        )
        ORDER BY sp.sort_order, sp.spell_slug
      )
      FROM rpg.game_actor_spell sp
      WHERE sp.actor_id = p_actor_id
    ), '[]'::jsonb),
    'state', (
      SELECT jsonb_build_object(
        'conditions', st.conditions,
        'tempHp', st.temp_hp,
        'concentratingOn', st.concentrating_on,
        'innateSpellUses', st.innate_spell_uses,
        'crewCurrent', st.crew_current,
        'passengerCurrent', st.passenger_current,
        'cargoCurrentLb', st.cargo_current_lb
      )
      FROM rpg.game_actor_state st
      WHERE st.actor_id = p_actor_id
    )
  );
$$;
