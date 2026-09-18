/**
 * Mescla tmp/cap2-pt/batch-*-out.json → docs/.../cap2-features-pt.json
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const dir = path.join(root, 'tmp/cap2-pt');
const overlayPath = path.join(
  root,
  'docs/source/extracts/grim-hollow/cap2-features-pt.json',
);
const allEnPath = path.join(dir, 'all-en.json');

const allEn = JSON.parse(fs.readFileSync(allEnPath, 'utf8'));
const expected = Object.keys(allEn);
const merged = {};

for (let i = 1; i <= 4; i++) {
  const p = path.join(dir, `batch-${i}-out.json`);
  if (!fs.existsSync(p)) {
    console.error(`Missing ${p}`);
    process.exit(1);
  }
  const part = JSON.parse(fs.readFileSync(p, 'utf8'));
  Object.assign(merged, part);
}

const missing = expected.filter((k) => !merged[k]?.description);
const extra = Object.keys(merged).filter((k) => !allEn[k]);
if (missing.length || extra.length) {
  console.error({ missing: missing.slice(0, 20), missingCount: missing.length, extra });
  process.exit(1);
}

const overlay = {
  generatedAt: new Date().toISOString(),
  source: 'docs/source/extracts/grim-hollow/cap2-subclasses-en.json',
  subclassFeatures: {},
};
for (const k of expected) {
  overlay.subclassFeatures[k] = {
    name: merged[k].name || allEn[k].name,
    description: merged[k].description,
  };
}

fs.writeFileSync(overlayPath, JSON.stringify(overlay, null, 2) + '\n', 'utf8');
console.log(JSON.stringify({ keys: expected.length, out: overlayPath }, null, 2));
