#!/usr/bin/env node
/**
 * Classifica mecânicas dos talentos GH Cap. 4 para Fase C/D.
 * Uso: node scripts/classify-ghpg-cap4-mechanics.mjs
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { extracts } from './lib/docs-source.mjs';
import {
  CAP4_ECONOMY_P0,
  CAP4_ECONOMY_P1_SLUGS,
} from './lib/ghpg-cap4-economy-config.mjs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const apiRoot = path.join(__dirname, '..');
const cap4Path = extracts.grimHollow.cap4Feats;
const outPath = path.join(
  apiRoot,
  'docs/source/extracts/grim-hollow/_audit-cap4-mechanics.json',
);

const cap4 = JSON.parse(fs.readFileSync(cap4Path, 'utf8'));
const p0ByFeat = new Map(CAP4_ECONOMY_P0.map((row) => [row.featSlug, row]));
const p0BenefitKeys = new Set(
  CAP4_ECONOMY_P0.map((row) => `${row.featSlug}:${row.benefitKey}`),
);

/** @type {Record<string, number>} */
const bucketCounts = {
  economy: 0,
  'passive-note': 0,
  'combat-modifier': 0,
  'spell-grant': 0,
  skip: 0,
};

const entries = [];

for (const feat of cap4.feats) {
  const featP0 = CAP4_ECONOMY_P0.filter((row) => row.featSlug === feat.slug);
  const isP1 = CAP4_ECONOMY_P1_SLUGS.includes(feat.slug);

  if (featP0.length) {
    for (const row of featP0) {
      bucketCounts.economy += 1;
      entries.push({
        featSlug: feat.slug,
        benefitName: row.benefitKey,
        bucket: 'economy',
        economy: row.economy,
        actionId: row.actionId,
      });
    }
    continue;
  }

  if (isP1) {
    bucketCounts['combat-modifier'] += feat.benefits.length || 1;
    for (const benefit of feat.benefits) {
      entries.push({
        featSlug: feat.slug,
        benefitName: benefit.name,
        bucket: 'combat-modifier',
        actionEconomy: benefit.actionEconomy ?? [],
      });
    }
    continue;
  }

  for (const benefit of feat.benefits) {
    const key = `${feat.slug}:${benefit.name}`;
    let bucket = 'passive-note';

    if (/spell|magic|conjur|curse|maldição/i.test(benefit.description)) {
      bucket = 'spell-grant';
    }
    if (
      /Ability Score Increase|Proficiency|proficiência|Aumento de Atributo/i.test(
        benefit.name,
      )
    ) {
      bucket = 'skip';
    }
    if (benefit.actionEconomy?.length && !p0BenefitKeys.has(key)) {
      bucket = 'passive-note';
    }

    bucketCounts[bucket] += 1;
    entries.push({
      featSlug: feat.slug,
      benefitName: benefit.name,
      bucket,
      actionEconomy: benefit.actionEconomy ?? [],
    });
  }

  if (!feat.benefits.length) {
    bucketCounts['passive-note'] += 1;
    entries.push({
      featSlug: feat.slug,
      benefitName: null,
      bucket: 'passive-note',
      actionEconomy: feat.actionEconomy ?? [],
    });
  }
}

const output = {
  generatedAt: new Date().toISOString(),
  featCount: cap4.featCount,
  p0ActionCount: CAP4_ECONOMY_P0.length,
  bucketCounts,
  entries,
};

fs.writeFileSync(outPath, `${JSON.stringify(output, null, 2)}\n`, 'utf8');
console.log(`Wrote ${outPath}`);
console.log('Buckets:', bucketCounts);
console.log(`P0 economy actions: ${CAP4_ECONOMY_P0.length}`);
