import fs from 'fs';
import { extracts } from '../lib/docs-source.mjs';
import { anchorToSlug } from '../lib/ghpg-html-utils.mjs';

const data = JSON.parse(fs.readFileSync(extracts.grimHollow.cap7Spells, 'utf8'));
const mismatches = [];
for (const s of data.spells) {
  const fromName = s.name
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
  const fromAnchor = s.anchorId ? anchorToSlug(s.anchorId) : null;
  if (fromAnchor && fromAnchor !== s.slug) {
    mismatches.push({ name: s.name, slug: s.slug, anchor: s.anchorId, fromAnchor });
  }
  // soft: name slug vs stored slug
  if (fromName !== s.slug && fromAnchor !== s.slug) {
    mismatches.push({ kind: 'name-vs-slug', name: s.name, fromName, slug: s.slug });
  }
}
console.log('mismatches', mismatches.length);
console.log(JSON.stringify(mismatches.slice(0, 40), null, 2));
