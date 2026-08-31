import fs from 'fs';
import { scrapDir, scrapes } from './lib/docs-source.mjs';
import { findGhpgChapterHtml, stripTags } from './lib/ghpg-html-utils.mjs';

const html = fs.readFileSync(findGhpgChapterHtml(7, scrapDir, scrapes.grimHollow), 'utf8');
const idx = html.indexOf('id="ShadowsteelFocus"');
console.log('idx', idx);
console.log(html.slice(idx, idx + 800).replace(/\s+/g, ' '));

// count h4 without spell-tooltip
const h4s = [...html.matchAll(/<h4 class="compendium-hr[^"]*"[^>]*>([\s\S]*?)<\/h4>/gi)];
let withTip = 0;
let without = [];
for (const m of h4s) {
  const inner = m[1];
  const tip = /spell-tooltip/i.test(inner);
  const id = (m[0].match(/id="([^"]+)"/) || [])[1];
  if (tip) withTip++;
  else without.push(id || stripTags(inner).slice(0, 40));
}
console.log('h4 total', h4s.length, 'withTip', withTip, 'without', without.length);
console.log(without);
