-- Lâmina Arcana: troca stub combat_note dos truques por grant_spell (cantrip1/2).

DELETE FROM rpg.phb_effect_note n
USING rpg.phb_effect e, rpg.phb_feat f
WHERE n.effect_id = e.id
  AND e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug = 'spellblade'
  AND e.kind = 'combat_note'
  AND e.sort_order = 1
  AND e.label = 'Truques de lâmina';

DELETE FROM rpg.phb_effect e
USING rpg.phb_feat f
WHERE e.owner_kind = 'feat'
  AND e.owner_id = f.id
  AND f.slug = 'spellblade'
  AND e.kind = 'combat_note'
  AND e.sort_order = 1
  AND e.label = 'Truques de lâmina';

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
ins AS (
  INSERT INTO rpg.phb_effect (
    kind, owner_kind, owner_id, trigger, unlock_level, sort_order, label
  )
  SELECT v.kind, 'feat'::rpg.effect_owner_kind, feat.id, 'on_build'::rpg.effect_trigger,
         1, v.sort_order, v.label
  FROM feat
  CROSS JOIN (
    VALUES
      ('grant_spell'::rpg.effect_kind, 10, 'Lâmina Arcana — Truque 1'),
      ('grant_spell'::rpg.effect_kind, 11, 'Lâmina Arcana — Truque 2')
  ) AS v(kind, sort_order, label)
  WHERE NOT EXISTS (
    SELECT 1
    FROM rpg.phb_effect e
    WHERE e.owner_kind = 'feat'
      AND e.owner_id = feat.id
      AND e.kind = 'grant_spell'
      AND e.sort_order = v.sort_order
  )
  RETURNING id, sort_order
)
INSERT INTO rpg.phb_effect_spell (effect_id, option_key, spell_level)
SELECT id,
  CASE sort_order WHEN 10 THEN 'cantrip1' ELSE 'cantrip2' END,
  0
FROM ins
ON CONFLICT (effect_id) DO NOTHING;

WITH feat AS (SELECT id FROM rpg.phb_feat WHERE slug = 'spellblade'),
effects AS (
  SELECT e.id
  FROM rpg.phb_effect e
  JOIN feat ON feat.id = e.owner_id
  WHERE e.owner_kind = 'feat'
    AND e.kind = 'grant_spell'
    AND e.sort_order IN (10, 11)
)
INSERT INTO rpg.phb_effect_cast_economy (effect_id, economy, uses_formula, fixed_uses)
SELECT id, 'at_will'::rpg.effect_cast_economy, 'fixed'::rpg.effect_uses_formula, NULL
FROM effects
ON CONFLICT (effect_id) DO NOTHING;

UPDATE rpg.phb_effect_note n
SET note = 'Atributo de conjuração = escolha do talento (option castingAbility).'
FROM rpg.phb_effect e
JOIN rpg.phb_feat f ON f.id = e.owner_id AND e.owner_kind = 'feat'
WHERE n.effect_id = e.id
  AND f.slug = 'spellblade'
  AND e.kind = 'spellcasting_ability';
