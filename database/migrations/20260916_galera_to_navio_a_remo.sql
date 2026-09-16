-- Galley: Galera → Navio a Remo (slug galera → navio-a-remo). Idempotente.

DO $$
DECLARE
  v_from text := 'galera';
  v_to text := 'navio-a-remo';
  v_name text := 'Navio a Remo';
  v_from_item boolean;
  v_to_item boolean;
  v_from_veh boolean;
  v_to_veh boolean;
BEGIN
  SELECT EXISTS(SELECT 1 FROM rpg.phb_item WHERE slug = v_from) INTO v_from_item;
  SELECT EXISTS(SELECT 1 FROM rpg.phb_item WHERE slug = v_to) INTO v_to_item;
  SELECT EXISTS(SELECT 1 FROM rpg.phb_vehicle_template WHERE slug = v_from) INTO v_from_veh;
  SELECT EXISTS(SELECT 1 FROM rpg.phb_vehicle_template WHERE slug = v_to) INTO v_to_veh;

  -- Item (PK slug sem ON UPDATE CASCADE → insert + retarget + delete)
  IF v_from_item AND NOT v_to_item THEN
    INSERT INTO rpg.phb_item (
      slug, item_type, name, cost, weight, description, properties
    )
    SELECT
      v_to, item_type, v_name, cost, weight, description, properties
    FROM rpg.phb_item
    WHERE slug = v_from;

    UPDATE rpg.player_character_item SET item_slug = v_to WHERE item_slug = v_from;
    UPDATE rpg.player_character_item
      SET contained_in_item_slug = v_to
      WHERE contained_in_item_slug = v_from;
    UPDATE rpg.player_character_equipment SET item_slug = v_to WHERE item_slug = v_from;
    UPDATE rpg.player_character
      SET background_tool_item_slug = v_to
      WHERE background_tool_item_slug = v_from;
    IF EXISTS (
      SELECT 1 FROM information_schema.tables
      WHERE table_schema = 'rpg' AND table_name = 'phb_item_catalog_stats'
    ) THEN
      UPDATE rpg.phb_item_catalog_stats SET item_slug = v_to WHERE item_slug = v_from;
    END IF;

    DELETE FROM rpg.phb_item WHERE slug = v_from;
  ELSIF v_to_item THEN
    UPDATE rpg.phb_item SET name = v_name WHERE slug = v_to AND name IS DISTINCT FROM v_name;
    IF v_from_item THEN
      UPDATE rpg.player_character_item SET item_slug = v_to WHERE item_slug = v_from;
      UPDATE rpg.player_character_item
        SET contained_in_item_slug = v_to
        WHERE contained_in_item_slug = v_from;
      UPDATE rpg.player_character_equipment SET item_slug = v_to WHERE item_slug = v_from;
      UPDATE rpg.player_character
        SET background_tool_item_slug = v_to
        WHERE background_tool_item_slug = v_from;
      IF EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'rpg' AND table_name = 'phb_item_catalog_stats'
      ) THEN
        UPDATE rpg.phb_item_catalog_stats SET item_slug = v_to WHERE item_slug = v_from;
      END IF;
      DELETE FROM rpg.phb_item WHERE slug = v_from;
    END IF;
  END IF;

  -- Vehicle template
  IF v_from_veh AND NOT v_to_veh THEN
    INSERT INTO rpg.phb_vehicle_template (
      slug, edition_slug, name, armor_class, hit_points, damage_threshold,
      crew_capacity, cargo_capacity_lb, source_citation_id, subtitle,
      passenger_capacity, initiative_modifier, ability_scores,
      cargo_capacity_label, image_url
    )
    SELECT
      v_to, edition_slug, v_name, armor_class, hit_points, damage_threshold,
      crew_capacity, cargo_capacity_lb, source_citation_id, subtitle,
      passenger_capacity, initiative_modifier, ability_scores,
      cargo_capacity_label, image_url
    FROM rpg.phb_vehicle_template
    WHERE slug = v_from;

    UPDATE rpg.phb_vehicle_template_speed
      SET template_slug = v_to WHERE template_slug = v_from;
    UPDATE rpg.phb_vehicle_template_action
      SET template_slug = v_to WHERE template_slug = v_from;
    UPDATE rpg.phb_vehicle_template_trait
      SET template_slug = v_to WHERE template_slug = v_from;

    DELETE FROM rpg.phb_vehicle_template WHERE slug = v_from;
  ELSIF v_to_veh THEN
    UPDATE rpg.phb_vehicle_template
      SET name = v_name
      WHERE slug = v_to AND name IS DISTINCT FROM v_name;
    IF v_from_veh THEN
      UPDATE rpg.phb_vehicle_template_speed
        SET template_slug = v_to WHERE template_slug = v_from;
      UPDATE rpg.phb_vehicle_template_action
        SET template_slug = v_to WHERE template_slug = v_from;
      UPDATE rpg.phb_vehicle_template_trait
        SET template_slug = v_to WHERE template_slug = v_from;
      DELETE FROM rpg.phb_vehicle_template WHERE slug = v_from;
    END IF;
  END IF;
END $$;
