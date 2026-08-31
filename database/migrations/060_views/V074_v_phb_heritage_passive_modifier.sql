-- Passivos de combate/ficha ligados a traços de herança

CREATE OR REPLACE VIEW rpg.v_phb_heritage_passive_modifier AS
SELECT
  ht.slug AS trait_slug,
  cm.kind::text AS kind,
  cm.label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level,
  cm.min_trait_takes,
  cm.second_ability_slug,
  cm.allows_shield
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_heritage_trait ht ON ht.id = cm.heritage_trait_id
WHERE cm.owner_kind = 'heritage'::rpg.combat_modifier_owner;
