import { TypeOrmModuleOptions } from '@nestjs/typeorm';

function isSupabaseDatabaseUrl(url: string): boolean {
  return /supabase\.(co|com)/i.test(url);
}

export function databaseConfig(): TypeOrmModuleOptions {
  const url = process.env.DATABASE_URL;
  if (!url) {
    throw new Error('DATABASE_URL is required');
  }

  const isProd = process.env.NODE_ENV === 'production';
  const useSsl = isProd || isSupabaseDatabaseUrl(url);

  return {
    type: 'postgres',
    url,
    schema: 'rpg',
    synchronize: false,
    autoLoadEntities: true,
    extra: {
      max: isProd ? 1 : 5,
    },
    ssl: useSsl ? { rejectUnauthorized: false } : false,
  };
}
