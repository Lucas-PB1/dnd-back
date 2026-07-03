import pg from 'pg';

/** @param {string} connectionString */
export function isSupabaseUrl(connectionString) {
  return /supabase\.(co|com)/i.test(connectionString);
}

/** @param {string} connectionString */
export function createPgClient(connectionString) {
  const ssl = isSupabaseUrl(connectionString)
    ? { rejectUnauthorized: false }
    : undefined;

  return new pg.Client({ connectionString, ssl });
}

/** @param {string} connectionString */
export function maskDatabaseUrl(connectionString) {
  try {
    const url = new URL(connectionString);
    if (url.password) url.password = '****';
    return `${url.hostname}:${url.port || '5432'}${url.pathname}`;
  } catch {
    return '(invalid URL)';
  }
}
