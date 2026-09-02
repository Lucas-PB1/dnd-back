import fs from 'fs';
import { scrapDir, scrapes, extracts } from '../lib/docs-source.mjs';
import { findGhpgChapterHtml, stripTags, anchorToSlug } from '../lib/ghpg-html-utils.mjs';

const html = fs.readFileSync(findGhpgChapterHtml(7, scrapDir, scrapes.grimHollow), 'utf8');
const data = JSON.parse(fs.readFileSync(extracts.grimHollow.cap7Spells, 'utf8'));

// Find spells where name slug != stored slug
const bad = data.spells.filter((s) => {
  const fromName = s.name
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
  return fromName !== s.slug;
});
console.log('name-vs-slug mismatches', bad.length);
for (const s of bad.slice(0, 20)) {
  console.log({ name: s.name, slug: s.slug, anchorId: s.anchorId });
}

// Inspect HTML h4 for first bad
if (bad[0]) {
  const name = bad[0].name;
  const idx = html.indexOf(`>${name}</a></h4>`);
  console.log('\nHTML around', name, 'idx', idx);
  console.log(html.slice(idx - 350, idx + 80).replace(/\s+/g, ' '));
}
