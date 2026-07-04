import { describe, expect, it, beforeEach, afterEach } from '@jest/globals';

import { isSupabasePoolerUrl } from './database.config';
import { validateDeployEnv } from './validate-env';

describe('isSupabasePoolerUrl', () => {
  it('detects port 6543 and pooler host', () => {
    expect(
      isSupabasePoolerUrl(
        'postgresql://u:p@aws-0-sa.pooler.supabase.com:6543/postgres?pgbouncer=true',
      ),
    ).toBe(true);
    expect(
      isSupabasePoolerUrl(
        'postgresql://u:p@db.xxx.supabase.co:5432/postgres',
      ),
    ).toBe(false);
  });
});

describe('validateDeployEnv', () => {
  const original = { ...process.env };

  beforeEach(() => {
    process.env = { ...original };
  });

  afterEach(() => {
    process.env = original;
  });

  it('skips validation in local development', () => {
    process.env.NODE_ENV = 'development';
    delete process.env.VERCEL;
    delete process.env.DATABASE_URL;
    expect(() => validateDeployEnv()).not.toThrow();
  });

  it('requires DATABASE_URL and SUPABASE_URL on Vercel', () => {
    process.env.VERCEL = '1';
    process.env.NODE_ENV = 'production';
    delete process.env.DATABASE_URL;
    delete process.env.SUPABASE_URL;
    expect(() => validateDeployEnv()).toThrow(/DATABASE_URL/);
  });

  it('rejects Supabase direct URL as DATABASE_URL on Vercel', () => {
    process.env.VERCEL = '1';
    process.env.DATABASE_URL =
      'postgresql://postgres:pass@db.abc.supabase.co:5432/postgres';
    process.env.SUPABASE_URL = 'https://abc.supabase.co';
    expect(() => validateDeployEnv()).toThrow(/6543/);
  });
});
