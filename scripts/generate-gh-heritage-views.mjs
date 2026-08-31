/**
 * Gera views V072–V075 para heranças GH (V071 reservado a armor_edition_image).
 * Uso: node scripts/generate-gh-heritage-views.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const viewsDir = path.join(apiRoot, 'database/migrations/060_views');

const CATEGORY_LABEL = `CASE t.category
    WHEN 'combat' THEN 'Combate'
    WHEN 'exploration' THEN 'Exploração'
    ELSE 'Interpretação'
  END`;

const TRAIT_NAME = `regexp_replace(t.name, '\\.$', '', 'g')`;

const VIEW_FILES = [
  {
    file: 'V072_v_phb_heritage_trait_choices.sql',
    body: `-- Pool global, slots modulares, speed trade e tamanho por herança GH

CREATE OR REPLACE VIEW rpg.v_phb_heritage_trait_choices AS
SELECT
  h.slug AS heritage_slug,
  ('heritage_trait_' || gs.slot_index)::text AS choice_kind,
  t.slug AS trait_slug,
  ${TRAIT_NAME} AS trait_name,
  ('[' || ${CATEGORY_LABEL} || '] ' || ${TRAIT_NAME}) AS label,
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
  ${TRAIT_NAME},
  ('[' || ${CATEGORY_LABEL} || '] ' || ${TRAIT_NAME}),
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
`,
  },
  {
    file: 'V073_v_phb_heritage_traditional_build.sql',
    body: `-- Build tradicional sugerido (8 traços por herança)

CREATE OR REPLACE VIEW rpg.v_phb_heritage_traditional_build AS
SELECT
  h.slug AS heritage_slug,
  tr.slug AS trait_slug,
  tr.name AS trait_name,
  tr.category::text AS category,
  trt.category_hint::text AS category_hint,
  trt.sort_order,
  tr.benefit_base,
  tr.benefit_improved,
  tr.improved_name,
  tr.max_takes,
  tr.take_mode::text AS take_mode,
  h.source_meta->>'editionSlug' AS edition_slug
FROM rpg.phb_heritage_traditional trt
JOIN rpg.phb_heritage h ON h.id = trt.heritage_id
JOIN rpg.phb_heritage_trait tr ON tr.id = trt.trait_id
ORDER BY h.slug, trt.sort_order;
`,
  },
  {
    file: 'V074_v_phb_heritage_passive_modifier.sql',
    body: `-- Passivos de combate/ficha ligados a traços de herança

CREATE OR REPLACE VIEW rpg.v_phb_heritage_passive_modifier AS
SELECT
  ht.slug AS trait_slug,
  cm.kind::text AS kind,
  cm.label,
  cm.flat_bonus,
  cm.per_level_bonus,
  cm.from_level,
  cm.min_trait_takes,
  cm.second_ability_slug,
  cm.allows_shield
FROM rpg.phb_combat_modifier cm
JOIN rpg.phb_heritage_trait ht ON ht.id = cm.heritage_trait_id
WHERE cm.owner_kind = 'heritage'::rpg.combat_modifier_owner;
`,
  },
  {
    file: 'V075_v_phb_heritage_economy_action.sql',
    body: `-- Ações de economia (Usar) ligadas a traços de herança

CREATE OR REPLACE VIEW rpg.v_phb_heritage_economy_action AS
SELECT
  a.action_id,
  ht.slug AS trait_slug,
  a.name,
  a.economy::text AS economy,
  a.unlock_level,
  a.resource_slug,
  a.free_resource_slug,
  a.always_spends_resource,
  a.summary,
  a.description,
  a.table_action,
  a.spend_amount,
  a.spell_slug,
  a.sort_order,
  a.min_trait_takes
FROM rpg.phb_class_economy_action a
JOIN rpg.phb_heritage_trait ht ON ht.id = a.heritage_trait_id
WHERE a.heritage_trait_id IS NOT NULL;
`,
  },
];

fs.mkdirSync(viewsDir, { recursive: true });

for (const view of VIEW_FILES) {
  fs.writeFileSync(path.join(viewsDir, view.file), view.body, 'utf8');
  console.log(`Gerado ${view.file}`);
}

console.log('Views GH heritage: V072 trait choices, V073 traditional, V074 passive, V075 economy');
