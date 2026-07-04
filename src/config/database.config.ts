import { TypeOrmModuleOptions } from '@nestjs/typeorm';

function isSupabaseDatabaseUrl(url: string): boolean {
  return /supabase\.(co|com)/i.test(url);
}

export function isSupabasePoolerUrl(url: string): boolean {
  return (
    /:6543(\/|$)/.test(url) ||
    /pooler\.supabase\.(co|com)/i.test(url) ||
    /pgbouncer=true/i.test(url)
  );
}

export function databaseConfig(): TypeOrmModuleOptions {
  const url = process.env.DATABASE_URL?.trim();
  if (!url) {
    throw new Error(
      'DATABASE_URL is required. On Vercel use the Supabase transaction pooler (port 6543) with ?pgbouncer=true',
    );
  }

  const isProd =
    process.env.NODE_ENV === 'production' || process.env.VERCEL === '1';
  const useSsl = isProd || isSupabaseDatabaseUrl(url);
  const usePooler = isSupabasePoolerUrl(url);

  return {
    type: 'postgres',
    url,
    schema: 'rpg',
    synchronize: false,
    autoLoadEntities: true,
    retryAttempts: isProd ? 3 : 1,
    retryDelay: 2000,
    extra: {
      max: isProd ? 1 : 5,
      connectionTimeoutMillis: 15_000,
      idleTimeoutMillis: 10_000,
      ...(usePooler
        ? {
            // Transaction pooler (PgBouncer) does not support prepared statements.
            prepareThreshold: 0,
          }
        : {}),
    },
    ssl: useSsl ? { rejectUnauthorized: false } : false,
  };
}
