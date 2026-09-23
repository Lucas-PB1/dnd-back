import { PostgresConnectionOptions } from 'typeorm/driver/postgres/PostgresConnectionOptions';
import { createCliDataSourceOptions } from './cli-data-source-options';

describe('createCliDataSourceOptions', () => {
  const originalUrl = process.env.DATABASE_URL;

  afterEach(() => {
    if (originalUrl === undefined) delete process.env.DATABASE_URL;
    else process.env.DATABASE_URL = originalUrl;
  });

  it('exige DATABASE_URL', () => {
    delete process.env.DATABASE_URL;
    expect(() => createCliDataSourceOptions({})).toThrow(/DATABASE_URL/);
  });

  it('espelha schema rpg, synchronize false e tabela migrations', () => {
    const opts = createCliDataSourceOptions({
      DATABASE_URL: 'postgres://u:p@localhost:5432/postgres',
    }) as PostgresConnectionOptions;

    expect(opts.type).toBe('postgres');
    expect(opts.schema).toBe('rpg');
    expect(opts.synchronize).toBe(false);
    expect(opts.migrationsTableName).toBe('migrations');
    expect(opts.url).toContain('localhost');
  });

  it('aplica SSL/params Supabase no pooler', () => {
    const opts = createCliDataSourceOptions({
      DATABASE_URL: 'postgres://u:p@aws-0.pooler.supabase.com:6543/postgres',
    }) as PostgresConnectionOptions;

    expect(opts.url).toContain('pgbouncer=true');
    expect(opts.url).toContain('sslmode=require');
    expect(opts.ssl).toEqual({ rejectUnauthorized: false });
  });
});
