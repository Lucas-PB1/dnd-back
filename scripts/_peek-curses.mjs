import fs from 'fs';
import { extracts } from './lib/docs-source.mjs';

const data = JSON.parse(fs.readFileSync(extracts.grimHollow.cap7Spells, 'utf8'));
for (const slug of [
  'shadowsteel-focus',
  'curse-of-crushing-sensation',
  'curse-of-damned-aging',
]) {
  const s = data.spells.find((x) => x.slug === slug);
  console.log(JSON.stringify(s, null, 2));
  console.log('---');
}
