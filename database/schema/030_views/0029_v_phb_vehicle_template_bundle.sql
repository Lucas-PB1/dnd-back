CREATE VIEW rpg.v_phb_vehicle_template_bundle AS
SELECT
  t.slug,
  t.edition_slug,
  t.name,
  t.subtitle,
  t.armor_class,
  t.hit_points,
  t.damage_threshold,
  t.crew_capacity,
  t.passenger_capacity,
  t.cargo_capacity_lb,
  t.cargo_capacity_label,
  t.initiative_modifier,
  t.ability_scores,
  t.image_url,
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
        'description', a.description,
        'sortOrder', a.sort_order
      )
      ORDER BY a.sort_order, a.name
    )
    FROM rpg.phb_vehicle_template_action a
    WHERE a.template_slug = t.slug
  ), '[]'::jsonb) AS actions,
  COALESCE((
    SELECT jsonb_agg(
      jsonb_build_object(
        'name', tr.name,
        'description', tr.description,
        'sortOrder', tr.sort_order
      )
      ORDER BY tr.sort_order, tr.name
    )
    FROM rpg.phb_vehicle_template_trait tr
    WHERE tr.template_slug = t.slug
  ), '[]'::jsonb) AS traits
FROM rpg.phb_vehicle_template t;

-- Magias concedidas por ancestria Feathren + Identificar / Aprimorar Atributo
