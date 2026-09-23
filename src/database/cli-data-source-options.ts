import { join } from 'path';
import { DataSourceOptions } from 'typeorm';
import {
  describeDatabaseUrl,
  isSupabaseDatabaseUrl,
  isSupabasePoolerUrl,
  normalizeDatabaseUrl,
} from '../config/database.config';

/**
 * Opções do DataSource CLI (migrations). Espelha URL/schema/SSL de
 * `databaseConfig()` — sem `autoLoadEntities` / retry do Nest.
 */
export function createCliDataSourceOptions(
  env: NodeJS.ProcessEnv = process.env,
): DataSourceOptions {
  const rawUrl = env.DATABASE_URL?.trim();
  if (!rawUrl) {
    throw new Error('DATABASE_URL is required for TypeORM CLI');
  }

  const url = normalizeDatabaseUrl(rawUrl);
  const isSupabase = isSupabaseDatabaseUrl(url);
  const usePooler = isSupabasePoolerUrl(url);
  const useSsl = isSupabase;
  const isProd = env.NODE_ENV === 'production' || env.VERCEL === '1';

  if (isProd && isSupabase) {
    console.log(`[database:cli] connecting ${describeDatabaseUrl(url)}`);
  }

  const root = join(__dirname, '..');

  return {
    type: 'postgres',
    url,
    schema: 'rpg',
    synchronize: false,
    logging: ['error', 'warn', 'migration'],
    entities: [join(root, 'entities', '**', '*.entity.{ts,js}')],
    migrations: [join(__dirname, 'migrations', '*.{ts,js}')],
    migrationsTableName: 'migrations',
    extra: {
      max: 1,
      connectionTimeoutMillis: 20_000,
      idleTimeoutMillis: 5_000,
      keepAlive: false,
      ...(useSsl ? { ssl: { rejectUnauthorized: false } } : {}),
      ...(usePooler ? { prepareThreshold: 0 } : {}),
    },
    ssl: useSsl ? { rejectUnauthorized: false } : false,
  };
}
