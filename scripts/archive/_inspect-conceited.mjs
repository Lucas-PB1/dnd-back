import fs from 'fs';
import { scrapDir, scrapes } from '../lib/docs-source.mjs';
import { findGhpgChapterHtml } from '../lib/ghpg-html-utils.mjs';

const html = fs.readFileSync(findGhpgChapterHtml(7, scrapDir, scrapes.grimHollow), 'utf8');

const needles = [
  'Curse of Conceited Obsession',
  '3014', // spell ids nearby
];

const idx = html.indexOf('>Curse of Conceited Obsession</a></h4>');
console.log('conceited h4 idx', idx);
if (idx < 0) {
  // try without closing
  const i2 = html.indexOf('Curse of Conceited Obsession');
  console.log('any', i2);
  console.log(html.slice(i2 - 400, i2 + 200).replace(/\s+/g, ' '));
} else {
  console.log(html.slice(idx - 500, idx + 100).replace(/\s+/g, ' '));
}

const idx2 = html.indexOf('>Shadowsteel Focus</a></h4>');
console.log('\nshadowsteel h4 idx', idx2);
if (idx2 >= 0) {
  console.log(html.slice(idx2 - 500, idx2 + 100).replace(/\s+/g, ' '));
}
