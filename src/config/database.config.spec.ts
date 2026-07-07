import { describe, expect, it } from '@jest/globals';

import {
  describeDatabaseUrl,
  isSupabasePoolerUrl,
  normalizeDatabaseUrl,
} from './database.config';

describe('normalizeDatabaseUrl', () => {
  it('adds pgbouncer and sslmode for Supabase pooler', () => {
    const url =
      'postgresql://postgres.abc:secret@aws-0-sa.pooler.supabase.com:6543/postgres';
    const normalized = normalizeDatabaseUrl(url);
    expect(normalized).toContain('pgbouncer=true');
    expect(normalized).toContain('uselibpqcompat=true');
    expect(normalized).toContain('sslmode=require');
    expect(isSupabasePoolerUrl(normalized)).toBe(true);
  });

  it('keeps existing query params', () => {
    const url =
      'postgresql://postgres.abc:secret@aws-0-sa.pooler.supabase.com:6543/postgres?pgbouncer=true';
    expect(normalizeDatabaseUrl(url)).toBe(
      `${url}&uselibpqcompat=true&sslmode=require`,
    );
  });
});

describe('describeDatabaseUrl', () => {
  it('summarizes host and port without leaking secrets', () => {
    expect(
      describeDatabaseUrl(
        'postgresql://postgres.abc:secret@aws-0-sa.pooler.supabase.com:6543/postgres',
      ),
    ).toBe('host=aws-0-sa.pooler.supabase.com port=6543 pooler=true');
  });
});
