import { TypeOrmModuleOptions } from '@nestjs/typeorm';

function isSupabaseDatabaseUrl(url: string): boolean {
  return /supabase\.(co|com)/i.test(url);
}

export function isSupabasePoolerUrl(url: string): boolean {
  return (
    /:6543(\/|$|\?)/.test(url) ||
    /pooler\.supabase\.(co|com)/i.test(url) ||
    /pgbouncer=true/i.test(url)
  );
}

function ensureQueryParam(url: string, key: string, value: string): string {
  const pattern = new RegExp(`([?&])${key}=`);
  if (pattern.test(url)) {
    return url;
  }
  return `${url}${url.includes('?') ? '&' : '?'}${key}=${value}`;
}

export function normalizeDatabaseUrl(url: string): string {
  let normalized = url.trim();

  if (isSupabaseDatabaseUrl(normalized)) {
    if (isSupabasePoolerUrl(normalized)) {
      normalized = ensureQueryParam(normalized, 'pgbouncer', 'true');
    }
    // pg v8+ trata sslmode=require como verify-full; Supabase pooler precisa de compat libpq
    normalized = ensureQueryParam(normalized, 'uselibpqcompat', 'true');
    normalized = ensureQueryParam(normalized, 'sslmode', 'require');
  }

  return normalized;
}

export function describeDatabaseUrl(url: string): string {
  const hostMatch = url.match(/@([^:/@]+)(?::(\d+))?/);
  const host = hostMatch?.[1] ?? 'unknown';
  const port = hostMatch?.[2] ?? 'default';
  return `host=${host} port=${port} pooler=${isSupabasePoolerUrl(url)}`;
}

export function databaseConfig(): TypeOrmModuleOptions {
  const rawUrl = process.env.DATABASE_URL?.trim();
  if (!rawUrl) {
    throw new Error(
      'DATABASE_URL is required. On Vercel use the Supabase transaction pooler (port 6543) with ?pgbouncer=true',
    );
  }

  const url = normalizeDatabaseUrl(rawUrl);
  const isProd =
    process.env.NODE_ENV === 'production' || process.env.VERCEL === '1';
  const isSupabase = isSupabaseDatabaseUrl(url);
  const usePooler = isSupabasePoolerUrl(url);
  const useSsl = isSupabase;

  if (isProd && isSupabase) {
    console.log(`[database] connecting ${describeDatabaseUrl(url)}`);
  }

  return {
    type: 'postgres',
    url,
    schema: 'rpg',
    synchronize: false,
    autoLoadEntities: true,
    retryAttempts: isProd ? 5 : 1,
    retryDelay: 3000,
    extra: {
      max: isProd ? 1 : 5,
      connectionTimeoutMillis: 20_000,
      idleTimeoutMillis: 5_000,
      keepAlive: false,
      ...(useSsl ? { ssl: { rejectUnauthorized: false } } : {}),
      ...(usePooler
        ? {
            prepareThreshold: 0,
          }
        : {}),
    },
    ssl: useSsl ? { rejectUnauthorized: false } : false,
  };
}
