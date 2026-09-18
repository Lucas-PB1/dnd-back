/**
 * Aplica docs/source/extracts/grim-hollow/cap2-features-pt.json
 * sobre database/seeds/subclass/grim-hollow/phb_subclass_feature.all.sql
 * (name + description por chave subclass:level:enName).
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const overlayPath = path.join(
  root,
  'docs/source/extracts/grim-hollow/cap2-features-pt.json',
);
const enPath = path.join(
  root,
  'docs/source/extracts/grim-hollow/cap2-subclasses-en.json',
);
const seedPath = path.join(
  root,
  'database/seeds/subclass/grim-hollow/phb_subclass_feature.all.sql',
);
const auditPath = path.join(
  root,
  'docs/source/extracts/grim-hollow/_audit-cap2-pt.json',
);

function sqlString(value) {
  return "'" + String(value).replace(/'/g, "''") + "'";
}

/** Extrai INSERT … VALUES (select, level, name, description) blocks. */
function parseSeedBlocks(sql) {
  const blocks = [];
  const re =
    /INSERT INTO rpg\.phb_subclass_feature \(\s*subclass_id, level, name, description\s*\)\s*VALUES \(\s*\(SELECT id FROM rpg\.phb_subclass WHERE slug = '([^']+)'\),\s*(\d+),\s*'((?:[^']|'')*)',\s*'((?:[^']|'')*)'\s*\)\s*ON CONFLICT \(subclass_id, level, name\) DO UPDATE SET\s*description = EXCLUDED\.description;/g;
  let m;
  while ((m = re.exec(sql))) {
    blocks.push({
      full: m[0],
      slug: m[1],
      level: Number(m[2]),
      name: m[3].replace(/''/g, "'"),
      description: m[4].replace(/''/g, "'"),
      index: m.index,
    });
  }
  return blocks;
}

function enKeyMap(enBook) {
  /** slug:level:enName → {enName} */
  const map = [];
  for (const sc of enBook.subclasses || []) {
    for (const f of sc.features || []) {
      map.push({
        slug: sc.slug,
        level: f.level,
        enName: f.name,
        key: `${sc.slug}:${f.level}:${f.name}`,
      });
    }
  }
  return map;
}

const overlay = JSON.parse(fs.readFileSync(overlayPath, 'utf8'));
const enBook = JSON.parse(fs.readFileSync(enPath, 'utf8'));
const sql = fs.readFileSync(seedPath, 'utf8');
const blocks = parseSeedBlocks(sql);
const enFeatures = enKeyMap(enBook);

if (blocks.length !== enFeatures.length) {
  console.warn(
    `Aviso: seed blocks=${blocks.length} vs EN features=${enFeatures.length}`,
  );
}

/** Match seed block i ↔ EN feature i (mesma ordem de extração). */
let applied = 0;
let missing = [];
let out = sql;

/** Rebuild from scratch for safety (order preserved). */
const header =
  '-- Grim Hollow Cap. 2 — subclass features\n' +
  '-- Fonte: docs/source/extracts/grim-hollow/cap2-subclasses-en.json\n' +
  '-- Overlay PT: docs/source/extracts/grim-hollow/cap2-features-pt.json\n\n';

const parts = [];
for (let i = 0; i < enFeatures.length; i++) {
  const ef = enFeatures[i];
  const ov = overlay.subclassFeatures?.[ef.key];
  if (!ov?.name || !ov?.description) {
    missing.push(ef.key);
    const fallback = blocks[i];
    const name = ov?.name || fallback?.name || ef.enName;
    const description =
      ov?.description || fallback?.description || '';
    parts.push(
      `INSERT INTO rpg.phb_subclass_feature (\n` +
        `  subclass_id, level, name, description\n` +
        `)\n` +
        `VALUES (\n` +
        `  (SELECT id FROM rpg.phb_subclass WHERE slug = '${ef.slug}'),\n` +
        `  ${ef.level},\n` +
        `  ${sqlString(name)},\n` +
        `  ${sqlString(description)}\n` +
        `)\n` +
        `ON CONFLICT (subclass_id, level, name) DO UPDATE SET\n` +
        `  description = EXCLUDED.description;`,
    );
    continue;
  }
  applied++;
  parts.push(
    `INSERT INTO rpg.phb_subclass_feature (\n` +
      `  subclass_id, level, name, description\n` +
      `)\n` +
      `VALUES (\n` +
      `  (SELECT id FROM rpg.phb_subclass WHERE slug = '${ef.slug}'),\n` +
      `  ${ef.level},\n` +
      `  ${sqlString(ov.name)},\n` +
      `  ${sqlString(ov.description)}\n` +
      `)\n` +
      `ON CONFLICT (subclass_id, level, name) DO UPDATE SET\n` +
      `  description = EXCLUDED.description;`,
  );
}

fs.writeFileSync(seedPath, header + parts.join('\n\n') + '\n', 'utf8');

const enWordRe =
  /\b(the|and|you|your|with|from|when|that|this|have|has|are|was|were|will|can|may|must|into|their|them|they|for|not|but|or|as|an|of|to|in|on|at|by|is|be|do|does|did|if|before|after|until|during|against|level|damage|creature|attack|spell|cast|bonus|action|reaction|advantage|disadvantage|gain|make|take|deal|using|within|instead|once|finish|rest|short|long|choose|force|equals|between|through|each|other|more|most|some|any|all|both)\b/i;

function residualScore(desc) {
  if (!desc) return { en: 0, words: 0, ratio: 0 };
  const words = desc.split(/\s+/).filter(Boolean);
  let en = 0;
  for (const w of words) {
    const c = w.replace(/[^a-zA-Z']/g, '');
    if (c && enWordRe.test(c)) en++;
  }
  return {
    en,
    words: words.length,
    ratio: words.length ? en / words.length : 0,
  };
}

function isResidual(desc) {
  const s = residualScore(desc);
  return s.ratio > 0.12 || (s.en >= 8 && s.ratio > 0.08);
}

const residual = [];
for (const [key, v] of Object.entries(overlay.subclassFeatures || {})) {
  if (isResidual(v.description)) {
    residual.push({
      key,
      name: v.name,
      ...residualScore(v.description),
    });
  }
}
residual.sort((a, b) => b.ratio - a.ratio);

const audit = {
  generatedAt: new Date().toISOString(),
  total: Object.keys(overlay.subclassFeatures || {}).length,
  applied,
  missingOverlay: missing,
  residualCount: residual.length,
  residualMeta: 30,
  residual: residual.map((r) => ({
    key: r.key,
    name: r.name,
    ratio: +r.ratio.toFixed(3),
    enWords: r.en,
  })),
};
fs.writeFileSync(auditPath, JSON.stringify(audit, null, 2) + '\n', 'utf8');

console.log(
  JSON.stringify(
    {
      applied,
      missing: missing.length,
      residual: residual.length,
      seedBlocks: parts.length,
    },
    null,
    2,
  ),
);
