/**
 * Mede GET /characters/:id sem JWT — Nest + TestAuth (X-Test-User-Id).
 *
 * Uso:
 *   npm run measure:character
 *   npm run measure:character -- --rounds=10 --warm=1
 *   npm run measure:character -- --class=wizard --create
 *   npm run measure:character -- --character=uuid
 */
import 'reflect-metadata';
import path from 'path';
import { createRequire } from 'node:module';
import { pathToFileURL } from 'node:url';
import { loadEnv, rootDir } from './lib/load-env.mjs';
import { createPgClient } from './lib/pg-client.mjs';

loadEnv();
process.env.SHEET_PROFILE = '1';
process.chdir(rootDir);

const require = createRequire(pathToFileURL(path.join(rootDir, 'package.json')).href);

function argValue(prefix, fallback) {
  const hit = process.argv.find((arg) => arg.startsWith(prefix));
  return hit ? hit.slice(prefix.length) : fallback;
}

const rounds = Math.max(1, Number(argValue('--rounds=', '10')) || 10);
const warmDiscard = Math.max(0, Number(argValue('--warm=', '1')) || 0);
const characterArg = argValue('--character=', '');
const classArg = argValue('--class=', '');
const forceCreate = process.argv.includes('--create');

function measureCreatePayload(classSlug) {
  if (classSlug === 'wizard') {
    return {
      name: 'Measure Wizard',
      classSlug: 'wizard',
      speciesSlug: 'dwarf',
      backgroundSlug: 'soldier',
      classSkillSlugs: ['arcana', 'history'],
      languageSlugs: ['common', 'dwarvish', 'elvish'],
      backgroundAbilityBoostMode: 'plus2plus1',
      backgroundAbilityBoostPlus2Slug: 'destreza',
      backgroundAbilityBoostPlus1Slug: 'constituicao',
      backgroundToolItemSlug: 'conjunto-de-dados',
      characterFeats: [{ featSlug: 'savage-attacker', instanceIndex: 0 }],
      // L1: 3 truques + grimório (prepared conta no livro)
      characterSpells: [
        { spellSlug: 'raio-de-fogo', listType: 'known' },
        { spellSlug: 'luz', listType: 'known' },
        { spellSlug: 'amigos', listType: 'known' },
        { spellSlug: 'alarme', listType: 'prepared' },
        { spellSlug: 'escudo-arcano', listType: 'prepared' },
        { spellSlug: 'maos-flamejantes', listType: 'prepared' },
        { spellSlug: 'sono', listType: 'prepared' },
        { spellSlug: 'detectar-magia', listType: 'known' },
        { spellSlug: 'queda-suave', listType: 'known' },
      ],
    };
  }

  return {
    name: 'Measure Fighter',
    classSlug: 'fighter',
    speciesSlug: 'dwarf',
    backgroundSlug: 'soldier',
    classSkillSlugs: ['perception', 'insight'],
    languageSlugs: ['common', 'dwarvish', 'elvish'],
    backgroundAbilityBoostMode: 'plus2plus1',
    backgroundAbilityBoostPlus2Slug: 'forca',
    backgroundAbilityBoostPlus1Slug: 'constituicao',
    backgroundToolItemSlug: 'conjunto-de-dados',
    characterFeats: [
      { featSlug: 'savage-attacker', instanceIndex: 0 },
      { featSlug: 'defense', instanceIndex: 0 },
    ],
    classOptions: [
      { optionKey: 'masteryWeapon1', valueId: 'longsword' },
      { optionKey: 'masteryWeapon2', valueId: 'greataxe' },
      { optionKey: 'masteryWeapon3', valueId: 'longbow' },
    ],
  };
}

async function resolveCharacter(client) {
  if (characterArg) {
    const { rows } = await client.query(
      `SELECT id::text AS id, name, class_slug, user_id::text AS user_id
       FROM rpg.player_character WHERE id = $1::uuid LIMIT 1`,
      [characterArg],
    );
    if (!rows[0]) throw new Error(`Personagem ${characterArg} não encontrado`);
    return rows[0];
  }

  const users = await client.query(
    `SELECT id::text AS id FROM auth.users ORDER BY created_at NULLS LAST LIMIT 1`,
  );
  if (!users.rows[0]) {
    throw new Error('Sem auth.users — não dá para criar ficha de medição');
  }
  const userId = users.rows[0].id;

  if (forceCreate) {
    return { createForUserId: userId, createClassSlug: classArg || 'fighter' };
  }

  if (classArg) {
    const { rows } = await client.query(
      `SELECT id::text AS id, name, class_slug, user_id::text AS user_id
       FROM rpg.player_character
       WHERE class_slug = $1
       ORDER BY updated_at DESC NULLS LAST
       LIMIT 1`,
      [classArg],
    );
    if (rows[0]) return rows[0];
    return { createForUserId: userId, createClassSlug: classArg };
  }

  const { rows } = await client.query(
    `SELECT id::text AS id, name, class_slug, user_id::text AS user_id
     FROM rpg.player_character
     ORDER BY updated_at DESC NULLS LAST
     LIMIT 1`,
  );
  if (rows[0]) return rows[0];

  return { createForUserId: userId, createClassSlug: 'fighter' };
}

function avg(values) {
  if (!values.length) return 0;
  return values.reduce((a, b) => a + b, 0) / values.length;
}

function pct(values, p) {
  if (!values.length) return 0;
  const sorted = [...values].sort((a, b) => a - b);
  const idx = Math.min(
    sorted.length - 1,
    Math.floor((p / 100) * sorted.length),
  );
  return sorted[idx];
}

function loadNestFromDist() {
  try {
    const { AppModule } = require('./dist/app.module.js');
    const guardEntry = Object.keys(require.cache).find((key) =>
      key.replace(/\\/g, '/').endsWith('/identity/guards/supabase-auth.guard.js'),
    );
    if (!guardEntry) {
      throw new Error('SupabaseAuthGuard não encontrado no require.cache');
    }
    const { SupabaseAuthGuard } = require.cache[guardEntry].exports;
    const profileEntry = Object.keys(require.cache).find((key) =>
      key.replace(/\\/g, '/').endsWith('/common/perf/sheet-profile.js'),
    );
    const profile = profileEntry
      ? require.cache[profileEntry].exports
      : require('./dist/common/perf/sheet-profile.js');
    return { AppModule, SupabaseAuthGuard, profile };
  } catch (err) {
    if (err?.code === 'MODULE_NOT_FOUND' || /não encontrado/.test(String(err))) {
      return null;
    }
    throw err;
  }
}

async function main() {
  const url = process.env.DATABASE_URL;
  if (!url) throw new Error('DATABASE_URL não definida');

  const client = createPgClient(url);
  await client.connect();
  let character;
  try {
    character = await resolveCharacter(client);
  } finally {
    await client.end();
  }

  let mods = loadNestFromDist();
  if (!mods) {
    console.log('Compilando (npm run build)…');
    const { execSync } = await import('node:child_process');
    execSync('npm run build', { cwd: rootDir, stdio: 'inherit' });
    mods = loadNestFromDist();
  }
  if (!mods) throw new Error('Falha ao carregar dist/');

  const { ValidationPipe, UnauthorizedException } = require('@nestjs/common');
  const { Test } = require('@nestjs/testing');
  const request = require('supertest');

  const testGuard = {
    canActivate(context) {
      const req = context.switchToHttp().getRequest();
      const userId = req.headers['x-test-user-id'];
      if (!userId || typeof userId !== 'string') {
        throw new UnauthorizedException('Missing X-Test-User-Id header');
      }
      req.user = { id: userId, email: 'measure@local.test' };
      return true;
    },
  };

  const moduleRef = await Test.createTestingModule({
    imports: [mods.AppModule],
  })
    .overrideGuard(mods.SupabaseAuthGuard)
    .useValue(testGuard)
    .compile();

  const app = moduleRef.createNestApplication();
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      transform: true,
      transformOptions: { enableImplicitConversion: true },
    }),
  );
  await app.init();
  const server = app.getHttpServer();

  let resolved = character;
  if (resolved.createForUserId) {
    const createClass = resolved.createClassSlug || 'fighter';
    const payload = measureCreatePayload(createClass);
    console.log(`Criando ${createClass} mínimo para medição…`);
    const createRes = await request(server)
      .post('/characters')
      .set({ 'X-Test-User-Id': resolved.createForUserId })
      .send(payload);
    if (createRes.status !== 201 && createRes.status !== 200) {
      console.error('Falha ao criar ficha', createRes.status, createRes.body);
      await app.close();
      process.exit(1);
    }
    resolved = {
      id: createRes.body.id,
      name: createRes.body.name,
      class_slug: createRes.body.classSlug,
      user_id: resolved.createForUserId,
    };
  }

  const pathUrl = `/characters/${resolved.id}`;
  const auth = { 'X-Test-User-Id': resolved.user_id };
  /** @type {number[]} */
  const walls = [];
  let lastStatus = 0;
  let lastBytes = 0;
  /** @type {{ name: string; ms: number }[]} */
  let lastSpans = [];

  console.log(
    `Measure character — ${resolved.name} (${resolved.class_slug}) id=${resolved.id}`,
  );
  console.log(`rounds=${rounds} warmDiscard=${warmDiscard} SHEET_PROFILE=1\n`);

  for (let i = 0; i < rounds; i++) {
    mods.profile.resetSheetProfile();
    const started = performance.now();
    const res = await request(server).get(pathUrl).set(auth);
    walls.push(performance.now() - started);
    lastStatus = res.status;
    lastBytes = JSON.stringify(res.body ?? {}).length;
    lastSpans = [...mods.profile.getSheetProfileSpans()];
    if (res.status !== 200) {
      console.error(`HTTP ${res.status}`, res.body);
      break;
    }
  }

  const measured = walls.slice(
    Math.min(warmDiscard, Math.max(0, walls.length - 1)),
  );
  const cold = walls.slice(0, walls.length - measured.length);

  console.log(
    `GET ${pathUrl}\n` +
      `  status=${lastStatus} bytes≈${lastBytes}\n` +
      `  wall avg=${avg(measured).toFixed(1)}ms p95=${pct(measured, 95).toFixed(1)}ms` +
      (cold.length
        ? ` (cold ${cold.map((v) => v.toFixed(0)).join(',')}ms)`
        : '') +
      '\n',
  );

  if (lastSpans.length) {
    console.log('Último round — breakdown (ms):');
    const byName = new Map();
    for (const span of lastSpans) {
      byName.set(span.name, (byName.get(span.name) ?? 0) + span.ms);
    }
    const rows = [...byName.entries()].sort((a, b) => b[1] - a[1]);
    for (const [name, ms] of rows) {
      console.log(`  ${ms.toFixed(1).padStart(7)}  ${name}`);
    }
    console.log('');
  }

  await app.close();
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
