-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Cap. 6 — Bestial Vigor (Licantropo estágio 3): +1 PV/nível tipado.

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'gh-transformation-lycanthrope'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label,
    requires_option_key, requires_option_value
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'feat'::rpg.effect_owner_kind, feat.id,
         'passive'::rpg.effect_trigger, 3, 10, 'Bestial Vigor — PV',
         'stage3Boon', 'bestial-vigor'
  FROM feat
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, flat_bonus, per_level_bonus, from_level
)
SELECT id, 'hp_bonus'::rpg.effect_combat_mod_kind, 0, 1, 1 FROM ins;
