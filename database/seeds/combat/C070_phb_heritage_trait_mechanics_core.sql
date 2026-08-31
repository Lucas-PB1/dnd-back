-- GH heritage traits — passivos CORE (Cap. 1)
-- Gerado por scripts/classify-gh-heritage-trait-mechanics.mjs

INSERT INTO rpg.phb_combat_modifier (
  kind, owner_kind, owner_id, heritage_trait_id, label, per_level_bonus, min_trait_takes
)
SELECT
  'hp_bonus'::rpg.combat_modifier_kind,
  'heritage'::rpg.combat_modifier_owner,
  ht.id,
  ht.id,
  'Robustez extra',
  1,
  1
FROM rpg.phb_heritage_trait ht
WHERE ht.slug = 'extra-tough'
  AND NOT EXISTS (
    SELECT 1 FROM rpg.phb_combat_modifier cm
    WHERE cm.heritage_trait_id = ht.id
      AND cm.kind = 'hp_bonus'::rpg.combat_modifier_kind
      AND cm.min_trait_takes = 1
  );

