import 'reflect-metadata';
import path from 'path';
import { DataSource } from 'typeorm';
import { createCliDataSourceOptions } from './cli-data-source-options';
import { runSeedPipeline, SeedRunOptions } from './seed-runner';

function parseMode(argv: string[]): SeedRunOptions['mode'] {
  if (argv.includes('--status')) return 'status';
  if (argv.includes('--fresh')) return 'fresh';
  return 'pending';
}

function parseFrom(argv: string[]): string | null {
  const arg = argv.find((a) => a.startsWith('--from='));
  if (!arg) return null;
  return (
    arg.split('=')[1]?.replace(/\\/g, '/').replace(/^database\/seeds\//, '') ??
    null
  );
}

async function main(): Promise<void> {
  const argv = process.argv.slice(2);
  const rootDir = path.resolve(__dirname, '../..');
  const mode = parseMode(argv);
  const fromRel = parseFrom(argv);
  const skipRefresh = argv.includes('--skip-refresh');

  if (!process.env.DATABASE_URL?.trim()) {
    throw new Error('DATABASE_URL is required for seed runner');
  }

  const ds = new DataSource(createCliDataSourceOptions());
  await ds.initialize();
  try {
    await runSeedPipeline(ds, {
      rootDir,
      mode,
      fromRel,
      skipRefresh,
    });
  } finally {
    await ds.destroy();
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
