#!/usr/bin/env node
/**
 * Verifica conteúdo GH no Supabase após seeds.
 * Uso: node scripts/verify-ghpg-prod.mjs [apiBaseUrl]
 */
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';

loadEnv();
const apiBase = (process.argv[2] ?? process.env.SMOKE_URL ?? '').replace(/\/$/, '');

const client = createPgClient(process.env.SUPABASE_DATABASE_URL);
await client.connect();

const checks = [
  {
    label: 'backgrounds GH',
    sql: `SELECT COUNT(*)::int n FROM rpg.phb_background b
      JOIN rpg.phb_source_citation sc ON sc.id = b.source_citation_id
      WHERE sc.slug = 'grim-hollow-players-guide-2024-en:chapter-3-backgrounds'`,
    expect: 25,
  },
  {
    label: 'feats GH Cap.4',
    sql: `SELECT COUNT(*)::int n FROM rpg.phb_feat f
      JOIN rpg.phb_source_citation sc ON sc.id = f.source_citation_id
      WHERE sc.slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats'`,
    expect: 41,
  },
  {
    label: 'transformações GH',
    sql: `SELECT COUNT(*)::int n FROM rpg.phb_feat WHERE category = 'gh-transformation'`,
    expect: 12,
  },
  {
    label: 'pioneer equipamento',
    sql: `SELECT COUNT(*)::int n FROM rpg.phb_starting_item si
      JOIN rpg.phb_starting_package p ON p.id = si.package_id
      JOIN rpg.phb_background b ON b.id = p.owner_id
      WHERE b.slug = 'gh-pioneer' AND p.slug = 'a'`,
    expectMin: 4,
  },
  {
    label: 'heranças GH jogáveis (sem índice)',
    sql: `SELECT COUNT(*)::int n FROM rpg.phb_species
      WHERE slug LIKE 'gh-%' AND slug <> 'gh-heritage-traits'
        AND COALESCE(source_meta->>'catalogOnly', 'false') NOT IN ('true', '1')`,
    expect: 17,
  },
  {
    label: 'pool trait choices gh-dwarf slot 1',
    sql: `SELECT COUNT(*)::int n FROM rpg.v_phb_species_trait_choices
      WHERE species_slug = 'gh-dwarf' AND choice_kind = 'gh_heritage_trait_1'`,
    expectMin: 100,
  },
];

let ok = true;
for (const check of checks) {
  const { rows } = await client.query(check.sql);
  const row = rows[0];
  if (check.expectKind) {
    const pass = row?.kind === check.expectKind;
    console.log(`${pass ? '✓' : '✗'} ${check.label}: ${row?.kind} (esperado ${check.expectKind})`);
    ok &&= pass;
  } else if (check.expectMin) {
    const pass = row.n >= check.expectMin;
    console.log(`${pass ? '✓' : '✗'} ${check.label}: ${row.n} (mín. ${check.expectMin})`);
    ok &&= pass;
  } else {
    const pass = row.n === check.expect;
    console.log(`${pass ? '✓' : '✗'} ${check.label}: ${row.n} (esperado ${check.expect})`);
    ok &&= pass;
  }
}

await client.end();

if (apiBase) {
  console.log(`\nAPI ${apiBase}`);
  const bgRes = await fetch(
    `${apiBase}/backgrounds?editionSlugs=grim-hollow-players-guide-2024-en&limit=50`,
  );
  const bgJson = await bgRes.json();
  const ghCount = (bgJson.data ?? []).filter((b) => b.slug?.startsWith('gh-')).length;
  const bgPass = ghCount >= 25;
  console.log(`${bgPass ? '✓' : '✗'} API backgrounds gh-*: ${ghCount}`);
  ok &&= bgPass;

  const featRes = await fetch(
    `${apiBase}/feats?category=gh-transformation&editionSlugs=grim-hollow-players-guide-2024-en&limit=20`,
  );
  const featJson = await featRes.json();
  const tCount = featJson.data?.length ?? 0;
  const tPass = tCount >= 12;
  console.log(`${tPass ? '✓' : '✗'} API transformações: ${tCount}`);
  ok &&= tPass;
}

process.exit(ok ? 0 : 1);
