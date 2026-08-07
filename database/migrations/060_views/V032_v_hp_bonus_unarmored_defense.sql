-- Views de leitura do catálogo de PV e Defesa sem Armadura (Lote G: phb_combat_modifier)

CREATE OR REPLACE VIEW rpg.v_phb_hp_bonus_source AS
SELECT
  cm.owner_kind::text AS source_kind,
  sp.slug AS source_slug,
  cm.label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_species sp ON sp.id = cm.owner_id
WHERE cm.kind = 'hp_bonus' AND cm.owner_kind = 'species'

UNION ALL

SELECT
  cm.owner_kind::text,
  sc.slug,
  cm.label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_subclass sc ON sc.id = cm.owner_id
WHERE cm.kind = 'hp_bonus' AND cm.owner_kind = 'subclass'

UNION ALL

SELECT
  cm.owner_kind::text,
  f.slug,
  cm.label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_feat f ON f.id = cm.owner_id
WHERE cm.kind = 'hp_bonus' AND cm.owner_kind = 'feat';

CREATE OR REPLACE VIEW rpg.v_phb_unarmored_defense AS
SELECT
  cm.owner_kind::text AS source_kind,
  c.slug AS source_slug,
  cm.label,
  cm.second_ability_slug,
  cm.allows_shield
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_class c ON c.id = cm.owner_id
WHERE cm.kind = 'unarmored_defense' AND cm.owner_kind = 'class'

UNION ALL

SELECT
  cm.owner_kind::text,
  sc.slug,
  cm.label,
  cm.second_ability_slug,
  cm.allows_shield
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_subclass sc ON sc.id = cm.owner_id
WHERE cm.kind = 'unarmored_defense' AND cm.owner_kind = 'subclass';
