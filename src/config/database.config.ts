import { TypeOrmModuleOptions } from '@nestjs/typeorm';

export function databaseConfig(): TypeOrmModuleOptions {
  const url = process.env.DATABASE_URL;
  if (!url) {
    throw new Error('DATABASE_URL is required');
  }

  const isProd = process.env.NODE_ENV === 'production';

  return {
    type: 'postgres',
    url,
    schema: 'rpg',
    synchronize: false,
    autoLoadEntities: true,
    extra: {
      max: isProd ? 1 : 5,
    },
    ssl: isProd ? { rejectUnauthorized: false } : false,
  };
}
