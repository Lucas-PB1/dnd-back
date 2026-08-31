/**
 * Revalida Cap. 7 extract vs HTML scrap.
 * Uso: node scripts/verify-ghpg-cap7-spells.mjs
 */
import fs from 'fs';
import { extracts, scrapDir, scrapes } from './lib/docs-source.mjs';
import { findGhpgChapterHtml, stripTags } from './lib/ghpg-html-utils.mjs';

const htmlPath = findGhpgChapterHtml(7, scrapDir, scrapes.grimHollow);
const html = fs.readFileSync(htmlPath, 'utf8');
const data = JSON.parse(fs.readFileSync(extracts.grimHollow.cap7Spells, 'utf8'));

const re =
  /<h4 class="compendium-hr[^"]*"[^>]*>[\s\S]*?<a class="tooltip-hover spell-tooltip"[^>]*>([^<]+)<\/a><\/h4>/gi;
const htmlNames = [...html.matchAll(re)].map((m) => stripTags(m[1]));
const jsonNames = data.spells.map((s) => s.name);

const missingInJson = htmlNames.filter((n) => !jsonNames.includes(n));
const extraInJson = jsonNames.filter((n) => !htmlNames.includes(n));
const dupJson = [...new Set(jsonNames.filter((n, i) => jsonNames.indexOf(n) !== i))];
const dupSlug = [
  ...new Set(
    data.spells
      .map((s) => s.slug)
      .filter((s, i, arr) => arr.indexOf(s) !== i),
  ),
];

const short = data.spells.filter((s) => !s.description || s.description.length < 40);
const noSchool = data.spells.filter((s) => !s.school);
const noClass = data.spells.filter((s) => (s.listedClasses || []).length === 0);
const noCt = data.spells.filter((s) => !s.castingTime);
const noRange = data.spells.filter((s) => !s.range);

const sangHtml = [...html.matchAll(/\(Sangromancy\)/gi)].length;
const sangJson = data.spells.filter((s) => s.sangromancy).length;

// Spell list table names (asterisk = sangromancy)
const listBlock = html.match(
  /id="SpellList"[\s\S]*?id="Spells"/i,
);
let listNames = [];
if (listBlock) {
  listNames = [...listBlock[0].matchAll(/>([A-Za-z][^<]*?)(?:\*|<\/)/g)]
    .map((m) => stripTags(m[1]).replace(/\*$/, '').trim())
    .filter((n) => n.length > 2 && !/Level|Cantrip|Spell|Denotes/i.test(n));
}

const nameSlugMismatches = data.spells.filter((s) => {
  const fromName = s.name
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/['’]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
  return fromName !== s.slug;
});

console.log(
  JSON.stringify(
    {
      htmlPath: htmlPath.replace(/\\/g, '/'),
      htmlSpellTooltips: htmlNames.length,
      jsonSpells: jsonNames.length,
      missingInJson,
      extraInJson,
      dupJson,
      dupSlug,
      nameSlugMismatches: nameSlugMismatches.map((s) => ({
        name: s.name,
        slug: s.slug,
      })),
      shortDesc: short.map((s) => ({ slug: s.slug, len: s.description?.length })),
      noSchool: noSchool.map((s) => s.slug),
      noClass: noClass.map((s) => s.slug),
      noCastingTime: noCt.length,
      noRange: noRange.length,
      sangromancyHtmlMentions: sangHtml,
      sangromancyJson: sangJson,
    },
    null,
    2,
  ),
);

const ok =
  missingInJson.length === 0 &&
  extraInJson.length === 0 &&
  dupJson.length === 0 &&
  dupSlug.length === 0 &&
  nameSlugMismatches.length === 0 &&
  short.length === 0 &&
  noSchool.length === 0 &&
  noCt.length === 0;

process.exit(ok ? 0 : 1);
