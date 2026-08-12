/** Expressão SQL: custo aproximado em cobre para ORDER BY (texto PHB-PT). */
export const ITEM_COST_COPPER_ORDER_EXPR = `(
  CASE
    WHEN item.cost IS NULL OR NULLIF(TRIM(item.cost->>'text'), '') IS NULL THEN NULL
    WHEN LOWER(TRIM(item.cost->>'text')) = 'varia' THEN NULL
    ELSE (
      COALESCE(
        NULLIF(
          regexp_replace(
            (regexp_match(LOWER(TRIM(item.cost->>'text')), '(\\d[\\d.]*)'))[1],
            '\\.',
            '',
            'g'
          ),
          ''
        )::numeric,
        0
      ) *
      CASE
        WHEN LOWER(TRIM(item.cost->>'text')) ~ '\\mpl\\b' THEN 1000
        WHEN LOWER(TRIM(item.cost->>'text')) ~ '\\mpo\\b' THEN 100
        WHEN LOWER(TRIM(item.cost->>'text')) ~ '\\mpe\\b' THEN 50
        WHEN LOWER(TRIM(item.cost->>'text')) ~ '\\mpp\\b' THEN 10
        WHEN LOWER(TRIM(item.cost->>'text')) ~ '\\mpc\\b' THEN 1
        ELSE NULL
      END
    )
  END
)`;

export type ItemCatalogSort =
  | 'name'
  | 'name_desc'
  | 'cost_asc'
  | 'cost_desc';
