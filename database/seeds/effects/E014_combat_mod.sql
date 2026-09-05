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

-- Views passam a ler phb_effect (idempotente pós-baseline)
CREATE OR REPLACE VIEW rpg.v_phb_hp_bonus_source AS
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

CREATE OR REPLACE VIEW rpg.v_phb_unarmored_defense AS
SELECT
  e.owner_kind::text AS source_kind,
  c.slug AS source_slug,
  COALESCE(e.label, 'Defesa sem Armadura') AS label,
  cm.second_ability_slug,
  cm.allows_shield
FROM rpg.phb_effect e
JOIN rpg.phb_effect_combat_mod cm ON cm.effect_id = e.id
JOIN rpg.phb_class c ON c.id = e.owner_id
WHERE e.kind = 'combat_mod' AND e.owner_kind = 'class'
  AND cm.mod_kind = 'unarmored_defense'

UNION ALL

SELECT
  e.owner_kind::text,
  sc.slug,
  COALESCE(e.label, 'Defesa sem Armadura'),
  cm.second_ability_slug,
  cm.allows_shield
FROM rpg.phb_effect e
JOIN rpg.phb_effect_combat_mod cm ON cm.effect_id = e.id
JOIN rpg.phb_subclass sc ON sc.id = e.owner_id
WHERE e.kind = 'combat_mod' AND e.owner_kind = 'subclass'
  AND cm.mod_kind = 'unarmored_defense';

CREATE OR REPLACE VIEW rpg.v_phb_heritage_passive_modifier AS
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

CREATE OR REPLACE VIEW rpg.v_phb_subclass_mechanics AS
SELECT
  c.slug AS class_slug,
  s.slug AS subclass_slug,
  sf.level AS feature_level,
  sf.name AS feature_name,
  sf.description AS feature_description,
  sf.feature_kind,
  sf.option_key,
  NULL::text AS resource_slug,
  NULL::text AS resource_name,
  NULL::integer AS resource_unlock_level,
  NULL::rpg.resource_max_formula AS max_formula,
  NULL::integer AS fixed_max
FROM rpg.phb_subclass_feature sf
JOIN rpg.phb_subclass s ON s.id = sf.subclass_id
JOIN rpg.phb_class c ON c.id = s.class_id;

DROP MATERIALIZED VIEW IF EXISTS rpg.mv_phb_hp_bonus_source;
CREATE MATERIALIZED VIEW rpg.mv_phb_hp_bonus_source AS
  SELECT * FROM rpg.v_phb_hp_bonus_source;
CREATE UNIQUE INDEX idx_mv_phb_hp_bonus_source
  ON rpg.mv_phb_hp_bonus_source (
    source_kind,
    source_slug,
    from_level,
    option_key_norm,
    option_value_norm
  );

DROP MATERIALIZED VIEW IF EXISTS rpg.mv_phb_unarmored_defense;
CREATE MATERIALIZED VIEW rpg.mv_phb_unarmored_defense AS
  SELECT * FROM rpg.v_phb_unarmored_defense;
CREATE UNIQUE INDEX idx_mv_phb_unarmored_defense
  ON rpg.mv_phb_unarmored_defense (source_kind, source_slug);

-- DROP legado
DROP TABLE IF EXISTS rpg.phb_combat_modifier CASCADE;
DROP TABLE IF EXISTS rpg.phb_resource_grant CASCADE;
