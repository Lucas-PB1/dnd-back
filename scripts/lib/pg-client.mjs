import pg from 'pg';

/** @param {string} connectionString */
export function isSupabaseUrl(connectionString) {
  return /supabase\.(co|com)/i.test(connectionString);
}

/**
 * Pooler (mesmo em :5432) pode descartar DDL entre commits.
 * Preferir host direto db.<project>.supabase.co para migrate/seed/reset
 * quando a rede resolve IPv4; no Windows costuma ser IPv6-only (ENOTFOUND).
 * @param {string} connectionString
 * @param {{ preferPooler?: boolean }} [opts]
 */
export function resolveDirectDatabaseUrl(connectionString, opts = {}) {
  if (opts.preferPooler) return connectionString;
  try {
    const u = new URL(connectionString);
    if (!u.hostname.includes('pooler.supabase')) {
      return connectionString;
    }
    const project = u.username.includes('.')
      ? u.username.split('.')[1]
      : null;
    if (!project) return connectionString;
    u.username = 'postgres';
    u.hostname = `db.${project}.supabase.co`;
    u.port = '5432';
    return u.toString();
  } catch {
    return connectionString;
  }
}

/** @param {string} connectionString */
export function createPgClient(connectionString, opts = {}) {
  const ssl = isSupabaseUrl(connectionString)
    ? { rejectUnauthorized: false }
    : undefined;

  return new pg.Client({
    connectionString: resolveDirectDatabaseUrl(connectionString, opts),
    ssl,
  });
}

/** @param {string} connectionString */
export function maskDatabaseUrl(connectionString, opts = {}) {
  try {
    const url = new URL(resolveDirectDatabaseUrl(connectionString, opts));
    if (url.password) url.password = '****';
    return `${url.hostname}:${url.port || '5432'}${url.pathname}`;
  } catch {
    return '(invalid URL)';
  }
}
