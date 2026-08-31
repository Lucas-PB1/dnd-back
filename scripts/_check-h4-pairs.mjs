import fs from 'fs';
import { scrapDir, scrapes } from './lib/docs-source.mjs';
import { findGhpgChapterHtml, stripTags } from './lib/ghpg-html-utils.mjs';

const html = fs.readFileSync(findGhpgChapterHtml(7, scrapDir, scrapes.grimHollow), 'utf8');

for (const needle of [
  'ShadowsteelFocus',
  'ConceitedObsession',
  'Curse of Conceited',
  'shadowsteel-focus',
]) {
  const idx = html.indexOf(needle);
  console.log(needle, idx);
  if (idx >= 0) {
    console.log(html.slice(Math.max(0, idx - 200), idx + 400).replace(/\s+/g, ' '));
    console.log('---');
  }
}

// For every h4, compare chapter anchor vs tooltip slug
const re =
  /<h4 class="compendium-hr[^"]*"[^>]*>([\s\S]*?)<\/h4>/gi;
let bad = 0;
const samples = [];
for (const m of html.matchAll(re)) {
  const inner = m[1];
  const tip = inner.match(
    /spell-tooltip[^>]*href="[^"]*\/spells\/\d+-([^"?]+)"[^>]*>([^<]+)</i,
  );
  const chap = inner.match(/chapter-7-spells-curses#([A-Za-z0-9]+)/i);
  if (!tip || !chap) continue;
  const tipSlug = tip[1];
  const name = stripTags(tip[2]);
  const anchor = chap[1];
  // convert tipSlug kebab vs anchor camel
  const anchorKebab = anchor
    .replace(/([a-z])([A-Z])/g, '$1-$2')
    .replace(/([A-Z]+)([A-Z][a-z])/g, '$1-$2')
    .toLowerCase();
  if (tipSlug !== anchorKebab && tipSlug.replace(/-/g, '') !== anchor.toLowerCase()) {
    bad++;
    if (samples.length < 15) {
      samples.push({ name, tipSlug, anchor, anchorKebab });
    }
  }
}
console.log('h4 tip/anchor mismatches', bad);
console.log(JSON.stringify(samples, null, 2));
