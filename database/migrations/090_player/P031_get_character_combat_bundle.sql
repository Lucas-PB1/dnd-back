-- RPC de leitura: inventário + catálogo de combate em 1 round-trip.
-- Filho de P030 (sheet bundle) para o GET da ficha.

CREATE OR REPLACE FUNCTION rpg.get_character_combat_bundle(
  p_character_id uuid,
  p_class_slug text,
  p_subclass_slug text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE sql
STABLE
AS $$
  WITH inv AS (
    SELECT
      pci.character_id,
      pci.item_slug,
      pci.quantity,
      pci.location,
      pci.equipment_slot,
      pci.attuned,
      pci.is_pact_weapon,
      pci.attached_charm_slug,
      pci.attached_coverage_slug,
      pci.attached_coverage_bonus,
      pci.attached_coverage_attuned,
      pci.attached_coverage_spell_slug,
      pci.bound_spell_slug,
      pci.instance_properties,
      pci.contained_in_item_slug
    FROM rpg.player_character_item pci
    WHERE pci.character_id = p_character_id
  ),
  active_slugs AS (
    SELECT DISTINCT item_slug FROM (
      SELECT i.item_slug
      FROM inv i
      JOIN rpg.phb_item cat ON cat.slug = i.item_slug
      WHERE i.location = 'equipped'
        AND (
          COALESCE((cat.properties->>'requiresAttunement')::boolean, false) = false
          OR i.attuned = true
        )
      UNION ALL
      SELECT i.attached_charm_slug AS item_slug
      FROM inv i
      WHERE i.location = 'equipped'
        AND i.attached_charm_slug IS NOT NULL
      UNION ALL
      SELECT i.attached_coverage_slug AS item_slug
      FROM inv i
      JOIN rpg.phb_item cov ON cov.slug = i.attached_coverage_slug
      WHERE i.location = 'equipped'
        AND i.attached_coverage_slug IS NOT NULL
        AND (
          COALESCE((cov.properties->>'requiresAttunement')::boolean, false) = false
          OR i.attached_coverage_attuned = true
        )
      UNION ALL
      SELECT i.item_slug
      FROM inv i
      JOIN rpg.phb_item cat ON cat.slug = i.item_slug
      WHERE i.quantity > 0
        AND COALESCE((cat.properties->>'consumable')::boolean, false) = true
    ) s
    WHERE item_slug IS NOT NULL
  ),
  related_slugs AS (
    SELECT DISTINCT slug FROM (
      SELECT item_slug AS slug FROM inv
      UNION ALL
      SELECT attached_charm_slug FROM inv WHERE attached_charm_slug IS NOT NULL
      UNION ALL
      SELECT attached_coverage_slug FROM inv WHERE attached_coverage_slug IS NOT NULL
      UNION ALL
      SELECT item_slug FROM active_slugs
    ) u
    WHERE slug IS NOT NULL
  )
  SELECT jsonb_build_object(
    'inventory', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'characterId', i.character_id,
          'itemSlug', i.item_slug,
          'quantity', i.quantity,
          'location', i.location,
          'equipmentSlot', i.equipment_slot,
          'attuned', i.attuned,
          'isPactWeapon', i.is_pact_weapon,
          'attachedCharmSlug', i.attached_charm_slug,
          'attachedCoverageSlug', i.attached_coverage_slug,
          'attachedCoverageBonus', i.attached_coverage_bonus,
          'attachedCoverageAttuned', i.attached_coverage_attuned,
          'attachedCoverageSpellSlug', i.attached_coverage_spell_slug,
          'boundSpellSlug', i.bound_spell_slug,
          'instanceProperties', i.instance_properties,
          'containedInItemSlug', i.contained_in_item_slug
        )
        ORDER BY i.item_slug
      )
      FROM inv i
    ), '[]'::jsonb),
    'activeItemSlugs', COALESCE((
      SELECT jsonb_agg(a.item_slug ORDER BY a.item_slug)
      FROM active_slugs a
    ), '[]'::jsonb),
    'items', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'slug', cat.slug,
          'name', cat.name,
          'properties', cat.properties
        )
        ORDER BY cat.slug
      )
      FROM rpg.phb_item cat
      WHERE cat.slug IN (SELECT slug FROM related_slugs)
    ), '[]'::jsonb),
    'armor', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'itemSlug', a.item_slug,
          'itemName', a.item_name,
          'categorySlug', a.category_slug,
          'acBase', a.ac_base,
          'strengthReq', a.strength_req,
          'stealthDisadvantage', a.stealth_disadvantage
        )
        ORDER BY a.item_slug
      )
      FROM rpg.v_phb_armor a
      WHERE a.item_slug IN (
        SELECT i.item_slug FROM inv i
        WHERE i.location = 'equipped'
          AND i.equipment_slot IN ('armor', 'shield')
      )
    ), '[]'::jsonb),
    'unarmoredDefenses', COALESCE((
      SELECT jsonb_agg(
        jsonb_build_object(
          'sourceKind', u.source_kind,
          'sourceSlug', u.source_slug,
          'label', u.label,
          'secondAbilitySlug', u.second_ability_slug,
          'allowsShield', u.allows_shield
        )
      )
      FROM rpg.v_phb_unarmored_defense u
      WHERE (u.source_kind = 'class' AND u.source_slug = p_class_slug)
         OR (
           p_subclass_slug IS NOT NULL
           AND u.source_kind = 'subclass'
           AND u.source_slug = p_subclass_slug
         )
    ), '[]'::jsonb)
  );
$$;

COMMENT ON FUNCTION rpg.get_character_combat_bundle(uuid, text, text) IS
  'Read model de combate da ficha: inventário + itens + armadura + defesa sem armadura + active slugs.';
