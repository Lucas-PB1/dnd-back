import {
  describeDatabaseUrl,
  isSupabasePoolerUrl,
  normalizeDatabaseUrl,
  databaseConfig,
} from './database.config';

describe('database.config helpers', () => {
  const originalUrl = process.env.DATABASE_URL;
  const originalNodeEnv = process.env.NODE_ENV;
  const originalVercel = process.env.VERCEL;

  afterEach(() => {
    if (originalUrl === undefined) delete process.env.DATABASE_URL;
    else process.env.DATABASE_URL = originalUrl;
    if (originalNodeEnv === undefined) delete process.env.NODE_ENV;
    else process.env.NODE_ENV = originalNodeEnv;
    if (originalVercel === undefined) delete process.env.VERCEL;
    else process.env.VERCEL = originalVercel;
  });

  describe('isSupabasePoolerUrl', () => {
    it.each([
      ['postgres://x:y@db.supabase.co:6543/postgres', true],
      ['postgres://x:y@pooler.supabase.com:5432/postgres', true],
      ['postgres://x:y@db.x.com:5432/postgres?pgbouncer=true', true],
      ['postgres://x:y@localhost:5432/rpg', false],
    ])('%s → %s', (url, expected) => {
      expect(isSupabasePoolerUrl(url)).toBe(expected);
    });
  });

  describe('normalizeDatabaseUrl', () => {
    it('adds supabase ssl/pgbouncer params for pooler urls', () => {
      const url = normalizeDatabaseUrl(
        'postgres://u:p@aws-0.pooler.supabase.com:6543/postgres',
      );
      expect(url).toContain('pgbouncer=true');
      expect(url).toContain('uselibpqcompat=true');
      expect(url).toContain('sslmode=require');
    });

    it('does not duplicate existing query params', () => {
      const url = normalizeDatabaseUrl(
        'postgres://u:p@db.supabase.co:5432/postgres?sslmode=require&uselibpqcompat=true',
      );
      expect(url.match(/sslmode=/g)?.length).toBe(1);
      expect(url.match(/uselibpqcompat=/g)?.length).toBe(1);
    });

    it('leaves non-supabase urls untouched aside from trim', () => {
      expect(normalizeDatabaseUrl('  postgres://localhost/rpg  ')).toBe(
        'postgres://localhost/rpg',
      );
    });
  });

  describe('describeDatabaseUrl', () => {
    it('extracts host/port and pooler flag', () => {
      expect(
        describeDatabaseUrl('postgres://u:p@db.example.com:6543/postgres'),
      ).toContain('host=db.example.com port=6543 pooler=true');
      expect(describeDatabaseUrl('postgres://localhost/rpg')).toContain(
        'host=unknown',
      );
    });
  });

  describe('databaseConfig', () => {
    it('throws when DATABASE_URL missing', () => {
      delete process.env.DATABASE_URL;
      expect(() => databaseConfig()).toThrow(/DATABASE_URL is required/);
    });

    it('builds local options without ssl', () => {
      process.env.DATABASE_URL = 'postgres://localhost:5432/rpg';
      process.env.NODE_ENV = 'development';
      delete process.env.VERCEL;
      const cfg = databaseConfig();
      expect(cfg).toMatchObject({
        type: 'postgres',
        schema: 'rpg',
        synchronize: false,
        retryAttempts: 1,
        ssl: false,
      });
    });

    it('enables ssl and pooler extras for supabase prod', () => {
      process.env.DATABASE_URL =
        'postgres://u:p@aws-0.pooler.supabase.com:6543/postgres';
      process.env.NODE_ENV = 'production';
      const log = jest.spyOn(console, 'log').mockImplementation(() => undefined);
      const cfg = databaseConfig() as { ssl?: unknown; retryAttempts?: number; extra?: { prepareThreshold?: number } };
      expect(cfg.ssl).toEqual({ rejectUnauthorized: false });
      expect(cfg.retryAttempts).toBe(5);
      expect(cfg.extra?.prepareThreshold).toBe(0);
      log.mockRestore();
    });
  });
});
