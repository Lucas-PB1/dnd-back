/**
 * Dump feature texts that look like spell grants for the 11 J029 gaps.
 */
import fs from 'fs';
import { extracts } from './lib/docs-source.mjs';

const cap2 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap2SubclassesEn, 'utf8'));
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

const out = {};
for (const slug of GAP) {
  const sc = cap2.subclasses.find((s) => s.slug === slug);
  out[slug] = (sc?.features ?? [])
    .filter((f) =>
      /always have|prepared|you know the|learn .+ spell|spellcasting|cantrip|Dissonant|Animate Dead|Animal Friendship|Speak with Animals|Bestow Curse|Dominate Person|Dispel Evil|Hold Monster|Telekinesis|Vicious Mockery|Greater Restoration|Remove Curse|Revivify|Cloudkill|Death Ward|Conjure|Sangromancy/i.test(
        f.description ?? '',
      ),
    )
    .map((f) => ({
      level: f.level,
      name: f.name,
      description: f.description,
    }));
}

fs.writeFileSync(
  'docs/source/extracts/grim-hollow/_gap-spell-grant-features.json',
  JSON.stringify(out, null, 2) + '\n',
);
console.log('wrote gap features');
for (const [slug, feats] of Object.entries(out)) {
  console.log(slug, feats.length, feats.map((f) => `L${f.level}:${f.name}`).join(', '));
}
