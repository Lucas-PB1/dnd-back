#!/usr/bin/env node
/**
 * Reorganiza database/seeds/* (packs opacos) → domains/{source}/{tabela}.{slug}.sql
 * Uso: node scripts/reorganize-seeds-to-domains.mjs [--dry-run]
 */
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const seedsRoot = path.join(root, 'database/seeds');
const dryRun = process.argv.includes('--dry-run');

/** @type {Record<string, { domain: string, source: string }>} */
const PACK_DEFAULT = {
  phb: { domain: '_by_table', source: 'phb' },
  subclass: { domain: 'subclass', source: 'phb' },
  valdas: { domain: '_by_table', source: 'valdas' },
  'valdas-gunslinger': { domain: '_by_table', source: 'valdas' },
  'valdas-player-pack-2': { domain: '_by_table', source: 'valdas' },
  'steinhardt-eldritch-hunt': { domain: '_by_table', source: 'steinhardt' },
  'northlands-heroes': { domain: '_by_table', source: 'northlands' },
  'griffons-saddlebag': { domain: 'item', source: 'griffons-saddlebag' },
  'grim-hollow': { domain: '_by_table', source: 'grim-hollow' },
  dmg: { domain: 'item', source: 'dmg' },
  combat: { domain: 'economy', source: 'phb' },
  creatures: { domain: 'creature', source: 'phb' },
  effects: { domain: 'effect', source: 'phb' },
};

const TABLE_DOMAIN = [
  [/^(phb_)?ability|alignment|language|skill|edition|source_citation|weapon_property|armor_category|tool_category|spell_school|fighting_style|condition|damage_type|character_level/, 'catalog'],
  [/^phb_background|background_/, 'background'],
  [/^phb_subclass|subclass_/, 'subclass'],
  [/^phb_class(?!_economy)|(?<!sub)class_feature|(?<!sub)class_progression|class_skill|class_proficiency|class_spellcasting|class_ability_boost|class_panel|starting_package|starting_item/, 'class'],
  [/^phb_species|species_trait/, 'species'],
  [/^phb_feat|feat_benefit|feat_requirement|feat_option|feat_economy/, 'feat'],
  [/^phb_heritage|heritage_/, 'heritage'],
  [/^phb_character_thread|character_thread/, 'thread'],
  [/^phb_item|phb_weapon|phb_armor|phb_tool|item_catalog|dmg_|weapon_mastery/, 'item'],
  [/^phb_spell|spell_slot|spell_class|spell_grant|spell_source/, 'spell'],
  [/^phb_class_economy|phb_resource|resource_definition|battle_master|cunning_strike|gunslinger_maneuver|eldritch_invocation|metamagic|persona_mask|dungeoneer|beastborne/, 'economy'],
  [/^phb_creature|phb_vehicle|creature_|vehicle_|primal_companion|mount|longship|bestiary/, 'creature'],
  [/^phb_effect|effect_/, 'effect'],
  [/^phb_option/, 'catalog'],
];

/** Seeds só de transição — Vasco (não mover). */
const VASCO_BASENAMES = new Set([
  'S010b_phb_feat_slug_rename.sql',
]);

/**
 * @param {string} stem sem .sql e sem prefixo S001_
 */
function detectDomain(stem, packHint) {
  const lower = stem.toLowerCase();
  if (
    /transform|ghpg_transform|cap6|gh-transformation|ghpg_transformation/.test(
      lower,
    )
  ) {
    return 'transformation';
  }
  if (packHint === 'combat' || /economy|combat_modifier|panel_action/.test(lower)) {
    if (/transform|ghpg_cap6|cap6/.test(lower)) return 'transformation';
    // Cap.6 economy actions → economy domain with grim-hollow source override later
    if (/ghpg_cap6|ghpg_transform/.test(lower)) return 'economy';
  }
  for (const [re, domain] of TABLE_DOMAIN) {
    if (re.test(lower)) return domain;
  }
  if (packHint && PACK_DEFAULT[packHint]?.domain !== '_by_table') {
    return PACK_DEFAULT[packHint].domain;
  }
  return 'catalog';
}

/**
 * @param {string} stem
 */
function parseTableAndSlug(stem) {
  const lower = stem.toLowerCase().replace(/_/g, '-');
  // Known tables (longest first)
  const tables = [
    'phb-feat-requirement-weapon-proficiency',
    'phb-feat-requirement-feat-option',
    'phb-feat-requirement-species',
    'phb-feat-requirement-ability',
    'phb-feat-requirement-skill',
    'phb-feat-requirement-feat',
    'phb-character-thread-milestone-benefit',
    'phb-character-thread-milestone',
    'phb-character-thread-goal',
    'phb-character-thread',
    'phb-creature-template-action',
    'phb-creature-template-spell',
    'phb-creature-template-trait',
    'phb-creature-template-speed',
    'phb-creature-template',
    'phb-vehicle-template-action',
    'phb-vehicle-template-trait',
    'phb-vehicle-template-speed',
    'phb-vehicle-template',
    'phb-class-economy-action',
    'phb-class-panel-action',
    'phb-subclass-table-action',
    'phb-subclass-prepared-spell',
    'phb-subclass-precaution-spell',
    'phb-subclass-spellcasting',
    'phb-subclass-progression',
    'phb-subclass-feature',
    'phb-resource-definition',
    'phb-background-boost-option',
    'phb-background-ability-option',
    'phb-background-feat-option',
    'phb-background-tool-option',
    'phb-background-language',
    'phb-background-skill',
    'phb-background',
    'phb-feat-benefit',
    'phb-feat-requirement',
    'phb-feat-option',
    'phb-feat',
    'phb-effect-cast-economy',
    'phb-effect-resource',
    'phb-effect-combat-mod',
    'phb-effect-note',
    'phb-effect-spell',
    'phb-effect',
    'phb-spell-slot-by-level',
    'phb-spell-slot-pattern',
    'phb-spell-school',
    'phb-spell-grant',
    'phb-spell-source',
    'phb-spell-class',
    'phb-spell',
    'phb-class-ability-boost',
    'phb-class-spellcasting',
    'phb-class-proficiency',
    'phb-class-progression',
    'phb-class-feature',
    'phb-class-skill-pool',
    'phb-class',
    'phb-subclass',
    'phb-species-trait',
    'phb-species',
    'phb-heritage-trait',
    'phb-heritage-traditional',
    'phb-heritage',
    'phb-item-catalog-stats',
    'phb-item',
    'phb-weapon-property-link',
    'phb-weapon-property',
    'phb-weapon-mastery',
    'phb-weapon',
    'phb-armor-category',
    'phb-armor',
    'phb-tool-category',
    'phb-tool',
    'phb-starting-package',
    'phb-starting-item',
    'phb-option-value',
    'phb-option-def',
    'phb-source-citation',
    'phb-edition',
    'phb-ability',
    'phb-alignment',
    'phb-language',
    'phb-skill',
    'phb-fighting-style',
    'dmg-artifact-random-property',
    'dmg-sentient-trait-table',
    'phb-battle-master-maneuver',
    'phb-cunning-strike-effect',
    'phb-gunslinger-maneuver',
    'phb-eldritch-invocation',
    'phb-metamagic',
    'phb-persona-mask',
    'phb-dungeoneer-slayer-type',
    'phb-beastborne-aspect-benefit',
    'phb-character-level',
  ];

  for (const table of tables) {
    if (lower === table || lower.startsWith(`${table}-`)) {
      let slug = lower === table ? 'all' : lower.slice(table.length + 1);
      slug = slug
        .replace(/^ghpg-/, 'gh-')
        .replace(/transformation-/, 'transformation-')
        .replace(/^-/, '');
      if (!slug) slug = 'all';
      return { table: table.replace(/-/g, '_'), slug };
    }
  }

  // Fallback: first two segments as table-ish
  const parts = lower.split('-');
  if (parts[0] === 'phb' || parts[0] === 'dmg') {
    const table = parts.slice(0, 2).join('_');
    const slug = parts.slice(2).join('-') || 'all';
    return { table, slug };
  }
  return { table: 'seed', slug: lower };
}

/**
 * Cap.6 / special overrides: exact basename → destination
 * @type {Record<string, { domain: string, source: string, file: string }>}
 */
const SPECIAL = {
  'E008_ghpg_transform.sql': {
    domain: 'transformation',
    source: 'grim-hollow',
    file: 'phb_effect.grant-resource.gh-transformations.sql',
  },
  'E015_ghpg_transform_table_action.sql': {
    domain: 'transformation',
    source: 'grim-hollow',
    file: 'phb_effect.table-note.gh-transformations.sql',
  },
  'J019_phb_feat_ghpg_transformations.sql': {
    domain: 'transformation',
    source: 'grim-hollow',
    file: 'phb_feat.gh-transformations.sql',
  },
  'J060_phb_feat_option_ghpg_transformations.sql': {
    domain: 'transformation',
    source: 'grim-hollow',
    file: 'phb_feat_option.gh-transformations.sql',
  },
  'J061_phb_resource_ghpg_cap6_transformations.sql': {
    domain: 'transformation',
    source: 'grim-hollow',
    file: 'phb_resource_definition.gh-transformations.sql',
  },
  'C078_phb_feat_economy_ghpg_cap6_transformations.sql': {
    domain: 'economy',
    source: 'grim-hollow',
    file: 'phb_class_economy_action.gh-transformations.sql',
  },
  'C075_phb_feat_economy_ghpg_cap4.sql': {
    domain: 'economy',
    source: 'grim-hollow',
    file: 'phb_class_economy_action.gh-cap4-feats.sql',
  },
};

const BENEFIT_MAP = {
  J048: 'aberrant-horror',
  J049: 'fey',
  J050: 'fiend',
  J051: 'hag',
  J052: 'lich',
  J053: 'lycanthrope',
  J054: 'primordial', // may not exist
  J055: 'primordial',
  J056: 'seraph',
  J057: 'shadowsteel-ghoul',
  J058: 'specter',
  J059: 'vampire',
};

function walk(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) walk(p, out);
    else if (e.name.endsWith('.sql')) out.push(p);
  }
  return out;
}

function stripPrefix(name) {
  return name.replace(/^[A-Z]\d{3}[a-z]?_/, '').replace(/\.sql$/i, '');
}

function combatSource(stem) {
  if (/ghpg|grim.?hollow|cap6|cap4/.test(stem)) return 'grim-hollow';
  if (/valdas|gunslinger/.test(stem)) return 'valdas';
  if (/northlands|thread/.test(stem)) return 'northlands';
  if (/dmg|artifact/.test(stem)) return 'dmg';
  if (/steinhardt|eldritch/.test(stem)) return 'steinhardt';
  return 'phb';
}

function effectsSource(stem) {
  if (/ghpg|transform|cap6|grim.?hollow|heritage/.test(stem)) return 'grim-hollow';
  if (/valdas|gunslinger/.test(stem)) return 'valdas';
  if (/northlands|thread/.test(stem)) return 'northlands';
  if (/steinhardt|eldritch/.test(stem)) return 'steinhardt';
  if (/^item$|dmg/.test(stem)) return 'dmg';
  return 'phb';
}

function effectFileName(stem) {
  let s = stem.toLowerCase().replace(/_/g, '-');
  if (s === 'phb') return 'phb_effect.phb.sql';
  s = s.replace(/^phb-/, '');
  return `phb_effect.${s || 'pack'}.sql`;
}

function main() {
  const truncate = path.join(seedsRoot, '000_truncate.sql');
  const oldPacks = Object.keys(PACK_DEFAULT);
  /** @type {{ from: string, to: string }[]} */
  const moves = [];
  /** @type {Set<string>} */
  const used = new Set();

  for (const pack of oldPacks) {
    const packDir = path.join(seedsRoot, pack);
    if (!fs.existsSync(packDir)) continue;
    for (const filePath of walk(packDir)) {
      const base = path.basename(filePath);
      if (VASCO_BASENAMES.has(base) || /_rename|_cleanup|deprecated|_migrate_/i.test(base)) {
        if (!dryRun) {
          fs.unlinkSync(filePath);
          console.log(`Vasco: ${pack}/${base}`);
        } else {
          console.log(`[dry-run] Vasco: ${pack}/${base}`);
        }
        continue;
      }
      let destRel;

      if (SPECIAL[base]) {
        const s = SPECIAL[base];
        destRel = path.join(s.domain, s.source, s.file);
      } else {
        const m = base.match(/^J\d{3}[a-z]?_phb_feat_benefit_ghpg_transformation_(.+)\.sql$/i);
        if (m) {
          const slug = m[1].replace(/_/g, '-');
          destRel = path.join(
            'transformation',
            'grim-hollow',
            `phb_feat_benefit.${slug}.sql`,
          );
        } else {
          const stem = stripPrefix(base);
          const packDef = PACK_DEFAULT[pack];
          let domain = detectDomain(stem, pack);
          let source = packDef.source;
          if (pack === 'combat') source = combatSource(stem);
          if (pack === 'effects') {
            source = effectsSource(stem);
            domain = /transform|cap6|ghpg/.test(stem)
              ? 'transformation'
              : 'effect';
          }
          if (domain === 'transformation') source = 'grim-hollow';

          let fileName;
          if (pack === 'effects') {
            fileName = effectFileName(stem);
          }
          if (!fileName) {
            const { table, slug } = parseTableAndSlug(stem);
            fileName = `${table}.${slug}.sql`;
          }
          destRel = path.join(domain, source, fileName);
        }
      }

      let dest = path.join(seedsRoot, destRel);
      let key = destRel.replace(/\\/g, '/');
      if (used.has(key) || (fs.existsSync(dest) && !dryRun)) {
        const ext = path.extname(dest);
        const baseName = path.basename(dest, ext);
        let i = 2;
        while (used.has(key) || fs.existsSync(dest)) {
          destRel = path.join(
            path.dirname(destRel),
            `${baseName}.${String(i).padStart(2, '0')}${ext}`,
          );
          dest = path.join(seedsRoot, destRel);
          key = destRel.replace(/\\/g, '/');
          i += 1;
        }
      }
      used.add(key);
      moves.push({
        from: filePath,
        to: dest,
      });
    }
  }

  console.log(`${dryRun ? '[dry-run] ' : ''}Moves: ${moves.length}`);
  for (const { from, to } of moves) {
    const relFrom = path.relative(seedsRoot, from).replace(/\\/g, '/');
    const relTo = path.relative(seedsRoot, to).replace(/\\/g, '/');
    if (dryRun) {
      console.log(`  ${relFrom} → ${relTo}`);
      continue;
    }
    fs.mkdirSync(path.dirname(to), { recursive: true });
    fs.renameSync(from, to);
  }

  if (!dryRun) {
    const domainNames = new Set([
      'catalog',
      'background',
      'class',
      'subclass',
      'species',
      'feat',
      'transformation',
      'heritage',
      'thread',
      'item',
      'spell',
      'economy',
      'creature',
      'effect',
    ]);
    for (const pack of oldPacks) {
      if (domainNames.has(pack)) {
        console.warn(
          `SKIP delete seeds/${pack} — nome colide com domínio; limpe arquivos flat manualmente`,
        );
        continue;
      }
      const packDir = path.join(seedsRoot, pack);
      if (!fs.existsSync(packDir)) continue;
      fs.rmSync(packDir, { recursive: true, force: true });
    }
    if (!fs.existsSync(truncate)) {
      console.warn('WARN: 000_truncate.sql missing');
    }
  }

  // sample
  console.log('Sample:');
  for (const { from, to } of moves.slice(0, 15)) {
    console.log(
      `  ${path.relative(seedsRoot, from)} → ${path.relative(seedsRoot, to)}`,
    );
  }
}

main();
