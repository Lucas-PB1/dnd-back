-- Views: bundle de template de criatura / veículo (catálogo read-only)

CREATE OR REPLACE VIEW rpg.v_phb_creature_template_bundle AS
SELECT
  t.slug,
  t.edition_slug,
  t.name,
  t.creature_type,
  t.creature_subtype,
  t.size_slug,
  t.challenge_rating,
  t.proficiency_bonus,
  t.armor_class,
  t.hit_points_avg,
  t.hit_points_formula,
  t.spellcasting_ability_slug,
  t.spell_save_dc,
  t.spell_attack_bonus,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'movementKind', s.movement_kind,
        'speedFt', s.speed_ft
      )
      ORDER BY s.movement_kind
    )
    FROM rpg.phb_creature_template_speed s
    WHERE s.template_slug = t.slug
  ), '[]'::jsonb) AS speeds,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'id', a.id,
        'name', a.name,
        'actionBucket', a.action_bucket,
        'attackBonus', a.attack_bonus,
        'damageExpression', a.damage_expression,
        'reachFt', a.reach_ft,
        'sortOrder', a.sort_order
      )
      ORDER BY a.sort_order, a.name
    )
    FROM rpg.phb_creature_template_action a
    WHERE a.template_slug = t.slug
  ), '[]'::jsonb) AS actions,
  COALESCE((
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
    FROM rpg.phb_creature_template_spell sp
    WHERE sp.template_slug = t.slug
  ), '[]'::jsonb) AS spells,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'name', tr.name,
        'description', tr.description,
        'sortOrder', tr.sort_order
      )
      ORDER BY tr.sort_order, tr.name
    )
    FROM rpg.phb_creature_template_trait tr
    WHERE tr.template_slug = t.slug
  ), '[]'::jsonb) AS traits
FROM rpg.phb_creature_template t;

CREATE OR REPLACE VIEW rpg.v_phb_vehicle_template_bundle AS
SELECT
  t.slug,
  t.edition_slug,
  t.name,
  t.armor_class,
  t.hit_points,
  t.damage_threshold,
  t.crew_capacity,
  t.cargo_capacity_lb,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'movementKind', s.movement_kind,
        'speedFt', s.speed_ft
      )
      ORDER BY s.movement_kind
    )
    FROM rpg.phb_vehicle_template_speed s
    WHERE s.template_slug = t.slug
  ), '[]'::jsonb) AS speeds,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'id', a.id,
        'name', a.name,
        'actionBucket', a.action_bucket,
        'attackBonus', a.attack_bonus,
        'damageExpression', a.damage_expression,
        'reachFt', a.reach_ft,
        'sortOrder', a.sort_order
      )
      ORDER BY a.sort_order, a.name
    )
    FROM rpg.phb_vehicle_template_action a
    WHERE a.template_slug = t.slug
  ), '[]'::jsonb) AS actions
FROM rpg.phb_vehicle_template t;
