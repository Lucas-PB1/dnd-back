CREATE VIEW rpg.v_phb_hp_bonus_source AS
SELECT
  e.owner_kind::text AS source_kind,
  sp.slug AS source_slug,
  COALESCE(e.label, 'PV') AS label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level,
  e.requires_option_key,
  e.requires_option_value,
  COALESCE(e.requires_option_key, '') AS option_key_norm,
  COALESCE(e.requires_option_value, '') AS option_value_norm
FROM rpg.phb_effect e
JOIN rpg.phb_effect_combat_mod cm ON cm.effect_id = e.id
JOIN rpg.phb_species sp ON sp.id = e.owner_id
WHERE e.kind = 'combat_mod' AND e.owner_kind = 'species'
  AND cm.mod_kind = 'hp_bonus'

UNION ALL

SELECT
  e.owner_kind::text,
  sc.slug,
  COALESCE(e.label, 'PV'),
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level,
  e.requires_option_key,
  e.requires_option_value,
  COALESCE(e.requires_option_key, '') AS option_key_norm,
  COALESCE(e.requires_option_value, '') AS option_value_norm
FROM rpg.phb_effect e
JOIN rpg.phb_effect_combat_mod cm ON cm.effect_id = e.id
JOIN rpg.phb_subclass sc ON sc.id = e.owner_id
WHERE e.kind = 'combat_mod' AND e.owner_kind = 'subclass'
  AND cm.mod_kind = 'hp_bonus'

UNION ALL

SELECT
  e.owner_kind::text,
  f.slug,
  COALESCE(e.label, 'PV'),
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level,
  e.requires_option_key,
  e.requires_option_value,
  COALESCE(e.requires_option_key, '') AS option_key_norm,
  COALESCE(e.requires_option_value, '') AS option_value_norm
FROM rpg.phb_effect e
JOIN rpg.phb_effect_combat_mod cm ON cm.effect_id = e.id
JOIN rpg.phb_feat f ON f.id = e.owner_id
WHERE e.kind = 'combat_mod' AND e.owner_kind = 'feat'
  AND cm.mod_kind = 'hp_bonus';
