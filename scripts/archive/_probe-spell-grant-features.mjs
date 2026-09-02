/**
 * Extrai nomes de magias dos features PT/EN das 11 subs com gap J029.
 */
import fs from 'fs';
import { extracts } from '../lib/docs-source.mjs';
import { SPELL_SLUG_MAP } from '../lib/ghpg-cap2-spell-slug-map.mjs';

const cap2 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap2SubclassesEn, 'utf8'));
const cap7 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap7Spells, 'utf8'));
const featPt = JSON.parse(
  fs.readFileSync(extracts.grimHollow.cap2FeaturesPt, 'utf8'),
).subclassFeatures;

const GAP = [
  'occultist-guild',
  'collegeof-fools',
  'collegeof-requiems',
  'circleof-mutation',
  'pathofthe-primal-spirit',
  'pathofthe-wrathful-dead',
  'sanguine-thief',
  'highway-rider',
  'wretched-bloodline-sorcery',
  'the-parasite-patron',
  'warriorofthe-leaden-crown',
];

const phbNames = Object.keys(SPELL_SLUG_MAP);
const ghNames = cap7.spells.map((s) => s.name);
const allNames = [...new Set([...phbNames, ...ghNames])].sort(
  (a, b) => b.length - a.length,
);

function findSpellsInText(text) {
  const found = [];
  const lower = text;
  for (const name of allNames) {
    // match whole-ish name
    const re = new RegExp(
      `\\b${name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&').replace(/'/g, "['’]")}\\b`,
      'i',
    );
    if (re.test(lower)) found.push(name);
  }
  return found;
}

for (const slug of GAP) {
  const sc = cap2.subclasses.find((s) => s.slug === slug);
  console.log('\n===' + slug + '===');
  console.log('spellTables', sc?.spellTables?.length ?? 0);
  for (const f of sc?.features ?? []) {
    const key = Object.keys(featPt).find((k) =>
      k.startsWith(`${slug}:${f.level}:`),
    );
    const desc = featPt[key]?.description ?? f.description ?? '';
    const name = featPt[key]?.name ?? f.name;
    const hits = findSpellsInText(desc);
    const looksGrant =
      /always have|prepared|spell list|learn|know|cast|magias|grimório|spaces de magia|spellcasting/i.test(
        desc,
      );
    if (hits.length || looksGrant) {
      console.log(`L${f.level} ${name}`);
      console.log('  hits:', hits.join(', ') || '(none)');
      console.log('  snippet:', desc.slice(0, 220).replace(/\s+/g, ' '));
    }
  }
}
