-- Atualiza V072: colunas choice_kind / label / is_traditional para API heritages

DROP VIEW IF EXISTS rpg.v_phb_heritage_trait_choices;

CREATE VIEW rpg.v_phb_heritage_trait_choices AS
SELECT
  h.slug AS heritage_slug,
  ('heritage_trait_' || gs.slot_index)::text AS choice_kind,
  t.slug AS trait_slug,
  regexp_replace(t.name, '\.$', '', 'g') AS trait_name,
  ('[' || CASE t.category
    WHEN 'combat' THEN 'Combate'
    WHEN 'exploration' THEN 'Exploração'
    ELSE 'Interpretação'
  END || '] ' || regexp_replace(t.name, '\.$', '', 'g')) AS label,
  t.benefit_base,
  t.benefit_improved,
  EXISTS (
    SELECT 1
    FROM rpg.phb_heritage_traditional ht
    WHERE ht.heritage_id = h.id AND ht.trait_id = t.id
  ) AS is_traditional,
  (
    gs.slot_index * 100000
    + CASE t.category
        WHEN 'combat' THEN 10000
        WHEN 'exploration' THEN 20000
        ELSE 30000
      END
    + row_number() OVER (
        PARTITION BY h.slug, gs.slot_index
        ORDER BY t.category, t.name
      )
  )::integer AS sort_order
FROM rpg.phb_heritage h
CROSS JOIN generate_series(1, 8) AS gs(slot_index)
CROSS JOIN rpg.phb_heritage_trait t

UNION ALL

SELECT
  h.slug,
  'heritage_trait_9'::text,
  t.slug,
  regexp_replace(t.name, '\.$', '', 'g'),
  ('[' || CASE t.category
    WHEN 'combat' THEN 'Combate'
    WHEN 'exploration' THEN 'Exploração'
    ELSE 'Interpretação'
  END || '] ' || regexp_replace(t.name, '\.$', '', 'g')),
  t.benefit_base,
  t.benefit_improved,
  EXISTS (
    SELECT 1
    FROM rpg.phb_heritage_traditional ht
    WHERE ht.heritage_id = h.id AND ht.trait_id = t.id
  ),
  (
    900000
    + CASE t.category
        WHEN 'combat' THEN 10000
        WHEN 'exploration' THEN 20000
        ELSE 30000
      END
    + row_number() OVER (PARTITION BY h.slug ORDER BY t.category, t.name)
  )::integer
FROM rpg.phb_heritage h
CROSS JOIN rpg.phb_heritage_trait t
WHERE h.allows_speed_trade

UNION ALL

SELECT
  h.slug,
  'heritage_speed_trade'::text,
  v.choice_slug,
  v.choice_name,
  v.choice_name,
  v.level1_benefit,
  NULL::text,
  FALSE,
  910000 + v.sort_order
FROM rpg.phb_heritage h
JOIN (VALUES
  (1, 'no', 'Não', 'Mantém o deslocamento base da herança.'),
  (2, 'yes', 'Sim', 'Reduz 1,5 m de deslocamento; escolha o 9º traço modular.')
) AS v(sort_order, choice_slug, choice_name, level1_benefit) ON TRUE
WHERE h.allows_speed_trade

UNION ALL

SELECT
  h.slug,
  'heritage_size'::text,
  v.choice_slug,
  v.choice_name,
  v.choice_name,
  v.level1_benefit,
  NULL::text,
  FALSE,
  920000 + v.sort_order
FROM rpg.phb_heritage h
JOIN (VALUES
  (1, 'small', 'Pequeno', 'Tamanho Pequeno.'),
  (2, 'medium', 'Médio', 'Tamanho Médio.')
) AS v(sort_order, choice_slug, choice_name, level1_benefit) ON TRUE
WHERE h.allows_size_choice;
