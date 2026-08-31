#!/usr/bin/env node
/**
 * Smoke E2 — heranças GH na mesa (2× takes, resources, HP extra-tough).
 * Uso: node scripts/verify-gh-heritage-e2.mjs
 */
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';

loadEnv();

const client = createPgClient(process.env.SUPABASE_DATABASE_URL);
await client.connect();

let failed = 0;

function pass(msg) {
  console.log(`✓ ${msg}`);
}

function fail(msg) {
  console.error(`✗ ${msg}`);
  failed += 1;
}

function assert(cond, msg) {
  if (cond) pass(msg);
  else fail(msg);
}

/** Espelha matchesHeritageTraitAction (front). */
function filterHeritageActions(rows, heritageChoices) {
  const counts = new Map();
  for (const choice of heritageChoices) {
    if (!choice.choiceKind.startsWith('heritage_trait_')) continue;
    const slug = choice.choiceSlug?.trim();
    if (!slug) continue;
    counts.set(slug, (counts.get(slug) ?? 0) + 1);
  }
  return rows.filter((row) => {
    const need = row.min_trait_takes ?? 1;
    const have = counts.get(row.trait_slug) ?? 0;
    return have >= need;
  });
}

/** Espelha loadHeritageHitPointsBonus (API). */
function heritageHpBonus(rows, aggregated, level) {
  let bonus = 0;
  for (const entry of aggregated) {
    const matching = rows
      .filter(
        (r) =>
          r.trait_slug === entry.traitSlug &&
          entry.takeCount >= Number(r.min_trait_takes),
      )
      .sort(
        (a, b) => Number(b.min_trait_takes) - Number(a.min_trait_takes),
      );
    const row = matching[0];
    if (!row || level < Number(row.from_level || 1)) continue;
    bonus += Number(row.flat_bonus) || 0;
    bonus +=
      (Number(row.per_level_bonus) || 0) *
      level *
      Math.max(1, entry.takeCount);
  }
  return bonus;
}

const { rows: heritageActions } = await client.query(`
  SELECT trait_slug, action_id, economy, min_trait_takes, resource_slug
  FROM rpg.v_phb_heritage_economy_action
  ORDER BY trait_slug, min_trait_takes, action_id
`);

const { rows: heritageResources } = await client.query(`
  SELECT ht.slug AS trait_slug, rd.slug AS resource_slug, gr.min_trait_takes
  FROM rpg.phb_resource_grant gr
  JOIN rpg.phb_heritage_trait ht ON ht.id = gr.owner_id
  JOIN rpg.phb_resource_definition rd ON rd.id = gr.resource_id
  WHERE gr.owner_kind = 'heritage'::rpg.resource_owner_kind
  ORDER BY ht.slug, gr.min_trait_takes, rd.slug
`);

const { rows: hpModifiers } = await client.query(`
  SELECT trait_slug, per_level_bonus, flat_bonus, min_trait_takes, from_level
  FROM rpg.v_phb_heritage_passive_modifier
  WHERE kind = 'hp_bonus'
`);

assert(heritageActions.length >= 40, `economy heritage: ${heritageActions.length} ações`);
assert(heritageResources.length === 31, `resources heritage: ${heritageResources.length} grants`);

const bornLucky = heritageActions.filter((r) => r.trait_slug === 'born-lucky');
assert(
  bornLucky.some((r) => r.min_trait_takes === 1 && r.resource_slug === 'gh-born-lucky'),
  'born-lucky: reação @1× com gh-born-lucky',
);

const potentBreath = heritageActions.filter((r) => r.trait_slug === 'potent-breath');
assert(
  potentBreath.some((r) => r.min_trait_takes === 1 && r.resource_slug === 'potentBreath'),
  'potent-breath: ação @1× com potentBreath',
);
assert(
  potentBreath.some(
    (r) => r.min_trait_takes === 2 && r.resource_slug === 'gh-potent-breath-x2',
  ),
  'potent-breath: ação @2× com gh-potent-breath-x2',
);

const damageImmunity = heritageActions.filter((r) => r.trait_slug === 'damage-immunity');
assert(
  damageImmunity.length === 1 && damageImmunity[0].min_trait_takes === 2,
  'damage-immunity: só reação @2×',
);

const extraTough = hpModifiers.find((r) => r.trait_slug === 'extra-tough');
assert(extraTough?.per_level_bonus === 1, 'extra-tough: modifier per_level_bonus=1 no banco');

const oneTake = filterHeritageActions(heritageActions, [
  { choiceKind: 'heritage_trait_1', choiceSlug: 'potent-breath' },
]);
const twoTakes = filterHeritageActions(heritageActions, [
  { choiceKind: 'heritage_trait_1', choiceSlug: 'potent-breath' },
  { choiceKind: 'heritage_trait_2', choiceSlug: 'potent-breath' },
]);

assert(
  oneTake.some((r) => r.action_id === 'heritage-potent-breath') &&
    !oneTake.some((r) => r.action_id === 'heritage-potent-breath-action-x2'),
  '1× potent-breath: só ação base',
);
assert(
  twoTakes.some((r) => r.action_id === 'heritage-potent-breath') &&
    twoTakes.some((r) => r.action_id === 'heritage-potent-breath-action-x2'),
  '2× potent-breath: base + aprimorada',
);
assert(
  !filterHeritageActions(heritageActions, [
    { choiceKind: 'heritage_trait_1', choiceSlug: 'damage-immunity' },
  ]).length &&
    filterHeritageActions(heritageActions, [
      { choiceKind: 'heritage_trait_1', choiceSlug: 'damage-immunity' },
      { choiceKind: 'heritage_trait_2', choiceSlug: 'damage-immunity' },
    ]).some((r) => r.action_id === 'heritage-damage-immunity-reaction-x2'),
  'damage-immunity: reação só com 2×',
);

const hp1 = heritageHpBonus(
  hpModifiers,
  [{ traitSlug: 'extra-tough', takeCount: 1 }],
  5,
);
const hp2 = heritageHpBonus(
  hpModifiers,
  [{ traitSlug: 'extra-tough', takeCount: 2 }],
  5,
);
assert(hp1 === 5, `extra-tough 1× nv.5 → +5 PV (${hp1})`);
assert(hp2 === 10, `extra-tough 2× nv.5 → +10 PV (${hp2})`);

const bornLuckyRes = heritageResources.filter((r) => r.trait_slug === 'born-lucky');
assert(
  bornLuckyRes.some((r) => r.min_trait_takes === 1 && r.resource_slug === 'gh-born-lucky'),
  'born-lucky: grant gh-born-lucky @1×',
);

const x2ResourceTraits = new Set(
  heritageResources.filter((r) => r.min_trait_takes === 2).map((r) => r.trait_slug),
);
const x2ActionTraits = new Set(
  heritageActions.filter((r) => r.min_trait_takes === 2).map((r) => r.trait_slug),
);
assert(x2ResourceTraits.size >= 10, `resources @2×: ${x2ResourceTraits.size} traços`);
assert(x2ActionTraits.size >= 5, `ações @2×: ${x2ActionTraits.size} traços`);

await client.end();

if (failed > 0) {
  console.error(`\n${failed} falha(s)`);
  process.exit(1);
}
console.log('\nE2 banco + lógica: ok');
