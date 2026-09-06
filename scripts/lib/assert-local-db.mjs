/**
 * Garante que o target "local" não aponte para Supabase cloud.
 * Iteração de schema/seed deve ser localhost (Docker / Postgres / Supabase CLI).
 */
import { isSupabaseUrl } from './pg-client.mjs';

/**
 * @param {string} url
 * @param {{ label?: string, allowRemote?: boolean }} [opts]
 */
export function assertLocalDatabaseUrl(url, opts = {}) {
  const allowRemote =
    opts.allowRemote === true ||
    process.argv.includes('--allow-remote') ||
    process.env.ALLOW_REMOTE_AS_LOCAL === 'yes';

  if (!isSupabaseUrl(url) && !/supabase\.com/i.test(url)) {
    return;
  }

  if (allowRemote) {
    console.warn(
      `\n⚠️  ${opts.label ?? 'local'}: DATABASE_URL aponta para Supabase cloud (--allow-remote).\n`,
    );
    return;
  }

  console.error(`
FAIL: target "local" está usando host Supabase cloud.

  Hoje DATABASE_URL = nuvem → cada db:reset/db:setup é lento e remoto.

  Faça assim:
  1. Suba Postgres local:  npm run db:up
     (ou: docker compose up -d postgres)
  2. No .env:
       DATABASE_URL=postgresql://postgres:postgres@localhost:5432/postgres
       SUPABASE_DATABASE_URL=…   # só cloud, para --target=supabase / db:setup:all
  3. Itere:  npm run db:setup
             npm run db:seed -- --from=path/relativo.sql

  Escape (não recomendado): --allow-remote ou ALLOW_REMOTE_AS_LOCAL=yes
`);
  process.exit(1);
}
