-- Views de leitura do catálogo de PV e Defesa sem Armadura

-- Bônus permanentes de PV com a origem normalizada (kind + slug).
CREATE OR REPLACE VIEW rpg.v_phb_hp_bonus_source AS
SELECT
  'species'::text AS source_kind,
  sp.slug AS source_slug,
  h.label,
  h.flat_bonus,
  h.per_level_bonus,
  h.from_level
FROM rpg.phb_hp_bonus_source h
JOIN rpg.phb_species sp ON sp.id = h.species_id
WHERE h.species_id IS NOT NULL

UNION ALL

SELECT
  'subclass'::text,
  sc.slug,
  h.label,
  h.flat_bonus,
  h.per_level_bonus,
  h.from_level
FROM rpg.phb_hp_bonus_source h
JOIN rpg.phb_subclass sc ON sc.id = h.subclass_id
WHERE h.subclass_id IS NOT NULL

UNION ALL

SELECT
  'feat'::text,
  f.slug,
  h.label,
  h.flat_bonus,
  h.per_level_bonus,
  h.from_level
FROM rpg.phb_hp_bonus_source h
JOIN rpg.phb_feat f ON f.id = h.feat_id
WHERE h.feat_id IS NOT NULL;

-- Defesa sem Armadura com a origem normalizada (kind + slug).
CREATE OR REPLACE VIEW rpg.v_phb_unarmored_defense AS
SELECT
  'class'::text AS source_kind,
  c.slug AS source_slug,
  u.label,
  u.second_ability_slug,
  u.allows_shield
FROM rpg.phb_unarmored_defense u
JOIN rpg.phb_class c ON c.id = u.class_id
WHERE u.class_id IS NOT NULL

UNION ALL

SELECT
  'subclass'::text,
  sc.slug,
  u.label,
  u.second_ability_slug,
  u.allows_shield
FROM rpg.phb_unarmored_defense u
JOIN rpg.phb_subclass sc ON sc.id = u.subclass_id
WHERE u.subclass_id IS NOT NULL;
