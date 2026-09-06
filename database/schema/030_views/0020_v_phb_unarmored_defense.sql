CREATE VIEW rpg.v_phb_unarmored_defense AS
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

-- EspaÃ§os de magia + cotas por nÃ­vel de personagem (subclasse conjuradora)
