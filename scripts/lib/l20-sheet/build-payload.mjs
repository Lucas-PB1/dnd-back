import { pickN, pickRandom, shuffle } from './random.mjs';
import { loadAndPickEldritchInvocationOptions } from './eldritch-invocations.mjs';

const LEVEL = 20;
const OPTIONAL_SPECIES_KINDS = new Set(['high_elf_cantrip']);

const BASE_ASI = [4, 8, 12, 16, 19];
const EXTRA_ASI = { fighter: [6, 14], rogue: [10] };

const PRIMARY_SCORES = {
  barbarian: { forca: 15, constituicao: 14, destreza: 13, sabedoria: 12, carisma: 10, inteligencia: 8 },
  bard: { carisma: 15, destreza: 14, constituicao: 13, sabedoria: 12, inteligencia: 10, forca: 8 },
  cleric: { sabedoria: 15, constituicao: 14, forca: 13, carisma: 12, destreza: 10, inteligencia: 8 },
  druid: { sabedoria: 15, constituicao: 14, destreza: 13, inteligencia: 12, forca: 10, carisma: 8 },
  fighter: { forca: 15, constituicao: 14, destreza: 13, sabedoria: 12, carisma: 10, inteligencia: 8 },
  gunslinger: { destreza: 15, constituicao: 14, sabedoria: 13, carisma: 12, inteligencia: 10, forca: 8 },
  monk: { destreza: 15, sabedoria: 14, constituicao: 13, forca: 12, carisma: 10, inteligencia: 8 },
  paladin: { forca: 15, carisma: 14, constituicao: 13, sabedoria: 12, destreza: 10, inteligencia: 8 },
  ranger: { destreza: 15, sabedoria: 14, constituicao: 13, forca: 12, inteligencia: 10, carisma: 8 },
  rogue: { destreza: 15, inteligencia: 14, constituicao: 13, sabedoria: 12, carisma: 10, forca: 8 },
  sorcerer: { carisma: 15, constituicao: 14, destreza: 13, sabedoria: 12, inteligencia: 10, forca: 8 },
  warlock: { carisma: 15, constituicao: 14, destreza: 13, sabedoria: 12, inteligencia: 10, forca: 8 },
  wizard: { inteligencia: 15, constituicao: 14, destreza: 13, sabedoria: 12, carisma: 10, forca: 8 },
};

const PRIMARY_ABILITY = {
  barbarian: 'forca',
  bard: 'carisma',
  cleric: 'sabedoria',
  druid: 'sabedoria',
  fighter: 'forca',
  gunslinger: 'destreza',
  monk: 'destreza',
  paladin: 'forca',
  ranger: 'destreza',
  rogue: 'destreza',
  sorcerer: 'carisma',
  warlock: 'carisma',
  wizard: 'inteligencia',
};

const PREPARED = new Set(['cleric', 'druid', 'paladin', 'wizard']);

const EXPERTISE_SLOTS = {
  rogue: 4,
  bard: 4,
  ranger: 3,
  wizard: 1,
};

/**
 * @param {import('pg').Client} client
 * @param {ReturnType<import('./catalog.mjs').indexCatalog>} idx
 * @param {{ classSlug: string, seedLabel?: string, preferredSubclassSlug?: string }} opts
 */
export async function buildL20Payload(client, idx, opts) {
  const classSlug = opts.classSlug;
  const cls = idx.classes.find((c) => c.slug === classSlug);
  if (!cls) throw new Error(`Classe desconhecida: ${classSlug}`);

  const subclassPool = idx.subclassByClass.get(classSlug) ?? [];
  const subclassSlug =
    opts.preferredSubclassSlug && subclassPool.includes(opts.preferredSubclassSlug)
      ? opts.preferredSubclassSlug
      : pickRandom(subclassPool);
  if (!subclassSlug) throw new Error(`Sem subclasse para ${classSlug}`);
  const species = pickSpecies(idx);
  const background = pickBackground(idx);
  const bgSkillSet = new Set(idx.bgSkills.get(background.slug) ?? []);

  let skillPool = (idx.poolByClass.get(classSlug) ?? []).filter((s) => !bgSkillSet.has(s));
  if (skillPool.length < cls.skillChoiceCount) {
    skillPool = [...(idx.poolByClass.get(classSlug) ?? [])];
  }
  const classSkillSlugs = pickN(skillPool, cls.skillChoiceCount);
  if (classSkillSlugs.length !== cls.skillChoiceCount) {
    throw new Error(
      `Perícias insuficientes para ${classSlug}: preciso ${cls.skillChoiceCount}, tenho ${classSkillSlugs.length}`,
    );
  }

  const speciesChoices = pickSpeciesChoices(idx, species.slug);
  const subclassOptions = await loadSubclassOptions(client, subclassSlug);
  const characterSpells = buildSpells(idx, classSlug);
  const classOptions = await buildClassOptions(
    client,
    idx,
    classSlug,
    classSkillSlugs,
    bgSkillSet,
    characterSpells,
  );
  const { characterFeats, featOptions } = buildFeats(idx, classSlug, background);
  const languageSlugs = pickLanguages(idx, background);
  const equipment = buildEquipment(idx, classSlug, background.slug);

  const boost = pickBoostAbility(idx, background.slug, classSlug);

  const name = opts.seedLabel
    ? opts.seedLabel
    : `L20 · ${cls.name} · ${subclassSlug}`;

  const toolSlug = pickTool(idx, background);

  return {
    name,
    level: LEVEL,
    classSlug,
    speciesSlug: species.slug,
    backgroundSlug: background.slug,
    subclassSlug,
    alignmentSlug: pickRandom([
      'lawful-good',
      'true-neutral',
      'chaotic-neutral',
      'lawful-neutral',
    ]),
    classSkillSlugs,
    languageSlugs,
    backgroundAbilityBoostMode: 'plus2plus1',
    backgroundAbilityBoostPlus2Slug: boost.plus2,
    backgroundAbilityBoostPlus1Slug: boost.plus1,
    ...(toolSlug ? { backgroundToolItemSlug: toolSlug } : {}),
    abilityGenerationMethodSlug: 'standard-array',
    abilityScores: { ...(PRIMARY_SCORES[classSlug] ?? PRIMARY_SCORES.fighter) },
    speciesChoices,
    subclassOptions,
    classOptions,
    characterFeats,
    featOptions,
    characterSpells,
    equipment,
  };
}

function pickSpecies(idx) {
  // Preferir espécies com escolhas tipadas para exercitar o path; senão qualquer.
  const withChoices = idx.species.filter((s) => idx.choicesBySpecies.has(s.slug));
  const pool = withChoices.length > 0 ? withChoices : idx.species;
  return pickRandom(pool);
}

/** Antecedentes com feat de origem simples (sem options obrigatórias complexas). */
const SAFE_BACKGROUND_SLUGS = [
  'soldier',
  'farmer',
  'sailor',
  'criminal',
  'charlatan',
  'guard',
  'merchant',
  'noble',
];

function pickBackground(idx) {
  const safe = idx.backgrounds.filter((b) => SAFE_BACKGROUND_SLUGS.includes(b.slug));
  const pool = safe.length > 0 ? safe : idx.backgrounds;
  for (let attempt = 0; attempt < 20; attempt += 1) {
    const background = pickRandom(pool);
    const featSlug = background.originFeatSlug;
    if (!featSlug) return background;
    // Feats com opções de magia (Magic Initiate etc.) — evitar no gerador L20.
    const defs = (idx.featDefsBySlug.get(featSlug) ?? []).filter(
      (d) => featSlug !== 'ability-score-improvement',
    );
    if (defs.some((d) => d.valueType === 'spell')) continue;
    if (defs.length === 0) return background;
    const filled = pickFeatOptions(idx, featSlug, 0);
    if (filled.length >= defs.length) return background;
  }
  const soldier = idx.backgrounds.find((b) => b.slug === 'soldier');
  return soldier ?? pickRandom(idx.backgrounds);
}

function pickSpeciesChoices(idx, speciesSlug) {
  const byKind = idx.choicesBySpecies.get(speciesSlug);
  if (!byKind) return [];

  const BLOCKED_ORIGIN_FEATS = new Set([
    'magic-initiate',
    'musician',
    'artisan',
    'crafter',
  ]);

  const choices = [];
  for (const [kind, slugs] of byKind) {
    if (OPTIONAL_SPECIES_KINDS.has(kind)) continue;
    let pool = slugs;
    if (kind === 'human_origin_feat') {
      pool = slugs.filter((slug) => {
        if (BLOCKED_ORIGIN_FEATS.has(slug)) return false;
        const defs = (idx.featDefsBySlug.get(slug) ?? []).filter(
          (d) => d.valueType !== 'spell',
        );
        if ((idx.featDefsBySlug.get(slug) ?? []).some((d) => d.valueType === 'spell')) {
          return false;
        }
        if (defs.length === 0) return true;
        return pickFeatOptions(idx, slug, 0).length >= defs.length;
      });
      if (!pool.length) {
        pool = ['alert', 'tough', 'lucky', 'savage-attacker'].filter((s) =>
          slugs.includes(s),
        );
      }
      if (!pool.length) pool = slugs.filter((s) => !BLOCKED_ORIGIN_FEATS.has(s));
      if (!pool.length) pool = slugs;
    }
    let choiceSlug = pickRandom(pool);
    // geppettin medium exige marionette
    if (speciesSlug === 'geppettin' && kind === 'geppettin_size' && choiceSlug === 'medium') {
      const constructions = byKind.get('geppettin_construction') ?? [];
      if (constructions.includes('marionette')) {
        // força construction depois
      } else {
        choiceSlug = pickRandom(slugs.filter((s) => s !== 'medium'));
      }
    }
    choices.push({ choiceKind: kind, choiceSlug });
  }

  if (speciesSlug === 'geppettin') {
    const size = choices.find((c) => c.choiceKind === 'geppettin_size');
    const construction = choices.find((c) => c.choiceKind === 'geppettin_construction');
    if (size?.choiceSlug === 'medium' && construction) {
      construction.choiceSlug = 'marionette';
    }
  }

  // high elf cantrip opcional
  if (speciesSlug === 'elf') {
    const lineage = choices.find((c) => c.choiceKind === 'elf_lineage');
    if (lineage?.choiceSlug === 'high-elf') {
      const cantrips = byKind.get('high_elf_cantrip');
      if (cantrips?.length) {
        choices.push({ choiceKind: 'high_elf_cantrip', choiceSlug: pickRandom(cantrips) });
      }
    }
  }

  return choices;
}

async function loadSubclassOptions(client, subclassSlug) {
  const keys = (
    await client.query(
      `SELECT def.option_key AS "optionKey"
       FROM rpg.phb_option_def def
       JOIN rpg.phb_subclass s ON s.id = def.owner_id
       WHERE def.scope = 'subclass' AND s.slug = $1 AND def.unlock_level <= $2
       ORDER BY def.option_key`,
      [subclassSlug, LEVEL],
    )
  ).rows;

  const out = [];
  for (const { optionKey } of keys) {
    const values = (
      await client.query(
        `SELECT v.value_id AS "valueId"
         FROM rpg.phb_option_value v
         JOIN rpg.phb_subclass s ON s.id = v.owner_id
         WHERE v.scope = 'subclass' AND s.slug = $1 AND v.option_key = $2
         ORDER BY v.sort_order, v.value_id`,
        [subclassSlug, optionKey],
      )
    ).rows;
    if (!values[0]) {
      throw new Error(`Sem valores para ${subclassSlug}.${optionKey}`);
    }
    out.push({ optionKey, valueId: pickRandom(values).valueId });
  }
  return out;
}

const MASTERY_PICKS = {
  barbarian: [
    'greataxe',
    'battleaxe',
    'maul',
    'longsword',
    'handaxe',
    'javelin',
    'greatsword',
    'flail',
  ],
  fighter: [
    'longsword',
    'greataxe',
    'longbow',
    'rapier',
    'battleaxe',
    'greatsword',
    'dagger',
    'warhammer',
  ],
  gunslinger: [
    'pistol',
    'revolver',
    'musket',
    'longbow',
    'handgun',
    'light-crossbow',
  ],
  paladin: [
    'longsword',
    'warhammer',
    'battleaxe',
    'javelin',
    'flail',
    'greatsword',
  ],
  ranger: [
    'longbow',
    'shortsword',
    'longsword',
    'dagger',
    'scimitar',
    'handaxe',
  ],
  rogue: ['rapier', 'shortsword', 'dagger', 'shortbow', 'hand-crossbow'],
};

async function buildClassOptions(
  client,
  idx,
  classSlug,
  classSkillSlugs,
  bgSkillSet,
  characterSpells = [],
) {
  const options = [];
  const expertiseCount = EXPERTISE_SLOTS[classSlug] ?? 0;
  if (expertiseCount > 0) {
    const pool =
      classSlug === 'wizard'
        ? [...classSkillSlugs]
        : [...new Set([...classSkillSlugs, ...bgSkillSet])];
    const picks = pickN(pool, expertiseCount);
    picks.forEach((skill, i) => {
      options.push({ optionKey: `expertiseSkill${i + 1}`, valueId: skill });
    });
  }

  const prog = idx.progByClass.get(classSlug);
  const masteryCount = prog?.weaponMastery ?? 0;
  if (masteryCount > 0) {
    const curated = MASTERY_PICKS[classSlug];
    const pool =
      curated?.filter((slug) => idx.masteryWeapons.includes(slug)) ??
      idx.masteryWeapons;
    const weapons = pickN(pool.length ? pool : idx.masteryWeapons, masteryCount);
    weapons.forEach((weapon, i) => {
      options.push({ optionKey: `masteryWeapon${i + 1}`, valueId: weapon });
    });
  }

  if (classSlug === 'wizard') {
    const prepared = characterSpells
      .filter((s) => s.listType === 'prepared' || s.listType === 'always_prepared')
      .map((s) => s.spellSlug);
    const byLevel = new Map();
    for (const row of idx.spellsByClass.get('wizard') ?? []) {
      byLevel.set(row.spellSlug, row.spellLevel);
    }
    const preparedL1 = prepared.filter((slug) => byLevel.get(slug) === 1);
    const preparedL2 = prepared.filter((slug) => byLevel.get(slug) === 2);
    const mastery1 = preparedL1[0] ?? prepared[0];
    const mastery2 =
      preparedL2.find((slug) => slug !== mastery1) ??
      prepared.find((slug) => slug !== mastery1) ??
      mastery1;
    if (mastery1) {
      options.push({ optionKey: 'spellMastery1', valueId: mastery1 });
    }
    if (mastery2) {
      options.push({ optionKey: 'spellMastery2', valueId: mastery2 });
    }
  }

  if (classSlug === 'warlock') {
    const invocations = await loadAndPickEldritchInvocationOptions(client, LEVEL);
    options.push(...invocations);
  }

  if (classSlug === 'sorcerer') {
    options.push(...(await loadAndPickMetamagicOptions(client, LEVEL)));
  }

  return options;
}

/** L2: 2 · L10: 4 · L17: 6 */
function sorcererMetamagicLimit(level) {
  if (level >= 17) return 6;
  if (level >= 10) return 4;
  if (level >= 2) return 2;
  return 0;
}

async function loadAndPickMetamagicOptions(client, level) {
  const limit = sorcererMetamagicLimit(level);
  if (limit <= 0) return [];
  const { rows } = await client.query(
    `SELECT slug FROM rpg.phb_metamagic ORDER BY sort_order, slug`,
  );
  const picks = pickN(
    rows.map((row) => row.slug),
    limit,
  );
  return picks.map((slug, instanceIndex) => ({
    optionKey: 'metamagic',
    valueId: slug,
    instanceIndex,
  }));
}

function asiSlotCount(classSlug) {
  const extras = EXTRA_ASI[classSlug] ?? [];
  return [...BASE_ASI, ...extras].filter((l) => l <= LEVEL).length;
}

function buildFeats(idx, classSlug, background) {
  const characterFeats = [];
  const featOptions = [];
  let asiIndex = 0;

  if (background?.originFeatSlug) {
    characterFeats.push({ featSlug: background.originFeatSlug, instanceIndex: 0 });
    featOptions.push(...pickFeatOptions(idx, background.originFeatSlug, 0));
  }

  if (classSlug === 'fighter' || classSlug === 'gunslinger') {
    const fs = pickRandom(idx.fightingStyleFeats.length ? idx.fightingStyleFeats : ['defense']);
    characterFeats.push({ featSlug: fs, instanceIndex: 0 });
    featOptions.push(...pickFeatOptions(idx, fs, 0));
  }

  const primary = PRIMARY_ABILITY[classSlug] ?? 'forca';
  const slots = asiSlotCount(classSlug);
  for (let i = 0; i < slots; i += 1) {
    characterFeats.push({
      featSlug: 'ability-score-improvement',
      instanceIndex: asiIndex,
    });
    featOptions.push(
      {
        featSlug: 'ability-score-improvement',
        instanceIndex: asiIndex,
        optionKey: 'distributionMode',
        valueId: 'plus2',
      },
      {
        featSlug: 'ability-score-improvement',
        instanceIndex: asiIndex,
        optionKey: 'primaryAbility',
        valueId: primary,
      },
    );
    asiIndex += 1;
  }

  return { characterFeats, featOptions };
}

function pickFeatOptions(idx, featSlug, instanceIndex) {
  const defs = idx.featDefsBySlug.get(featSlug) ?? [];
  const out = [];
  for (const def of defs) {
    // ASI secondaryAbility só com plus1plus1 — pulamos se não for ASI handled acima
    if (featSlug === 'ability-score-improvement') continue;
    // Magic initiate / ritual caster / spell options são complexos — pular value_type spell
    if (def.valueType === 'spell') continue;

    const values = idx.featValuesByKey.get(`${featSlug}::${def.optionKey}`) ?? [];
    if (!values.length) continue;
    out.push({
      featSlug,
      instanceIndex,
      optionKey: def.optionKey,
      valueId: pickRandom(values),
    });
  }
  return out;
}

function pickLanguages(idx, background) {
  const fixed = idx.bgLangs.get(background.slug) ?? [];
  const choiceCount = background.languageChoiceCount ?? 0;
  const chosen = pickN(
    idx.allLanguages.filter((l) => !fixed.includes(l) && l !== 'common'),
    choiceCount,
  );
  const set = new Set(['common', ...fixed, ...chosen]);
  // dwarf soldier style fallback: ensure at least 2 extras if empty
  if (set.size < 2) set.add(pickRandom(idx.allLanguages.filter((l) => l !== 'common')));
  return [...set];
}

function pickTool(idx, background) {
  if (background.toolProficiencyKind !== 'choice') return undefined;
  const tools = idx.bgTools.get(background.slug) ?? [];
  if (!tools.length) return undefined;
  return pickRandom(tools);
}

function pickBoostAbility(idx, backgroundSlug, classSlug) {
  const allowed = idx.bgAbilities.get(backgroundSlug) ?? [];
  const primary = PRIMARY_ABILITY[classSlug] ?? 'forca';
  if (allowed.length >= 2) {
    const plus2 = allowed.includes(primary) ? primary : allowed[0];
    const plus1 = allowed.find((a) => a !== plus2) ?? allowed[0];
    return { plus2, plus1 };
  }
  if (allowed.length === 1) {
    return { plus2: allowed[0], plus1: allowed[0] };
  }
  // fallback soldier-like
  const fallbackPrimary = ['forca', 'destreza', 'constituicao'].includes(primary)
    ? primary
    : 'constituicao';
  return {
    plus2: fallbackPrimary,
    plus1: fallbackPrimary === 'constituicao' ? 'forca' : 'constituicao',
  };
}

function buildSpells(idx, classSlug) {
  const list = idx.spellsByClass.get(classSlug) ?? [];
  if (!list.length) return [];

  const prog = idx.progByClass.get(classSlug) ?? {};
  const cantripMax = prog.cantrips ?? 0;
  const preparedMax = prog.preparedSpells ?? null;
  // Cotas de known casters também usam a coluna prepared_spells no seed PHB.
  const knownMax = prog.preparedSpells ?? null;

  const cantrips = shuffle(list.filter((s) => s.spellLevel === 0)).map((s) => s.spellSlug);
  const leveled = shuffle(list.filter((s) => s.spellLevel >= 1));

  const spells = [];
  const preferredCantrips =
    classSlug === 'warlock' ? ['raio-mistico'] : classSlug === 'wizard' ? ['raio-de-fogo'] : [];
  const pickCantrips = [
    ...preferredCantrips.filter((slug) => cantrips.includes(slug)),
    ...cantrips.filter((slug) => !preferredCantrips.includes(slug)),
  ].slice(0, cantripMax);
  for (const slug of pickCantrips) {
    spells.push({ spellSlug: slug, listType: 'known' });
  }

  if (classSlug === 'wizard') {
    const bookMax = wizardSpellbookLimitAtLevel(LEVEL, preparedMax);
    const preparedQuota = preparedMax ?? 0;
    const book = leveled.slice(0, bookMax);
    const prepared = book.slice(0, preparedQuota);
    const preparedSlugs = new Set(prepared.map((s) => s.spellSlug));
    // prepared conta no grimório — não duplicar como known+prepared (senão estoura a cota).
    for (const s of book) {
      if (preparedSlugs.has(s.spellSlug)) {
        spells.push({ spellSlug: s.spellSlug, listType: 'prepared' });
      } else {
        spells.push({ spellSlug: s.spellSlug, listType: 'known' });
      }
    }
    return spells;
  }

  if (PREPARED.has(classSlug)) {
    const prepared = leveled.slice(0, preparedMax ?? 0);
    for (const s of prepared) {
      spells.push({ spellSlug: s.spellSlug, listType: 'prepared' });
    }
    return spells;
  }

  // known casters (bard, ranger, sorcerer, warlock, …)
  const maxCircle = classSlug === 'warlock' ? 5 : 9;
  const knownPool = leveled.filter((s) => s.spellLevel <= maxCircle);
  const known = knownPool.slice(0, knownMax ?? preparedMax ?? 0);
  for (const s of known) {
    spells.push({ spellSlug: s.spellSlug, listType: 'known' });
  }
  return spells;
}

function wizardSpellbookLimitAtLevel(level, preparedQuota) {
  if (preparedQuota == null) return 6;
  if (level === 1) return Math.max(preparedQuota + 2, 6);
  return preparedQuota + level;
}

function buildEquipment(idx, classSlug, backgroundSlug) {
  const equipment = [];
  const classRows = idx.classEquip.get(classSlug) ?? [];
  const bgRows = idx.bgEquip.get(backgroundSlug) ?? [];

  const classPackages = [...new Set(classRows.map((r) => r.packageSlug))];
  const bgPackages = [...new Set(bgRows.map((r) => r.packageSlug))];

  if (classPackages.length) {
    const pkg = pickRandom(classPackages);
    let sort = 0;
    for (const row of classRows.filter((r) => r.packageSlug === pkg)) {
      if (!row.itemSlug && row.choiceText) {
        equipment.push({
          source: 'class',
          packageSlug: pkg,
          sortOrder: sort++,
        });
        continue;
      }
      if (!row.itemSlug && row.goldAmount != null) {
        equipment.push({
          source: 'class',
          packageSlug: pkg,
          sortOrder: sort++,
        });
        continue;
      }
      if (row.itemSlug) {
        equipment.push({
          source: 'class',
          packageSlug: pkg,
          itemSlug: row.itemSlug,
          quantity: row.quantity ?? 1,
          sortOrder: sort++,
        });
      }
    }
  }

  if (bgPackages.length) {
    const pkg = pickRandom(bgPackages);
    let sort = 0;
    for (const row of bgRows.filter((r) => r.packageSlug === pkg)) {
      if (row.itemSlug) {
        equipment.push({
          source: 'background',
          packageSlug: pkg,
          itemSlug: row.itemSlug,
          quantity: row.quantity ?? 1,
          sortOrder: sort++,
        });
      } else {
        equipment.push({
          source: 'background',
          packageSlug: pkg,
          sortOrder: sort++,
        });
      }
    }
  }

  return equipment;
}
