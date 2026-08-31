#!/usr/bin/env node
/**
 * Gera manifest D4 + valida cobertura de notas GH Cap. 2.
 * Uso: node scripts/generate-gh-cap2-combat-passives.mjs
 */
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const en = JSON.parse(
  fs.readFileSync(
    path.join(root, 'docs/source/extracts/grim-hollow/cap2-subclasses-en.json'),
    'utf8',
  ),
);
const dataTs = fs.readFileSync(
  path.join(
    root,
    'src/game/combat/domain/grim-hollow-subclass-combat-notes-data.ts',
  ),
  'utf8',
);

const allSubs = en.subclasses.map((s) => s.slug);

const notedSubs = [
  ...dataTs.matchAll(/^\s+['"]?([a-z0-9-]+)['"]?:\s*\[/gm),
]
  .map((m) => m[1])
  .filter((s) => allSubs.includes(s));

const missing = allSubs.filter((s) => !notedSubs.includes(s));
const extra = notedSubs.filter((s) => !allSubs.includes(s));

const HP_RE =
  /hit point maximum increases by (\d+).*?increases by (\d+) whenever you gain another (\w+) level/i;

/** @type {Array<{subclassSlug:string,feature:string,level:number,flat:number,perLevel:number,fromLevel:number,classKeyword:string,conditional:boolean}>} */
const hpCandidates = [];

for (const sc of en.subclasses) {
  for (const f of sc.features) {
    const text = `${f.name}\n${f.description || ''}`;
    const m = HP_RE.exec(text);
    if (!m) continue;
    const conditional =
      /choose one|when you|while your|as a bonus action|once per/i.test(text);
    hpCandidates.push({
      subclassSlug: sc.slug,
      feature: f.name,
      level: f.level,
      flat: Number(m[1]),
      perLevel: Number(m[2]),
      fromLevel: f.level,
      classKeyword: m[3].toLowerCase(),
      conditional,
    });
  }
}

const manifest = {
  generatedAt: new Date().toISOString(),
  subclassCount: allSubs.length,
  notedSubclassCount: notedSubs.length,
  missingNotes: missing,
  extraNotes: extra,
  hpCandidates,
  hpSeedable: hpCandidates.filter((r) => !r.conditional),
};

const outDir = path.join(root, 'docs/source/extracts/grim-hollow');
fs.writeFileSync(
  path.join(outDir, '_gh-cap2-combat-notes-manifest.json'),
  `${JSON.stringify(manifest, null, 2)}\n`,
);

const c074 = `-- GH Cap. 2 — combat modifiers bulk (D4)
-- Gerado por scripts/generate-gh-cap2-combat-passives.mjs
-- Regra: só hp_bonus incondicional; resist/CA/velocidade → classCombatNotes.
-- sangromancer: C069 (não duplicar).

${manifest.hpSeedable
  .filter((r) => r.subclassSlug !== 'sangromancer')
  .map((r) => `-- SKIP ${r.subclassSlug} (${r.feature}): condicional ou escolha do jogador`)
  .join('\n') || '-- Nenhum hp_bonus adicional incondicional além de sangromancer (C069).'}
`;

fs.writeFileSync(
  path.join(root, 'database/seeds/combat/C074_phb_combat_modifier_grim_hollow_cap2.sql'),
  `${c074}\n`,
);

console.log('subclasses:', allSubs.length);
console.log('noted:', notedSubs.length);
if (missing.length) console.log('missing:', missing.join(', '));
if (extra.length) console.log('extra:', extra.join(', '));
console.log('hp seedable:', manifest.hpSeedable.length);
console.log('wrote _gh-cap2-combat-notes-manifest.json');
console.log('wrote C074_phb_combat_modifier_grim_hollow_cap2.sql');

if (missing.length) process.exit(1);
