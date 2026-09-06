-- seed-mode: truncate-scoped (phb_effect CTE; re-seed via truncate)
-- Combat mods residuais — class/subclass/heritage (SSOT; S061/S062/C069/C070 → DELETE)
-- 3× hp_bonus + 4× unarmored_defense

-- —— Subclass: Resiliência Dracônica (+1 PV/nível from 3) ——
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'passive'::rpg.effect_trigger, 3, 1, 'Resiliência Dracônica'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, flat_bonus, per_level_bonus, from_level
)
SELECT id, 'hp_bonus'::rpg.effect_combat_mod_kind, 0, 1, 3 FROM ins;

-- —— Subclass: Sangromante — Vigor Sanguíneo (+1 PV/nível from 6) ——
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'sangromancer'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'passive'::rpg.effect_trigger, 6, 1, 'Vigor Sanguíneo'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, flat_bonus, per_level_bonus, from_level
)
SELECT id, 'hp_bonus'::rpg.effect_combat_mod_kind, 0, 1, 6 FROM ins;

-- —— Heritage: Robustez extra (+1 PV/nível) ——
WITH ht AS (SELECT id FROM rpg.phb_heritage_trait WHERE slug = 'extra-tough'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, min_trait_takes, label
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'heritage'::rpg.effect_owner_kind, ht.id,
         'passive'::rpg.effect_trigger, 1, 1, 1, 'Robustez extra'
  FROM ht
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, flat_bonus, per_level_bonus, from_level
)
SELECT id, 'hp_bonus'::rpg.effect_combat_mod_kind, 0, 1, 1 FROM ins;

-- —— Class: Defesa sem Armadura (bárbaro) ——
WITH c AS (SELECT id FROM rpg.phb_class WHERE slug = 'barbarian'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Defesa sem Armadura (bárbaro)'
  FROM c
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, second_ability_slug, allows_shield
)
SELECT id, 'unarmored_defense'::rpg.effect_combat_mod_kind, 'constituicao', TRUE FROM ins;

-- —— Class: Defesa sem Armadura (monge) ——
WITH c AS (SELECT id FROM rpg.phb_class WHERE slug = 'monk'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'class'::rpg.effect_owner_kind, c.id,
         'passive'::rpg.effect_trigger, 1, 1, 'Defesa sem Armadura (monge)'
  FROM c
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, second_ability_slug, allows_shield
)
SELECT id, 'unarmored_defense'::rpg.effect_combat_mod_kind, 'sabedoria', FALSE FROM ins;

-- —— Subclass: Resiliência Dracônica (UD) ——
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'draconic'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'passive'::rpg.effect_trigger, 3, 2, 'Resiliência Dracônica'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, second_ability_slug, allows_shield
)
SELECT id, 'unarmored_defense'::rpg.effect_combat_mod_kind, 'carisma', TRUE FROM ins;

-- —— Subclass: Dança (UD) ——
WITH sc AS (SELECT id FROM rpg.phb_subclass WHERE slug = 'dance'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT 'combat_mod'::rpg.effect_kind, 'subclass'::rpg.effect_owner_kind, sc.id,
         'passive'::rpg.effect_trigger, 3, 1, 'Defesa sem Armadura (dança)'
  FROM sc
  RETURNING id
)
INSERT INTO rpg.phb_effect_combat_mod (
  effect_id, mod_kind, second_ability_slug, allows_shield
)
SELECT id, 'unarmored_defense'::rpg.effect_combat_mod_kind, 'carisma', FALSE FROM ins;
