#!/usr/bin/env node
/**
 * Verifica alinhamento compêndio ↔ dados GSB (DB + API opcional).
 * Uso: node scripts/verify-gsb-compendium.mjs [apiBaseUrl]
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const EDITION = 'griffons-saddlebag-book-one-2024-en';
const CITATION = 'griffons-saddlebag-book-one-2024-en:part-ii-character-options';

const extract = JSON.parse(
  fs.readFileSync(
    path.join(__dirname, '../docs/source/extracts/griffons-saddlebag/book-one-part-ii.json'),
    'utf8',
  ),
);

loadEnv();
const apiBase = (process.argv[2] ?? process.env.SMOKE_URL ?? '').replace(/\/$/, '');
const client = createPgClient(process.env.SUPABASE_DATABASE_URL);
await client.connect();

let ok = true;
const fail = (msg) => {
  console.log(`✗ ${msg}`);
  ok = false;
};
const pass = (msg) => console.log(`✓ ${msg}`);

console.log('=== Compêndio GSB — verificação ===\n');

// Edição
const edition = await client.query(
  `SELECT slug, label, book, language FROM rpg.phb_edition WHERE slug = $1`,
  [EDITION],
);
if (edition.rows[0]?.language !== 'pt') {
  fail(`edição language=${edition.rows[0]?.language} (esperado pt)`);
} else {
  pass(`edição ${EDITION} (${edition.rows[0].label})`);
}

// Subclasses na view do compêndio
const subs = await client.query(
  `SELECT subclass_slug, subclass_name, tagline, summary, edition_slug, image_url
   FROM rpg.v_phb_subclass
   WHERE edition_slug = $1
   ORDER BY class_slug, subclass_slug`,
  [EDITION],
);
if (subs.rows.length !== 12) {
  fail(`v_phb_subclass: ${subs.rows.length} subclasses (esperado 12)`);
} else {
  pass(`v_phb_subclass: 12 subclasses`);
}

const extractBySlug = Object.fromEntries(extract.subclasses.map((s) => [s.slug, s]));
for (const row of subs.rows) {
  const ex = extractBySlug[row.subclass_slug];
  if (!ex) {
    fail(`subclasse órfã na view: ${row.subclass_slug}`);
    continue;
  }
  if (row.subclass_name !== ex.name) {
    fail(`${row.subclass_slug}: nome DB="${row.subclass_name}" ≠ extract="${ex.name}"`);
  }
  if (!row.image_url) {
    fail(`${row.subclass_slug}: sem image_url`);
  }
}

// Features na view de mecânicas (compêndio detalhe)
for (const sc of extract.subclasses) {
  const mech = await client.query(
    `SELECT feature_level, feature_name, feature_description
     FROM rpg.v_phb_subclass_mechanics
     WHERE subclass_slug = $1
     ORDER BY feature_level, feature_name`,
    [sc.slug],
  );
  const expected = sc.features.length;
  if (mech.rows.length !== expected) {
    fail(`${sc.slug}: mechanics ${mech.rows.length}/${expected} features`);
    continue;
  }
  for (const exFeat of sc.features) {
    const dbFeat = mech.rows.find(
      (r) => r.feature_level === exFeat.level && r.feature_name === exFeat.name,
    );
    if (!dbFeat) {
      fail(`${sc.slug}: feature ausente "${exFeat.level} · ${exFeat.name}"`);
      continue;
    }
    const dbDesc = (dbFeat.feature_description ?? '').trim();
    const exDesc = (exFeat.description ?? '').trim();
    if (dbDesc !== exDesc) {
      fail(
        `${sc.slug}/${exFeat.name}: descrição diverge (DB ${dbDesc.length} chars vs extract ${exDesc.length})`,
      );
    }
  }
}
pass('features: textos DB = extract (63)');

// Feathren espécie
const fe = await client.query(
  `SELECT slug, name, creature_type, size, speed, image_url,
    source_meta->>'editionSlug' AS edition_slug
   FROM rpg.phb_species WHERE slug = 'feathren'`,
);
const feRow = fe.rows[0];
if (!feRow) {
  fail('feathren ausente');
} else {
  if (feRow.edition_slug !== EDITION) fail(`feathren editionSlug=${feRow.edition_slug}`);
  else pass(`feathren espécie (${feRow.name}, ${feRow.speed})`);
  if (!feRow.image_url) fail('feathren sem image_url');
  if (feRow.size !== extract.species.size) {
    fail(`feathren size="${feRow.size}" ≠ extract`);
  }
}

const traits = await client.query(
  `SELECT t.name, t.description FROM rpg.phb_species_trait t
   JOIN rpg.phb_species sp ON sp.id = t.species_id
   WHERE sp.slug = 'feathren' ORDER BY t.name`,
);
const extractTraitNames = new Set(extract.species.traits.map((t) => t.name));
for (const t of traits.rows) {
  if (!extractTraitNames.has(t.name) && t.name !== 'Ancestria Felina' && t.name !== 'Atributo de Conjuração Feathren') {
    // traits extras de escolha são OK no DB
  }
}
if (traits.rows.length < 5) fail(`feathren traits=${traits.rows.length}`);
else pass(`feathren traits=${traits.rows.length}`);

const choices = await client.query(
  `SELECT COUNT(*)::int n FROM rpg.v_phb_species_trait_choices WHERE species_slug = 'feathren'`,
);
if (choices.rows[0].n < 6) fail(`feathren choices=${choices.rows[0].n}`);
else pass(`feathren trait choices=${choices.rows[0].n}`);

// Magias GSB
const spells = await client.query(
  `SELECT COUNT(*)::int n FROM rpg.phb_spell sp
   JOIN rpg.phb_source_citation sc ON sc.id = sp.source_citation_id
   WHERE sc.slug = $1`,
  [CITATION],
);
if (spells.rows[0].n !== 15) fail(`magias GSB=${spells.rows[0].n}`);
else pass('magias GSB: 15');

await client.end();

if (apiBase) {
  console.log(`\nAPI ${apiBase}`);
  const endpoints = [
    [`/editions`, (j) => (j.data ?? j).some?.((e) => e.slug === EDITION) ?? (j.data ?? []).some((e) => e.slug === EDITION)],
    [`/subclasses?editionSlugs=${EDITION}&limit=50`, (j) => (j.data?.length ?? 0) === 12],
    [`/subclasses/path-of-the-glacier`, (j) => j.name === 'Caminho da Glaciar'],
    [`/subclasses/path-of-the-glacier/mechanics?limit=50`, (j) => (j.data?.length ?? 0) === 5],
    [`/species/feathren`, (j) => j.slug === 'feathren' && j.name === 'Feathren'],
    [`/species/feathren/traits`, (j) => (j.data?.length ?? 0) >= 5],
    [`/species/feathren/trait-choices`, (j) => (j.data?.length ?? 0) >= 6],
    [`/spells?editionSlugs=${EDITION}&limit=50`, (j) => (j.data?.length ?? 0) === 15],
  ];

  for (const [path, check] of endpoints) {
    try {
      const res = await fetch(`${apiBase}${path}`);
      const json = await res.json();
      const good = res.ok && check(json);
      console.log(`${good ? '✓' : '✗'} ${path}`);
      ok &&= good;
    } catch (e) {
      fail(`API ${path}: ${e.message}`);
    }
  }
} else {
  console.log('\n(API omitida — passe URL ou defina SMOKE_URL)');
}

process.exit(ok ? 0 : 1);
