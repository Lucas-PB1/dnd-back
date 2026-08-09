/**
 * One-shot: cria 1 personagem Nv20 completo por classe na conta local.
 * 1) node scripts/generate-review-l20-payloads.mjs
 * 2) npx jest --config ./test/jest-e2e.config.js --runInBand create-class-review-characters
 */
import fs from 'fs';
import path from 'path';
import { execFileSync } from 'child_process';
import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { DataSource } from 'typeorm';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from '../src/app.module';
import { HttpExceptionFilter } from '../src/common/filters/http-exception.filter';
import { SupabaseAuthGuard } from '../src/identity/guards/supabase-auth.guard';
import { TestAuthGuard } from './helpers/test-auth.guard';

const OWNER_EMAIL = 'lucasoaresnet@gmail.com';
const OUT_DIR = path.join(__dirname, '..', 'tmp', 'review-l20');

describe('Create class review characters (L20)', () => {
  let app: INestApplication<App>;
  let db: DataSource;
  let userId: string;

  beforeAll(async () => {
    execFileSync(process.execPath, ['scripts/generate-review-l20-payloads.mjs', OUT_DIR], {
      cwd: path.join(__dirname, '..'),
      stdio: 'inherit',
    });

    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    })
      .overrideGuard(SupabaseAuthGuard)
      .useClass(TestAuthGuard)
      .compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalFilters(new HttpExceptionFilter());
    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
        transform: true,
        transformOptions: { enableImplicitConversion: true },
      }),
    );
    await app.init();
    db = app.get(DataSource);

    const users = await db.query<{ id: string }[]>(
      `SELECT id FROM auth.users WHERE email = $1 LIMIT 1`,
      [OWNER_EMAIL],
    );
    if (!users[0]) {
      throw new Error(`User not found: ${OWNER_EMAIL}`);
    }
    userId = users[0].id;

    await db.query(
      `DELETE FROM rpg.player_character
       WHERE user_id = $1 AND name LIKE 'Review · %'`,
      [userId],
    );
  }, 300_000);

  afterAll(async () => {
    await app.close();
  });

  const auth = () => ({ 'X-Test-User-Id': userId });

  it('creates one complete L20 character per class', async () => {
    const indexPath = path.join(OUT_DIR, '_index.json');
    if (!fs.existsSync(indexPath)) {
      throw new Error(`Índice não encontrado: ${indexPath}`);
    }
    const index = JSON.parse(fs.readFileSync(indexPath, 'utf8')) as {
      ok: boolean;
      classSlug: string;
      file?: string;
      name?: string;
      subclassSlug?: string;
      error?: string;
    }[];

    const created: { name: string; classSlug: string; subclassSlug: string; id: string }[] =
      [];

    for (const entry of index) {
      if (!entry.ok || !entry.file) {
        throw new Error(`Payload falhou para ${entry.classSlug}: ${entry.error}`);
      }
      const payload = JSON.parse(fs.readFileSync(entry.file, 'utf8'));
      const res = await request(app.getHttpServer())
        .post('/characters')
        .set(auth())
        .send(payload);

      if (res.status !== 201) {
        // eslint-disable-next-line no-console
        console.error(
          `FAIL ${entry.classSlug}/${payload.subclassSlug}`,
          res.status,
          JSON.stringify(res.body, null, 2),
        );
      }
      expect(res.status).toBe(201);
      created.push({
        name: payload.name,
        classSlug: entry.classSlug,
        subclassSlug: payload.subclassSlug,
        id: res.body.id as string,
      });
    }

    // eslint-disable-next-line no-console
    console.log('\nCreated characters:');
    for (const c of created) {
      // eslint-disable-next-line no-console
      console.log(`- ${c.name} (${c.classSlug}/${c.subclassSlug}) id=${c.id}`);
    }
    expect(created).toHaveLength(index.length);
    expect(created.length).toBeGreaterThanOrEqual(13);
  }, 600_000);
});
