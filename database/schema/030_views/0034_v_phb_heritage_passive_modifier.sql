CREATE VIEW rpg.v_phb_heritage_passive_modifier AS
SELECT
  ht.slug AS trait_slug,
  cm.mod_kind::text AS kind,
  COALESCE(e.label, 'Passivo') AS label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level,
  e.min_trait_takes,
  cm.second_ability_slug,
  cm.allows_shield
FROM rpg.phb_effect e
JOIN rpg.phb_effect_combat_mod cm ON cm.effect_id = e.id
JOIN rpg.phb_heritage_trait ht ON ht.id = e.owner_id
WHERE e.kind = 'combat_mod' AND e.owner_kind = 'heritage';

-- AÃ§Ãµes de economia (Usar) ligadas a traÃ§os de heranÃ§a
