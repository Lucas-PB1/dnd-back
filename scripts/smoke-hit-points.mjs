#!/usr/bin/env node
/**
 * Smoke dos Pontos de Vida (PV) máximos.
 *
 * Parte 1: lista as fontes permanentes de PV no catálogo (espécie, subclasse,
 *          talento) para saber o que a ficha deveria considerar.
 * Parte 2: cria fichas reais e compara o PV máximo devolvido pela API com o
 *          valor esperado pelas regras (base da classe + CON + bônus fixos).
 *
 * Uso:
 *   node scripts/smoke-hit-points.mjs
 *   KEEP=1 node scripts/smoke-hit-points.mjs   # não apaga as fichas
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
const { LevelUpPreviewQuery } = require(
  path.join(rootDir, 'dist/game/progression/application/level-up-preview.query.js'),
);

const USER_ID = process.env.SMOKE_USER_ID ?? '22222222-2222-2222-2222-222222222222';
const KEEP = process.env.KEEP === '1';

const mod = (score) => Math.floor((score - 10) / 2);

/** Perícias fora do pool do criminal (stealth, sleight-of-hand). */
const CLASS_SKILLS = {
  fighter: ['acrobatics', 'athletics'],
  barbarian: ['athletics', 'intimidation'],
  sorcerer: ['arcana', 'deception'],
};

const SCORES = {
  forca: 15,
  destreza: 13,
  constituicao: 14,
  inteligencia: 12,
  sabedoria: 10,
  carisma: 8,
};

/** Base da classe: nível 1 = dado + CON; demais níveis = fixo + CON (mínimo 1). */
function classBaseHp(profile, level, constitution) {
  const conMod = mod(constitution);
  const level1 = profile.dieValue + conMod;
  if (level <= 1) return level1;
  return level1 + (level - 1) * Math.max(1, profile.fixedPerLevel + conMod);
}

const SCENARIOS = [
  {
    id: 'base/guerreiro-nv1-sem-fontes',
    source: 'base',
    classSlug: 'fighter',
    speciesSlug: 'orc',
    level: 1,
    rule: 'dado de vida + CON',
    bonus: () => 0,
  },
  {
    id: 'base/guerreiro-nv5-sem-fontes',
    source: 'base',
    classSlug: 'fighter',
    speciesSlug: 'orc',
    subclassSlug: 'champion',
    level: 5,
    rule: 'dado + CON + 4x(fixo + CON)',
    bonus: () => 0,
  },
  {
    id: 'especie/anao-tenacidade-nv1',
    source: 'especie',
    classSlug: 'fighter',
    speciesSlug: 'dwarf',
    level: 1,
    rule: 'base + 1 por nível (Tenacidade Anã)',
    bonus: (level) => level,
  },
  {
    id: 'especie/anao-tenacidade-nv5',
    source: 'especie',
    classSlug: 'fighter',
    speciesSlug: 'dwarf',
    subclassSlug: 'champion',
    level: 5,
    rule: 'base + 1 por nível (Tenacidade Anã)',
    bonus: (level) => level,
  },
  {
    id: 'subclasse/feiticeiro-nao-draconico-nv3',
    source: 'subclasse',
    classSlug: 'sorcerer',
    speciesSlug: 'orc',
    subclassSlug: 'wild-magic',
    level: 3,
    rule: 'controle: subclasse sem bônus de PV',
    bonus: () => 0,
  },
  {
    id: 'subclasse/draconico-nv3',
    source: 'subclasse',
    classSlug: 'sorcerer',
    speciesSlug: 'orc',
    subclassSlug: 'draconic',
    level: 3,
    rule: 'base + 3 (Resiliência Dracônica)',
    bonus: (level) => level,
  },
  {
    id: 'subclasse/draconico-nv5',
    source: 'subclasse',
    classSlug: 'sorcerer',
    speciesSlug: 'orc',
    subclassSlug: 'draconic',
    level: 5,
    rule: 'base + 3 no nv.3 e +1 por nível depois',
    bonus: (level) => level,
  },
  {
    id: 'talento/resistente-nv1',
    source: 'talento',
    classSlug: 'fighter',
    speciesSlug: 'orc',
    level: 1,
    feats: [{ featSlug: 'tough', instanceIndex: 0 }],
    rule: 'base + 2 por nível (Vigoroso)',
    bonus: (level) => 2 * level,
  },
  {
    id: 'talento/resistente-nv5',
    source: 'talento',
    classSlug: 'fighter',
    speciesSlug: 'orc',
    subclassSlug: 'champion',
    level: 5,
    feats: [{ featSlug: 'tough', instanceIndex: 0 }],
    rule: 'base + 2 por nível (Vigoroso)',
    bonus: (level) => 2 * level,
  },
  {
    id: 'talento/dadiva-fortitude-nv19',
    source: 'talento',
    classSlug: 'fighter',
    speciesSlug: 'orc',
    subclassSlug: 'champion',
    level: 19,
    feats: [{ featSlug: 'boon-of-fortitude', instanceIndex: 0 }],
    featOptions: [
      {
        featSlug: 'boon-of-fortitude',
        instanceIndex: 0,
        optionKey: 'abilityIncrease',
        valueId: 'constituicao',
      },
    ],
    rule: 'base + 40 (Dádiva da Fortitude)',
    bonus: () => 40,
  },
  {
    id: 'combo/anao-draconico-resistente-nv5',
    source: 'combo',
    classSlug: 'sorcerer',
    speciesSlug: 'dwarf',
    subclassSlug: 'draconic',
    level: 5,
    feats: [{ featSlug: 'tough', instanceIndex: 0 }],
    rule: 'base + anão + dracônico + vigoroso',
    bonus: (level) => level + level + 2 * level,
  },
];

/** Escolhas obrigatórias da subclasse até o nível pedido (uma opção por chave). */
async function resolveSubclassOptions(dataSource, subclassSlug, level) {
  if (!subclassSlug) return undefined;
  const rows = await dataSource.query(
    `SELECT DISTINCT ON (d.option_key) d.option_key AS "optionKey", v.value_id AS "valueId"
     FROM rpg.phb_subclass_option_def d
     JOIN rpg.phb_subclass s ON s.id = d.subclass_id
     JOIN rpg.phb_subclass_option_value v
       ON v.subclass_id = d.subclass_id AND v.option_key = d.option_key
     WHERE s.slug = $1 AND d.unlock_level <= $2
     ORDER BY d.option_key, v.value_id`,
    [subclassSlug, level],
  );
  return rows;
}

async function buildPayload(dataSource, scenario) {
  return {
    name: `SMOKE PV ${scenario.id}`.slice(0, 100),
    level: scenario.level,
    classSlug: scenario.classSlug,
    subclassSlug: scenario.subclassSlug,
    speciesSlug: scenario.speciesSlug,
    backgroundSlug: 'criminal',
    backgroundAbilityBoostPlus2Slug: 'destreza',
    backgroundAbilityBoostPlus1Slug: 'constituicao',
    abilityGenerationMethodSlug: 'standard-array',
    abilityScores: SCORES,
    classSkillSlugs: CLASS_SKILLS[scenario.classSlug],
    languageSlugs: ['common', 'dwarvish'],
    speciesChoices: [],
    subclassOptions: await resolveSubclassOptions(
      dataSource,
      scenario.subclassSlug,
      scenario.level,
    ),
    characterFeats: scenario.feats ?? [],
    featOptions: scenario.featOptions ?? [],
    characterSpells: [],
    equipment: [],
  };
}

async function loadClassProfiles(dataSource) {
  const rows = await dataSource.query(
    `SELECT class_slug, hit_die, hp_level1_die_value, hp_fixed_per_level
     FROM rpg.v_phb_class`,
  );
  const profiles = new Map();
  for (const row of rows) {
    const dieValue =
      row.hp_level1_die_value ?? Number.parseInt(/d(\d+)/i.exec(row.hit_die)[1], 10);
    profiles.set(row.class_slug, {
      dieValue,
      fixedPerLevel: row.hp_fixed_per_level ?? Math.ceil(dieValue / 2) + 1,
    });
  }
  return profiles;
}

async function listCatalogHpSources(dataSource) {
  const pattern = '(Pontos de Vida m[áa]ximos|m[áa]ximo de Pontos de Vida)';
  const [speciesTraits, subclassFeatures, feats] = await Promise.all([
    dataSource.query(
      `SELECT sp.slug AS owner, t.name
       FROM rpg.phb_species_trait t
       JOIN rpg.phb_species sp ON sp.id = t.species_id
       WHERE t.description ~* $1 ORDER BY sp.slug`,
      [pattern],
    ),
    dataSource.query(
      `SELECT s.slug AS owner, f.name, f.level
       FROM rpg.phb_subclass_feature f
       JOIN rpg.phb_subclass s ON s.id = f.subclass_id
       WHERE f.description ~* $1 ORDER BY s.slug`,
      [pattern],
    ),
    dataSource.query(
      `SELECT DISTINCT f.slug AS owner
       FROM rpg.phb_feat_benefit b
       JOIN rpg.phb_feat f ON f.id = b.feat_id
       WHERE b.description ~* $1 ORDER BY f.slug`,
      [pattern],
    ),
  ]);
  return { speciesTraits, subclassFeatures, feats };
}

function describe(list, format) {
  return list.length ? ` → ${list.map(format).join('; ')}` : '';
}

async function runScenario(handlers, dataSource, profiles, scenario) {
  const created = await handlers.create.execute(
    USER_ID,
    await buildPayload(dataSource, scenario),
  );
  const detail = await handlers.get.execute(USER_ID, created.id);

  const base = classBaseHp(
    profiles.get(scenario.classSlug),
    scenario.level,
    detail.abilityScores.constituicao,
  );
  const expected = base + scenario.bonus(scenario.level);

  return {
    characterId: created.id,
    expected,
    actual: detail.hitPointsMax,
    current: detail.hitPointsCurrent,
    ok: detail.hitPointsMax === expected,
  };
}

const FEAT_UPDATE_SCENARIO = {
  id: 'atualizacao/adicionar-vigoroso',
  source: 'atualizacao',
  classSlug: 'fighter',
  speciesSlug: 'orc',
  subclassSlug: 'champion',
  level: 4,
  rule: 'PATCH adicionando Vigoroso soma +2 por nível',
};

const LEVEL_UP_PREVIEW_SCENARIO = {
  id: 'levelup/preview-anao-vigoroso',
  source: 'levelup',
  classSlug: 'fighter',
  speciesSlug: 'dwarf',
  subclassSlug: 'champion',
  level: 4,
  feats: [{ featSlug: 'tough', instanceIndex: 0 }],
  rule: 'ganho por nível = fixo + CON + 1 (anão) + 2 (vigoroso)',
};

/** Adicionar o talento depois da criação precisa recalcular o PV máximo. */
async function runFeatUpdateCheck(handlers, dataSource, profiles) {
  const scenario = FEAT_UPDATE_SCENARIO;
  const created = await handlers.create.execute(
    USER_ID,
    await buildPayload(dataSource, scenario),
  );
  const before = await handlers.get.execute(USER_ID, created.id);
  await handlers.update.execute(USER_ID, created.id, {
    characterFeats: [{ featSlug: 'tough', instanceIndex: 0 }],
  });
  const after = await handlers.get.execute(USER_ID, created.id);

  const base = classBaseHp(
    profiles.get(scenario.classSlug),
    scenario.level,
    after.abilityScores.constituicao,
  );
  const expected = base + 2 * scenario.level;

  return {
    characterId: created.id,
    expected,
    actual: after.hitPointsMax,
    ok: after.hitPointsMax === expected && before.hitPointsMax === base,
  };
}

/** O preview de subida de nível precisa somar os bônus por nível. */
async function runLevelUpPreviewCheck(handlers, dataSource, profiles) {
  const scenario = LEVEL_UP_PREVIEW_SCENARIO;
  const created = await handlers.create.execute(
    USER_ID,
    await buildPayload(dataSource, scenario),
  );
  const detail = await handlers.get.execute(USER_ID, created.id);
  const preview = await handlers.preview.execute(USER_ID, created.id);

  const profile = profiles.get(scenario.classSlug);
  const expected =
    Math.max(1, profile.fixedPerLevel + mod(detail.abilityScores.constituicao)) + 1 + 2;

  return {
    characterId: created.id,
    expected,
    actual: preview.estimatedHpGain,
    ok:
      preview.estimatedHpGain === expected &&
      preview.estimatedHitPointsMax === detail.hitPointsMax + expected,
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
    preview: app.get(LevelUpPreviewQuery),
  };
  const dataSource = app.get(DataSource);
  const profiles = await loadClassProfiles(dataSource);

  console.log('=== Fontes permanentes de PV no catálogo ===');
  const sources = await listCatalogHpSources(dataSource);
  console.log(
    `Traços de espécie: ${sources.speciesTraits.length}` +
      describe(sources.speciesTraits, (r) => `${r.owner}/${r.name}`),
  );
  console.log(
    `Características de subclasse: ${sources.subclassFeatures.length}` +
      describe(sources.subclassFeatures, (r) => `${r.owner}/${r.name} (nv.${r.level})`),
  );
  console.log(
    `Talentos: ${sources.feats.length}` + describe(sources.feats, (r) => r.owner),
  );

  console.log('\n=== Cenários de PV ===');
  const createdIds = [];
  const results = [];

  const checks = [
    ...SCENARIOS.map((scenario) => ({
      scenario,
      run: () => runScenario(handlers, dataSource, profiles, scenario),
    })),
    {
      scenario: FEAT_UPDATE_SCENARIO,
      run: () => runFeatUpdateCheck(handlers, dataSource, profiles),
    },
    {
      scenario: LEVEL_UP_PREVIEW_SCENARIO,
      run: () => runLevelUpPreviewCheck(handlers, dataSource, profiles),
    },
  ];

  for (const { scenario, run } of checks) {
    const { id, source, rule } = scenario;
    try {
      const outcome = await run();
      createdIds.push(outcome.characterId);
      console.log(
        `${outcome.ok ? 'OK  ' : 'FAIL'} [${source}] ${id}: PV=${outcome.actual} esperado=${outcome.expected} (${rule})`,
      );
      results.push({ id, source, rule, ...outcome });
    } catch (error) {
      const msg = error?.response?.message ?? error?.message ?? String(error);
      const text = Array.isArray(msg) ? msg.join('; ') : msg;
      console.log(`ERRO [${source}] ${id}: ${text}`);
      results.push({ id, source, rule, ok: false, error: text });
    }
  }

  if (!KEEP) {
    for (const id of createdIds) {
      try {
        await handlers.del.execute(USER_ID, id);
      } catch {
        // ignore
      }
    }
  } else {
    console.log(`\nKEEP=1 — ${createdIds.length} fichas preservadas`);
  }

  await app.close();

  const okCount = results.filter((r) => r.ok).length;
  console.log('\n=== Resumo ===');
  console.log(`Cenários: ${okCount}/${results.length} OK`);
  for (const source of [
    'base',
    'especie',
    'subclasse',
    'talento',
    'combo',
    'atualizacao',
    'levelup',
  ]) {
    const group = results.filter((r) => r.source === source);
    if (!group.length) continue;
    console.log(`  ${source}: ${group.filter((r) => r.ok).length}/${group.length}`);
  }

  const fails = results.filter((r) => !r.ok);
  if (fails.length) {
    console.log('\nFalhas:');
    for (const f of fails) {
      console.log(
        `  - [${f.source}] ${f.id}: ${f.error ?? `PV=${f.actual}, esperado ${f.expected} (${f.rule})`}`,
      );
    }
  }

  const fs = await import('fs');
  const reportPath = path.join(rootDir, 'scripts', 'smoke-hit-points-report.json');
  fs.writeFileSync(
    reportPath,
    JSON.stringify({ at: new Date().toISOString(), sources, results }, null, 2),
  );
  console.log(`\nRelatório: ${reportPath}`);

  if (fails.length > 0) process.exitCode = 1;
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
