import { isSupabasePoolerUrl } from './database.config';

function isSupabaseDirectUrl(url: string): boolean {
  return /:5432(\/|$)/.test(url) && /db\.[\w-]+\.supabase\.(co|com)/i.test(url);
}

export function validateDeployEnv(): void {
  const onVercel = process.env.VERCEL === '1';
  const isProd = process.env.NODE_ENV === 'production';

  if (!onVercel && !isProd) {
    return;
  }

  const missing: string[] = [];
  if (!process.env.DATABASE_URL?.trim()) missing.push('DATABASE_URL');

  if (missing.length > 0) {
    throw new Error(
      `Missing required environment variables on Vercel: ${missing.join(', ')}`,
    );
  }

  if (!process.env.SUPABASE_URL?.trim()) {
    console.warn(
      '[deploy] SUPABASE_URL not set — rotas autenticadas falharão até configurar',
    );
  }

  const dbUrl = process.env.DATABASE_URL!.trim();
  if (isSupabaseDirectUrl(dbUrl) && !isSupabasePoolerUrl(dbUrl)) {
    throw new Error(
      'DATABASE_URL must use the Supabase transaction pooler (port 6543, ?pgbouncer=true), not the direct connection (5432). Use SUPABASE_DATABASE_URL only for migrations locally.',
    );
  }
}
