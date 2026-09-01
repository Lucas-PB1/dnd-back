#!/usr/bin/env node
import { loadEnv } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';
import fs from 'fs';
import { extracts } from './lib/docs-source.mjs';
import {
  advancedWeaponProficiencyRequirement,
  resolveFeatStructuredRequirement,
} from './lib/ghpg-cap4-prerequisite-structured.mjs';

loadEnv();
const cap4 = JSON.parse(fs.readFileSync(extracts.grimHollow.cap4Feats, 'utf8'));
const client = createPgClient(process.env.DATABASE_URL ?? process.env.SUPABASE_DATABASE_URL);
await client.connect();

const { rows } = await client.query(`
  SELECT f.slug,
    r.minimum_level,
    r.requires_spellcasting,
    r.requires_fighting_style,
    COALESCE((
      SELECT json_agg(a.slug ORDER BY a.sort_order)
      FROM rpg.phb_feat_requirement_ability ra
      JOIN rpg.phb_ability a ON a.id = ra.ability_id
      WHERE ra.feat_id = f.id
    ), '[]'::json) AS ability_slugs,
    COALESCE((
      SELECT json_agg(req.slug ORDER BY req.slug)
      FROM rpg.phb_feat_requirement_feat rf
      JOIN rpg.phb_feat req ON req.id = rf.required_feat_id
      WHERE rf.feat_id = f.id
    ), '[]'::json) AS required_feat_slugs
  FROM rpg.phb_feat f
  JOIN rpg.phb_source_citation sc ON sc.id = f.source_citation_id
  LEFT JOIN rpg.phb_feat_requirement r ON r.feat_id = f.id
  WHERE sc.slug = 'grim-hollow-players-guide-2024-en:chapter-4-character-feats'
`);

const expected = new Map();
for (const feat of cap4.feats) {
  const req = feat.requirementStructured ?? resolveFeatStructuredRequirement(feat);
  if (req) expected.set(feat.slug, req);
}
expected.set('advanced-weapon-proficiency', advancedWeaponProficiencyRequirement());

let mismatches = 0;
for (const [slug, req] of expected) {
  const db = rows.find((r) => r.slug === slug);
  if (!db?.minimum_level && req.minimumLevel != null && db?.minimum_level !== req.minimumLevel) {
    // noop - fix logic below
  }
  const issues = [];
  if (!db) {
    issues.push('missing row');
  } else {
    if ((db.minimum_level ?? null) !== req.minimumLevel) {
      issues.push(`minLevel db=${db.minimum_level} expected=${req.minimumLevel}`);
    }
    if (Boolean(db.requires_spellcasting) !== req.requiresSpellcasting) {
      issues.push('requiresSpellcasting');
    }
    if (Boolean(db.requires_fighting_style) !== req.requiresFightingStyle) {
      issues.push('requiresFightingStyle');
    }
    const dbAbilities = (db.ability_slugs ?? []).sort();
    const expAbilities = req.abilityPrerequisites.map((a) => a.abilitySlug).sort();
    if (JSON.stringify(dbAbilities) !== JSON.stringify(expAbilities)) {
      issues.push(`abilities db=${dbAbilities} expected=${expAbilities}`);
    }
    const dbFeats = (db.required_feat_slugs ?? []).sort();
    const expFeats = [...req.requiredFeatSlugs].sort();
    if (JSON.stringify(dbFeats) !== JSON.stringify(expFeats)) {
      issues.push(`featDeps db=${dbFeats} expected=${expFeats}`);
    }
  }
  if (issues.length) {
    mismatches += 1;
    console.log(`✗ ${slug}: ${issues.join('; ')}`);
  }
}

const missingReq = rows.filter((r) => r.slug !== 'blood-hound' && expected.has(r.slug) === false);
const originWithoutReq = cap4.feats.filter((f) => f.category === 'origin').map((f) => f.slug);
const unexpectedDbReq = rows.filter(
  (r) => originWithoutReq.includes(r.slug) && r.minimum_level != null,
);

console.log(`Expected structured: ${expected.size}`);
console.log(`Mismatches: ${mismatches}`);
if (unexpectedDbReq.length) {
  console.warn('Origin feats with requirements:', unexpectedDbReq.map((r) => r.slug));
}

await client.end();
process.exit(mismatches > 0 ? 1 : 0);
