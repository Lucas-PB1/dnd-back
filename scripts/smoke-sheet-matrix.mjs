#!/usr/bin/env node
/**
 * Smoke: cria 1 ficha por subclasse (nv.3) + testa PATCH de cada talento.
 *
 * Uso:
 *   node scripts/smoke-sheet-matrix.mjs
 *   KEEP=1 node scripts/smoke-sheet-matrix.mjs   # não apaga as fichas
 *
 * Roda via Nest ApplicationContext (sem JWT HTTP).
 */
import { createRequire } from 'module';
import path from 'path';
import { fileURLToPath } from 'url';
import { loadEnv, rootDir } from './lib/load-env.mjs';

loadEnv();

const require = createRequire(import.meta.url);
const { NestFactory } = require('@nestjs/core');
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

const API = process.env.SMOKE_API_URL ?? 'http://localhost:3000';
const USER_ID = process.env.SMOKE_USER_ID ?? '22222222-2222-2222-2222-222222222222';
const KEEP = process.env.KEEP === '1';
const FEATS_ONLY = process.env.FEATS_ONLY === '1';
const LEVEL = 3;

const SCORES = {
  forca: 15,
  destreza: 14,
  constituicao: 13,
  inteligencia: 12,
  sabedoria: 10,
  carisma: 8,
};

/** Skills genéricas fora do pool do criminal (stealth, sleight-of-hand). */
const ANY_SKILLS = [
  'athletics',
  'perception',
  'insight',
  'survival',
  'history',
  'persuasion',
  'arcana',
  'nature',
];

async function apiGet(pathname) {
  const res = await fetch(`${API}${pathname}`);
  const text = await res.text();
  let body;
  try {
    body = JSON.parse(text);
  } catch {
    body = { raw: text };
  }
  if (!res.ok) {
    const msg = body?.message ?? text;
    throw new Error(`GET ${pathname} → ${res.status}: ${msg}`);
  }
  return body;
}

async function fetchAllPages(pathname, limit = 100) {
  const first = await apiGet(`${pathname}${pathname.includes('?') ? '&' : '?'}page=1&limit=${limit}`);
  const totalPages = first.meta?.totalPages ?? 1;
  const rows = [...(first.data ?? [])];
  for (let page = 2; page <= totalPages; page += 1) {
    const next = await apiGet(
      `${pathname}${pathname.includes('?') ? '&' : '?'}page=${page}&limit=${limit}`,
    );
    rows.push(...(next.data ?? []));
  }
  return rows;
}

function pickSkills(poolSlugs, count, backgroundSkills) {
  const banned = new Set(backgroundSkills);
  const fromPool = poolSlugs.filter((s) => !banned.has(s));
  const source = fromPool.length >= count ? fromPool : ANY_SKILLS.filter((s) => !banned.has(s));
  if (source.length < count) {
    throw new Error(`Não há skills suficientes (precisa ${count})`);
  }
  return source.slice(0, count);
}

function pickSubclassOptions(optionDefs) {
  const used = new Set();
  const out = [];
  for (const def of optionDefs) {
    const values = def.values ?? [];
    const pick =
      values.find((v) => v.valueId && !used.has(`${def.optionKey}:${v.valueId}`)) ??
      values[0];
    if (!pick?.valueId) {
      throw new Error(`Opção '${def.optionKey}' sem valueId`);
    }
    used.add(`${def.optionKey}:${pick.valueId}`);
    // Battle Master exige manobras distintas
    if (def.optionKey.startsWith('maneuver')) {
      used.add(`maneuver:${pick.valueId}`);
    }
    out.push({ optionKey: def.optionKey, valueId: pick.valueId });
  }
  // Prefer distinct maneuvers
  if (optionDefs.some((d) => d.optionKey.startsWith('maneuver'))) {
    const maneuvers = optionDefs.filter((d) => d.optionKey.startsWith('maneuver'));
    const chosen = new Set();
    for (const def of maneuvers) {
      const pick = (def.values ?? []).find((v) => v.valueId && !chosen.has(v.valueId));
      if (!pick) throw new Error('Manobras insuficientes distintas');
      chosen.add(pick.valueId);
      const idx = out.findIndex((o) => o.optionKey === def.optionKey);
      out[idx] = { optionKey: def.optionKey, valueId: pick.valueId };
    }
  }
  return out;
}

function assertApplied(detail, expected) {
  const fails = [];
  if (detail.classSlug !== expected.classSlug) {
    fails.push(`classSlug=${detail.classSlug} (esperado ${expected.classSlug})`);
  }
  if (detail.subclassSlug !== expected.subclassSlug) {
    fails.push(`subclassSlug=${detail.subclassSlug} (esperado ${expected.subclassSlug})`);
  }
  if (detail.level !== LEVEL) {
    fails.push(`level=${detail.level}`);
  }
  if (detail.speciesSlug !== 'dwarf') fails.push(`species=${detail.speciesSlug}`);
  if (detail.backgroundSlug !== 'criminal') {
    fails.push(`background=${detail.backgroundSlug}`);
  }
  const featSlugs = (detail.characterFeats ?? []).map((f) => f.featSlug);
  if (!featSlugs.includes('alert')) {
    fails.push('origem alert ausente');
  }
  for (const skill of expected.classSkillSlugs) {
    if (!(detail.classSkillSlugs ?? []).includes(skill)) {
      fails.push(`skill ausente: ${skill}`);
    }
  }
  for (const opt of expected.subclassOptions ?? []) {
    const hit = (detail.subclassOptions ?? []).some(
      (o) => o.optionKey === opt.optionKey && o.valueId === opt.valueId,
    );
    if (!hit) fails.push(`subclassOption ausente: ${opt.optionKey}=${opt.valueId}`);
  }
  if (detail.proficiencyBonus == null) fails.push('proficiencyBonus null');
  if (detail.hitPointsMax == null || detail.hitPointsMax <= 0) {
    fails.push(`hitPointsMax=${detail.hitPointsMax}`);
  }
  return fails;
}

async function buildPayload(classRow, subclassSlug, bgSkills, level = LEVEL) {
  let pool = [];
  try {
    pool = (await fetchAllPages(`/classes/${classRow.slug}/skills`)).map((s) => s.slug);
  } catch {
    pool = [];
  }
  const count = classRow.skillChoiceCount ?? 0;
  const classSkillSlugs = count > 0 ? pickSkills(pool, count, bgSkills) : [];

  let subclassOptions = [];
  try {
    const defs = await fetchAllPages(
      `/subclasses/${subclassSlug}/options?level=${level}`,
    );
    if (defs.length > 0) subclassOptions = pickSubclassOptions(defs);
  } catch (error) {
    if (!String(error.message).includes('404')) throw error;
  }

  return {
    name: `SMOKE ${classRow.slug}/${subclassSlug}`.slice(0, 100),
    level,
    classSlug: classRow.slug,
    subclassSlug,
    speciesSlug: 'dwarf',
    backgroundSlug: 'criminal',
    backgroundAbilityBoostPlus2Slug: 'destreza',
    backgroundAbilityBoostPlus1Slug: 'constituicao',
    abilityGenerationMethodSlug: 'standard-array',
    abilityScores: SCORES,
    classSkillSlugs,
    languageSlugs: ['common', 'dwarvish'],
    speciesChoices: [],
    subclassOptions,
    characterSpells: [],
    equipment: [],
    featOptions: [],
  };
}

const spellPickCache = new Map();
let skillsCache = null;

const SCHOOL_EN_TO_PT = {
  abjuration: 'abjuracao',
  conjuration: 'invocacao',
  divination: 'adivinhacao',
  enchantment: 'encantamento',
  evocation: 'evocacao',
  illusion: 'ilusao',
  necromancy: 'necromancia',
  transmutation: 'transmutacao',
};

async function listSkills() {
  if (!skillsCache) {
    skillsCache = (await fetchAllPages('/skills')).map((s) => s.slug);
  }
  return skillsCache;
}

async function pickSpellForFeatOption(def, spellListSlug, used) {
  const level = def.spellMaxLevel ?? 0;
  const schoolsRaw = def.spellSchoolSlugs ?? [];
  const schools = schoolsRaw.map((s) => SCHOOL_EN_TO_PT[s] ?? s);
  const cacheKey = `${spellListSlug ?? '_'}|${level}|${def.spellRitualOnly ? 'r' : 'n'}|${schools.join(',')}`;
  let pool = spellPickCache.get(cacheKey);
  if (!pool) {
    if (spellListSlug) {
      const params = new URLSearchParams({ page: '1', limit: '100' });
      if (level != null) params.set('level', String(level));
      const body = await apiGet(`/classes/${spellListSlug}/spells?${params.toString()}`);
      pool = (body.data ?? [])
        .filter((s) => (s.level ?? s.spellLevel ?? level) === level)
        .map((s) => s.slug ?? s.spellSlug);
    } else {
      const params = new URLSearchParams({ page: '1', limit: '100' });
      if (level != null) params.set('level', String(level));
      const body = await apiGet(`/spells?${params.toString()}`);
      let rows = body.data ?? [];
      if (def.spellRitualOnly) rows = rows.filter((s) => s.ritual === true);
      if (schools.length) {
        rows = rows.filter((s) => schools.includes(s.schoolSlug));
      }
      pool = rows.map((s) => s.slug);
    }
    spellPickCache.set(cacheKey, pool);
  }
  const pick = pool.find((slug) => !used.has(slug));
  if (!pick) {
    throw new Error(
      `Sem magia para ${def.optionKey} (lista=${spellListSlug}, nv=${level}, ritual=${!!def.spellRitualOnly})`,
    );
  }
  used.add(pick);
  return pick;
}

async function buildFeatPatch(feat, classSlug, classSaveSlugs = []) {
  let defs = [];
  try {
    defs = await fetchAllPages(`/feats/${feat.slug}/options`);
  } catch {
    defs = [];
  }

  const options = [];
  const chosen = new Map();
  const usedSpells = new Set();
  const usedCatalogValues = new Set();

  const ordered = [...defs].sort((a, b) => {
    const da = a.dependsOnOptionKey ? 1 : 0;
    const db = b.dependsOnOptionKey ? 1 : 0;
    return da - db || (a.sortOrder ?? 0) - (b.sortOrder ?? 0);
  });

  for (const def of ordered) {
    const values = def.values ?? [];
    let valueId = null;

    if (values.length > 0) {
      const fresh = values.find((v) => v.valueId && !usedCatalogValues.has(v.valueId));
      valueId = fresh?.valueId ?? values[0].valueId;
    }

    if (!valueId && def.valueType === 'spell') {
      const listSlug = def.dependsOnOptionKey
        ? chosen.get(def.dependsOnOptionKey)
        : null;
      valueId = await pickSpellForFeatOption(def, listSlug, usedSpells);
    }

    if (!valueId && def.valueType === 'proficiency') {
      const skills = await listSkills();
      valueId = skills.find((s) => !usedCatalogValues.has(s)) ?? null;
    }

    if (!valueId && def.optionKey === 'distributionMode') valueId = 'plus2';
    if (!valueId && def.optionKey === 'primaryAbility') valueId = 'forca';
    if (!valueId && def.optionKey === 'abilityIncrease') {
      const avoid = new Set(classSaveSlugs);
      valueId =
        values.find((v) => v.valueId && !avoid.has(v.valueId))?.valueId ??
        values[0]?.valueId ??
        'sabedoria';
    }

    // Talentos linked: castingAbility == abilityIncrease
    if (def.optionKey === 'castingAbility' && chosen.has('abilityIncrease')) {
      valueId = chosen.get('abilityIncrease');
    }

    if (!valueId && def.optionKey === 'castingAbility') {
      valueId = values[0]?.valueId ?? 'inteligencia';
    }
    if (!valueId) continue;

    if (
      def.optionKey === 'secondaryAbility' &&
      chosen.get('distributionMode') === 'plus2'
    ) {
      continue;
    }

    chosen.set(def.optionKey, valueId);
    usedCatalogValues.add(valueId);
    options.push({
      featSlug: feat.slug,
      instanceIndex: 0,
      optionKey: def.optionKey,
      valueId,
    });
  }

  if (feat.slug === 'ability-score-improvement' && options.length === 0) {
    options.push(
      {
        featSlug: feat.slug,
        instanceIndex: 0,
        optionKey: 'distributionMode',
        valueId: 'plus2',
      },
      {
        featSlug: feat.slug,
        instanceIndex: 0,
        optionKey: 'primaryAbility',
        valueId: 'forca',
      },
    );
  }

  return {
    characterFeats: [
      { featSlug: 'alert', instanceIndex: 0 },
      { featSlug: feat.slug, instanceIndex: 0 },
    ],
    featOptions: options,
  };
}

async function withRetry(label, fn, attempts = 3) {
  let lastError;
  for (let i = 1; i <= attempts; i += 1) {
    try {
      return await fn();
    } catch (error) {
      lastError = error;
      const msg = String(error?.message ?? error);
      const transient =
        /ENOTFOUND|ECONNRESET|ECONNREFUSED|ETIMEDOUT|terminated unexpectedly|Connection terminated|timeout/i.test(
          msg,
        );
      if (!transient || i === attempts) throw error;
      const waitMs = 1000 * i;
      console.log(`retry ${label} (${i}/${attempts}) após ${waitMs}ms — ${msg}`);
      await new Promise((r) => setTimeout(r, waitMs));
    }
  }
  throw lastError;
}

async function main() {
  console.log(`Smoke sheet matrix → API ${API}`);
  console.log(`userId=${USER_ID} level=${LEVEL} keep=${KEEP} featsOnly=${FEATS_ONLY}\n`);

  const app = await NestFactory.createApplicationContext(AppModule, {
    logger: ['error', 'warn'],
  });

  const create = app.get(CreateCharacterHandler);
  const update = app.get(UpdateCharacterHandler);
  const del = app.get(DeleteCharacterHandler);
  const get = app.get(GetCharacterQuery);

  const classes = await fetchAllPages('/classes');
  const subclasses = await fetchAllPages('/subclasses');
  const feats = await fetchAllPages('/feats');
  const bgSkills = (await fetchAllPages('/backgrounds/criminal/skills')).map(
    (s) => s.slug,
  );

  const byClass = new Map();
  for (const sub of subclasses) {
    const list = byClass.get(sub.classSlug) ?? [];
    list.push(sub);
    byClass.set(sub.classSlug, list);
  }

  const createdIds = [];
  const subclassResults = [];

  if (!FEATS_ONLY) {
    console.log('=== Classe × Subclasse (create nv.3) ===');
    for (const classRow of classes) {
      const subs = byClass.get(classRow.slug) ?? [];
      if (subs.length === 0) {
        subclassResults.push({
          classSlug: classRow.slug,
          subclassSlug: null,
          ok: false,
          error: 'sem subclasses no catálogo',
        });
        continue;
      }

      for (const sub of subs) {
        const label = `${classRow.slug}/${sub.slug}`;
        try {
          const payload = await buildPayload(classRow, sub.slug, bgSkills);
          const created = await withRetry(`create ${label}`, () =>
            create.execute(USER_ID, payload),
          );
          createdIds.push(created.id);
          const detail = await withRetry(`get ${label}`, () =>
            get.execute(USER_ID, created.id),
          );
          const fails = assertApplied(detail, {
            classSlug: classRow.slug,
            subclassSlug: sub.slug,
            classSkillSlugs: payload.classSkillSlugs,
            subclassOptions: payload.subclassOptions,
          });
          if (fails.length) {
            console.log(`FAIL ${label}: ${fails.join('; ')}`);
            subclassResults.push({
              classSlug: classRow.slug,
              subclassSlug: sub.slug,
              ok: false,
              error: fails.join('; '),
              id: created.id,
            });
          } else {
            console.log(
              `OK   ${label}  hp=${detail.hitPointsMax} pb=+${detail.proficiencyBonus} skills=${(detail.classSkillSlugs || []).join(',')}`,
            );
            subclassResults.push({
              classSlug: classRow.slug,
              subclassSlug: sub.slug,
              ok: true,
              id: created.id,
            });
          }
        } catch (error) {
          const msg = error?.response?.message ?? error?.message ?? String(error);
          console.log(`FAIL ${label}: ${msg}`);
          subclassResults.push({
            classSlug: classRow.slug,
            subclassSlug: sub.slug,
            ok: false,
            error: Array.isArray(msg) ? msg.join('; ') : msg,
          });
        }
      }
    }
  } else {
    console.log('=== Classe × Subclasse: pulado (FEATS_ONLY=1; último run 48/48 OK) ===');
  }

  console.log('\n=== Talentos (PATCH em ficha rogue/thief nv.20) ===');
  let featHostId = null;
  let fsHostId = null;
  const featResults = [];
  try {
    const rogue = classes.find((c) => c.slug === 'rogue');
    const fighter = classes.find((c) => c.slug === 'fighter');
    const hostPayload = await buildPayload(rogue, 'thief', bgSkills, 20);
    hostPayload.name = 'SMOKE feat-host';
    hostPayload.abilityScores = {
      forca: 20,
      destreza: 20,
      constituicao: 20,
      inteligencia: 20,
      sabedoria: 20,
      carisma: 20,
    };
    const host = await withRetry('create feat-host', () =>
      create.execute(USER_ID, hostPayload),
    );
    featHostId = host.id;
    createdIds.push(host.id);
    console.log(`Host feats: ${host.id}`);

    const hostSaves = rogue.savingThrowSlugs ?? ['destreza', 'inteligencia'];

    for (const feat of feats) {
      if (feat.slug === 'alert') {
        const detail = await withRetry('get alert', () =>
          get.execute(USER_ID, featHostId),
        );
        const has = (detail.characterFeats ?? []).some((f) => f.featSlug === 'alert');
        console.log(has ? `OK   feat alert (origem)` : `FAIL feat alert (origem ausente)`);
        featResults.push({ slug: feat.slug, ok: has, error: has ? null : 'ausente' });
        continue;
      }

      const isFightingStyle = feat.categorySlug === 'fighting-style';
      try {
        if (isFightingStyle && !fsHostId) {
          const fsPayload = await buildPayload(fighter, 'champion', bgSkills, 20);
          fsPayload.name = 'SMOKE feat-fs-host';
          fsPayload.abilityScores = hostPayload.abilityScores;
          const fsHost = await withRetry('create fs-host', () =>
            create.execute(USER_ID, fsPayload),
          );
          fsHostId = fsHost.id;
          createdIds.push(fsHost.id);
          console.log(`Host fighting-styles: ${fsHostId}`);
        }

        const targetId = isFightingStyle ? fsHostId : featHostId;
        const patch = await buildFeatPatch(
          feat,
          isFightingStyle ? 'fighter' : 'rogue',
          isFightingStyle ? fighter.savingThrowSlugs ?? [] : hostSaves,
        );
        if (isFightingStyle && fsHostId) {
          const fsDetail = await withRetry(`get fs ${feat.slug}`, () =>
            get.execute(USER_ID, fsHostId),
          );
          const taken = new Set(
            (fsDetail.subclassOptions ?? [])
              .filter((o) => String(o.optionKey).toLowerCase().includes('fighting'))
              .map((o) => o.valueId),
          );
          if (taken.has(feat.slug)) {
            console.log(`OK   feat ${feat.slug} (já via subclass option)`);
            featResults.push({
              slug: feat.slug,
              ok: true,
              note: 'já presente em subclassOptions',
            });
            continue;
          }
        }

        await withRetry(`patch ${feat.slug}`, () =>
          update.execute(USER_ID, targetId, {
            characterFeats: patch.characterFeats,
            featOptions: patch.featOptions,
          }),
        );
        const detail = await withRetry(`get ${feat.slug}`, () =>
          get.execute(USER_ID, targetId),
        );
        const has = (detail.characterFeats ?? []).some((f) => f.featSlug === feat.slug);
        if (!has) {
          console.log(`FAIL feat ${feat.slug}: não persistiu`);
          featResults.push({ slug: feat.slug, ok: false, error: 'não persistiu' });
        } else {
          console.log(`OK   feat ${feat.slug}`);
          featResults.push({ slug: feat.slug, ok: true });
        }
      } catch (error) {
        const msg = error?.response?.message ?? error?.message ?? String(error);
        const text = Array.isArray(msg) ? msg.join('; ') : msg;
        console.log(`FAIL feat ${feat.slug}: ${text}`);
        featResults.push({ slug: feat.slug, ok: false, error: text });
      }
    }
  } catch (error) {
    console.log(`FAIL host de talentos: ${error?.message ?? error}`);
  }

  if (!KEEP) {
    console.log('\nLimpando fichas SMOKE…');
    for (const id of createdIds) {
      try {
        await del.execute(USER_ID, id);
      } catch {
        // ignore
      }
    }
  } else {
    console.log(`\nKEEP=1 — ${createdIds.length} fichas preservadas (user ${USER_ID})`);
  }

  await app.close();

  let finalSubclassResults = subclassResults;
  if (FEATS_ONLY) {
    try {
      const prev = JSON.parse(
        (await import('fs')).readFileSync(
          path.join(rootDir, 'scripts', 'smoke-sheet-matrix-report.json'),
          'utf8',
        ),
      );
      if (Array.isArray(prev.subclassResults) && prev.subclassResults.length) {
        finalSubclassResults = prev.subclassResults;
      }
    } catch {
      // sem relatório anterior
    }
  }

  const subOk = finalSubclassResults.filter((r) => r.ok).length;
  const featOk = featResults.filter((r) => r.ok).length;
  console.log('\n=== Resumo ===');
  console.log(
    `Subclasses: ${subOk}/${finalSubclassResults.length} OK${FEATS_ONLY ? ' (cache)' : ''}`,
  );
  console.log(`Talentos:   ${featOk}/${featResults.length} OK`);

  const subFails = finalSubclassResults.filter((r) => !r.ok);
  const featFails = featResults.filter((r) => !r.ok);
  if (subFails.length) {
    console.log('\nFalhas subclass:');
    for (const f of subFails) {
      console.log(`  - ${f.classSlug}/${f.subclassSlug}: ${f.error}`);
    }
  }
  if (featFails.length) {
    console.log('\nFalhas talentos:');
    for (const f of featFails) {
      console.log(`  - ${f.slug}: ${f.error}`);
    }
  }

  const reportPath = path.join(rootDir, 'scripts', 'smoke-sheet-matrix-report.json');
  const fs = await import('fs');
  fs.writeFileSync(
    reportPath,
    JSON.stringify(
      {
        at: new Date().toISOString(),
        level: LEVEL,
        featsOnly: FEATS_ONLY,
        subclassResults: finalSubclassResults,
        featResults,
        summary: {
          subclassesOk: subOk,
          subclassesTotal: finalSubclassResults.length,
          featsOk: featOk,
          featsTotal: featResults.length,
        },
      },
      null,
      2,
    ),
  );
  console.log(`\nRelatório: ${reportPath}`);

  if (subFails.length > 0 || featFails.length > 0) process.exitCode = 1;
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
