#!/usr/bin/env node
/**
 * Smoke — magias concedidas por talentos (fora da lista da classe).
 *
 * Cria fichas com Magic Initiate / Fey Touched / Shadow Touched / Ritual Caster
 * em classes sem essas magias na lista, e confere characterSpells + source.
 *
 * Uso:
 *   node scripts/smoke-granted-spells.mjs
 *   KEEP=1 node scripts/smoke-granted-spells.mjs
 */
import { createRequire } from 'module';
import path from 'path';
import { loadEnv, rootDir } from './lib/load-env.mjs';

loadEnv();

const require = createRequire(import.meta.url);
const { NestFactory } = require('@nestjs/core');
const { DataSource } = require('typeorm');
const { AppModule } = require(path.join(rootDir, 'dist/app.module.js'));
const { CreateCharacterHandler } = require(
  path.join(rootDir, 'dist/game/sheet/application/create-character.handler.js'),
);
const { UpdateCharacterHandler } = require(
  path.join(rootDir, 'dist/game/sheet/application/update-character.handler.js'),
);
const { DeleteCharacterHandler } = require(
  path.join(rootDir, 'dist/game/sheet/application/delete-character.handler.js'),
);
const { GetCharacterQuery } = require(
  path.join(rootDir, 'dist/game/sheet/application/get-character.query.js'),
);

const USER_ID = process.env.SMOKE_USER_ID ?? '22222222-2222-2222-2222-222222222222';
const KEEP = process.env.KEEP === '1';

const SCORES = {
  forca: 15,
  destreza: 13,
  constituicao: 14,
  inteligencia: 12,
  sabedoria: 10,
  carisma: 8,
};

const SCENARIOS = [
  {
    id: 'talento/iniciado-mago-em-guerreiro',
    source: 'talento',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    speciesSlug: 'orc',
    speciesChoices: [],
    languageSlugs: ['common', 'orc'],
    level: 4,
    feats: [{ featSlug: 'magic-initiate', instanceIndex: 0 }],
    featOptions: [
      {
        featSlug: 'magic-initiate',
        instanceIndex: 0,
        optionKey: 'spellList',
        valueId: 'wizard',
      },
      {
        featSlug: 'magic-initiate',
        instanceIndex: 0,
        optionKey: 'castingAbility',
        valueId: 'inteligencia',
      },
      {
        featSlug: 'magic-initiate',
        instanceIndex: 0,
        optionKey: 'cantrip1',
        valueId: 'raio-de-fogo',
      },
      {
        featSlug: 'magic-initiate',
        instanceIndex: 0,
        optionKey: 'cantrip2',
        valueId: 'prestidigitacao-arcana',
      },
      {
        featSlug: 'magic-initiate',
        instanceIndex: 0,
        optionKey: 'firstLevelSpell',
        valueId: 'escudo-arcano',
      },
    ],
    rule: 'sync always_prepared + source=feat',
    expectSpells: [
      { spellSlug: 'raio-de-fogo', listType: 'always_prepared', source: 'feat' },
      {
        spellSlug: 'prestidigitacao-arcana',
        listType: 'always_prepared',
        source: 'feat',
      },
      { spellSlug: 'escudo-arcano', listType: 'always_prepared', source: 'feat' },
    ],
  },
  {
    id: 'talento/fey-touched-guerreiro',
    source: 'talento',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    speciesSlug: 'orc',
    speciesChoices: [],
    languageSlugs: ['common', 'orc'],
    level: 4,
    feats: [{ featSlug: 'fey-touched', instanceIndex: 0 }],
    featOptions: [
      {
        featSlug: 'fey-touched',
        instanceIndex: 0,
        optionKey: 'abilityIncrease',
        valueId: 'inteligencia',
      },
      {
        featSlug: 'fey-touched',
        instanceIndex: 0,
        optionKey: 'castingAbility',
        valueId: 'inteligencia',
      },
      {
        featSlug: 'fey-touched',
        instanceIndex: 0,
        optionKey: 'bonusSpell',
        valueId: 'detectar-magia',
      },
    ],
    rule: 'bonusSpell + passo-nebuloso fixo',
    expectSpells: [
      { spellSlug: 'detectar-magia', listType: 'always_prepared', source: 'feat' },
      { spellSlug: 'passo-nebuloso', listType: 'always_prepared', source: 'feat' },
    ],
  },
  {
    id: 'talento/shadow-touched-guerreiro',
    source: 'talento',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    speciesSlug: 'orc',
    speciesChoices: [],
    languageSlugs: ['common', 'orc'],
    level: 4,
    feats: [{ featSlug: 'shadow-touched', instanceIndex: 0 }],
    featOptions: [
      {
        featSlug: 'shadow-touched',
        instanceIndex: 0,
        optionKey: 'abilityIncrease',
        valueId: 'inteligencia',
      },
      {
        featSlug: 'shadow-touched',
        instanceIndex: 0,
        optionKey: 'castingAbility',
        valueId: 'inteligencia',
      },
      {
        featSlug: 'shadow-touched',
        instanceIndex: 0,
        optionKey: 'bonusSpell',
        valueId: 'infligir-ferimentos',
      },
    ],
    rule: 'bonusSpell + invisibilidade fixa',
    expectSpells: [
      {
        spellSlug: 'infligir-ferimentos',
        listType: 'always_prepared',
        source: 'feat',
      },
      { spellSlug: 'invisibilidade', listType: 'always_prepared', source: 'feat' },
    ],
  },
  {
    id: 'talento/ritual-caster-guerreiro',
    source: 'talento',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    speciesSlug: 'orc',
    speciesChoices: [],
    languageSlugs: ['common', 'orc'],
    level: 4,
    feats: [{ featSlug: 'ritual-caster', instanceIndex: 0 }],
    featOptions: [
      {
        featSlug: 'ritual-caster',
        instanceIndex: 0,
        optionKey: 'abilityIncrease',
        valueId: 'inteligencia',
      },
      {
        featSlug: 'ritual-caster',
        instanceIndex: 0,
        optionKey: 'ritualSpell1',
        valueId: 'alarme',
      },
      {
        featSlug: 'ritual-caster',
        instanceIndex: 0,
        optionKey: 'ritualSpell2',
        valueId: 'detectar-magia',
      },
    ],
    rule: 'PB=2 → 2 rituais always_prepared',
    expectSpells: [
      { spellSlug: 'alarme', listType: 'always_prepared', source: 'feat' },
      { spellSlug: 'detectar-magia', listType: 'always_prepared', source: 'feat' },
    ],
  },
  {
    id: 'especie/aasimar-luz',
    source: 'especie',
    classSlug: 'fighter',
    subclassSlug: null,
    speciesSlug: 'aasimar',
    speciesChoices: [{ choiceKind: 'aasimar_size', choiceSlug: 'medium' }],
    languageSlugs: ['common', 'celestial'],
    level: 1,
    rule: 'Portador da Luz → luz',
    expectSpells: [
      { spellSlug: 'luz', listType: 'always_prepared', source: 'species' },
    ],
  },
  {
    id: 'especie/tiefling-infernal-nv1',
    source: 'especie',
    classSlug: 'fighter',
    subclassSlug: null,
    speciesSlug: 'tiefling',
    speciesChoices: [
      { choiceKind: 'infernal_legacy', choiceSlug: 'infernal' },
      { choiceKind: 'infernal_casting_ability', choiceSlug: 'carisma' },
      { choiceKind: 'tiefling_size', choiceSlug: 'medium' },
    ],
    languageSlugs: ['common', 'infernal'],
    level: 1,
    rule: 'taumaturgia + raio-de-fogo',
    expectSpells: [
      { spellSlug: 'taumaturgia', listType: 'always_prepared', source: 'species' },
      { spellSlug: 'raio-de-fogo', listType: 'always_prepared', source: 'species' },
    ],
  },
  {
    id: 'especie/elf-drow-nv5',
    source: 'especie',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    speciesSlug: 'elf',
    speciesChoices: [
      { choiceKind: 'elf_lineage', choiceSlug: 'drow' },
      { choiceKind: 'elf_keen_senses', choiceSlug: 'perception' },
      { choiceKind: 'elf_casting_ability', choiceSlug: 'carisma' },
    ],
    languageSlugs: ['common', 'elvish'],
    level: 5,
    rule: 'drow L1+L3+L5',
    expectSpells: [
      {
        spellSlug: 'luzes-dancantes',
        listType: 'always_prepared',
        source: 'species',
      },
      {
        spellSlug: 'fogo-das-fadas',
        listType: 'always_prepared',
        source: 'species',
      },
      { spellSlug: 'escuridao', listType: 'always_prepared', source: 'species' },
    ],
  },
  {
    id: 'especie/gnome-forest',
    source: 'especie',
    classSlug: 'fighter',
    subclassSlug: null,
    speciesSlug: 'gnome',
    speciesChoices: [
      { choiceKind: 'gnome_lineage', choiceSlug: 'forest-gnome' },
      { choiceKind: 'gnome_casting_ability', choiceSlug: 'inteligencia' },
    ],
    languageSlugs: ['common', 'gnomish'],
    level: 1,
    rule: 'ilusao-menor + falar-com-animais',
    expectSpells: [
      { spellSlug: 'ilusao-menor', listType: 'always_prepared', source: 'species' },
      {
        spellSlug: 'falar-com-animais',
        listType: 'always_prepared',
        source: 'species',
      },
    ],
  },
];

async function resolveSubclassOptions(dataSource, subclassSlug, level) {
  if (!subclassSlug) return undefined;
  const rows = await dataSource.query(
    `SELECT DISTINCT ON (d.option_key) d.option_key AS "optionKey", v.value_id AS "valueId"
     FROM rpg.phb_subclass_option_def d
     JOIN rpg.phb_subclass s ON s.id = d.subclass_id
     JOIN rpg.phb_subclass_option_value v
       ON v.subclass_id = d.subclass_id AND v.option_key = d.option_key
     WHERE s.slug = $1 AND d.unlock_level <= $2
     ORDER BY d.option_key,
       CASE WHEN v.value_id = 'defense' THEN 0 ELSE 1 END,
       v.value_id`,
    [subclassSlug, level],
  );
  return rows;
}

async function buildPayload(dataSource, scenario) {
  return {
    name: `SMOKE SPELL ${scenario.id}`.slice(0, 100),
    level: scenario.level,
    classSlug: scenario.classSlug,
    subclassSlug: scenario.subclassSlug ?? undefined,
    speciesSlug: scenario.speciesSlug ?? 'orc',
    backgroundSlug: 'criminal',
    backgroundAbilityBoostPlus2Slug: 'destreza',
    backgroundAbilityBoostPlus1Slug: 'constituicao',
    abilityGenerationMethodSlug: 'standard-array',
    abilityScores: SCORES,
    classSkillSlugs: ['acrobatics', 'athletics'],
    languageSlugs: scenario.languageSlugs ?? ['common', 'orc'],
    speciesChoices: scenario.speciesChoices ?? [],
    subclassOptions: await resolveSubclassOptions(
      dataSource,
      scenario.subclassSlug,
      scenario.level,
    ),
    characterFeats: [
      { featSlug: 'alert', instanceIndex: 0 },
      ...(scenario.feats ?? []),
    ],
    featOptions: scenario.featOptions ?? [],
    characterSpells: [],
    equipment: [],
  };
}

function hasExpectedSpell(spells, expected) {
  return spells.some(
    (spell) =>
      spell.spellSlug === expected.spellSlug &&
      spell.listType === expected.listType &&
      spell.source === expected.source,
  );
}

async function runCreateScenario(handlers, dataSource, scenario) {
  const created = await handlers.create.execute(
    USER_ID,
    await buildPayload(dataSource, scenario),
  );
  const detail = await handlers.get.execute(USER_ID, created.id);
  const missing = scenario.expectSpells.filter(
    (expected) => !hasExpectedSpell(detail.characterSpells, expected),
  );
  return {
    characterId: created.id,
    ok: missing.length === 0,
    actual: detail.characterSpells,
    missing,
  };
}

async function runUpdateSwapCheck(handlers, dataSource) {
  const base = SCENARIOS[0];
  const created = await handlers.create.execute(
    USER_ID,
    await buildPayload(dataSource, base),
  );

  const nextOptions = base.featOptions.map((option) =>
    option.optionKey === 'cantrip1'
      ? { ...option, valueId: 'luz' }
      : option,
  );

  await handlers.update.execute(USER_ID, created.id, {
    featOptions: nextOptions,
    characterFeats: [
      { featSlug: 'alert', instanceIndex: 0 },
      { featSlug: 'magic-initiate', instanceIndex: 0 },
    ],
  });

  const detail = await handlers.get.execute(USER_ID, created.id);
  const hasLuz = hasExpectedSpell(detail.characterSpells, {
    spellSlug: 'luz',
    listType: 'always_prepared',
    source: 'feat',
  });
  const stillHasOld = detail.characterSpells.some(
    (spell) => spell.spellSlug === 'raio-de-fogo',
  );

  return {
    characterId: created.id,
    ok: hasLuz && !stillHasOld,
    actual: detail.characterSpells,
  };
}

async function runElfLevelUpCheck(handlers, dataSource) {
  const scenario = {
    id: 'especie/elf-drow-level-up',
    classSlug: 'fighter',
    subclassSlug: null,
    speciesSlug: 'elf',
    speciesChoices: [
      { choiceKind: 'elf_lineage', choiceSlug: 'drow' },
      { choiceKind: 'elf_keen_senses', choiceSlug: 'perception' },
      { choiceKind: 'elf_casting_ability', choiceSlug: 'carisma' },
    ],
    languageSlugs: ['common', 'elvish'],
    level: 2,
  };

  const created = await handlers.create.execute(
    USER_ID,
    await buildPayload(dataSource, scenario),
  );
  const before = await handlers.get.execute(USER_ID, created.id);
  const hasL1 = hasExpectedSpell(before.characterSpells, {
    spellSlug: 'luzes-dancantes',
    listType: 'always_prepared',
    source: 'species',
  });
  const hasL3Before = before.characterSpells.some(
    (spell) => spell.spellSlug === 'fogo-das-fadas',
  );

  const subclassOptions = await resolveSubclassOptions(
    dataSource,
    'champion',
    3,
  );
  await handlers.update.execute(USER_ID, created.id, {
    level: 3,
    subclassSlug: 'champion',
    subclassOptions,
  });
  const after = await handlers.get.execute(USER_ID, created.id);
  const hasL3 = hasExpectedSpell(after.characterSpells, {
    spellSlug: 'fogo-das-fadas',
    listType: 'always_prepared',
    source: 'species',
  });

  return {
    characterId: created.id,
    ok: hasL1 && !hasL3Before && hasL3,
    actual: after.characterSpells,
  };
}

async function main() {
  const app = await NestFactory.createApplicationContext(AppModule, {
    logger: ['error', 'warn'],
  });

  const handlers = {
    create: app.get(CreateCharacterHandler),
    update: app.get(UpdateCharacterHandler),
    del: app.get(DeleteCharacterHandler),
    get: app.get(GetCharacterQuery),
  };
  const dataSource = app.get(DataSource);

  console.log('=== Magias concedidas por talento ===');
  const createdIds = [];
  const results = [];

  for (const scenario of SCENARIOS) {
    try {
      const outcome = await runCreateScenario(handlers, dataSource, scenario);
      createdIds.push(outcome.characterId);
      const missingText = outcome.missing?.length
        ? ` faltando=${outcome.missing.map((s) => s.spellSlug).join(',')}`
        : '';
      console.log(
        `${outcome.ok ? 'OK  ' : 'FAIL'} [${scenario.source}] ${scenario.id}: ${scenario.rule}${missingText}`,
      );
      results.push({ id: scenario.id, source: scenario.source, ...outcome });
    } catch (error) {
      const msg = error?.response?.message ?? error?.message ?? String(error);
      const text = Array.isArray(msg) ? msg.join('; ') : msg;
      console.log(`ERRO [${scenario.source}] ${scenario.id}: ${text}`);
      results.push({ id: scenario.id, source: scenario.source, ok: false, error: text });
    }
  }

  try {
    const outcome = await runUpdateSwapCheck(handlers, dataSource);
    createdIds.push(outcome.characterId);
    console.log(
      `${outcome.ok ? 'OK  ' : 'FAIL'} [talento] update/troca-cantrip-iniciado: remove antigo + adiciona novo`,
    );
    results.push({ id: 'update/troca-cantrip-iniciado', source: 'talento', ...outcome });
  } catch (error) {
    const msg = error?.response?.message ?? error?.message ?? String(error);
    const text = Array.isArray(msg) ? msg.join('; ') : msg;
    console.log(`ERRO [talento] update/troca-cantrip-iniciado: ${text}`);
    results.push({
      id: 'update/troca-cantrip-iniciado',
      source: 'talento',
      ok: false,
      error: text,
    });
  }

  try {
    const outcome = await runElfLevelUpCheck(handlers, dataSource);
    createdIds.push(outcome.characterId);
    console.log(
      `${outcome.ok ? 'OK  ' : 'FAIL'} [especie] update/elf-drow-nv2-para-nv3: destrava fogo-das-fadas`,
    );
    results.push({
      id: 'update/elf-drow-nv2-para-nv3',
      source: 'especie',
      ...outcome,
    });
  } catch (error) {
    const msg = error?.response?.message ?? error?.message ?? String(error);
    const text = Array.isArray(msg) ? msg.join('; ') : msg;
    console.log(`ERRO [especie] update/elf-drow-nv2-para-nv3: ${text}`);
    results.push({
      id: 'update/elf-drow-nv2-para-nv3',
      source: 'especie',
      ok: false,
      error: text,
    });
  }

  if (!KEEP) {
    for (const id of createdIds) {
      try {
        await handlers.del.execute(USER_ID, id);
      } catch {
        // ignore
      }
    }
  }

  const okCount = results.filter((r) => r.ok).length;
  console.log(`\n${okCount}/${results.length} OK`);
  await app.close();
  process.exit(okCount === results.length ? 0 : 1);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
