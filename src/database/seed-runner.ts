import fs from 'fs';
import { DataSource } from 'typeorm';
import { sha256Hex } from './seed-checksum';
import {
  clearSeedLedger,
  ensureSeedLedger,
  loadAppliedChecksums,
  upsertSeedLedger,
} from './seed-ledger';
import {
  applyFromFilter,
  listCatalogSeedFiles,
  resolveSeedsDir,
  truncateSeedPath,
  SeedFile,
} from './seed-order';
import { refreshCatalogMaterializedViews } from './seed-refresh-mvs';

export type SeedRunOptions = {
  rootDir: string;
  mode: 'pending' | 'fresh' | 'status';
  fromRel?: string | null;
  skipRefresh?: boolean;
};

export async function runSeedPipeline(
  ds: DataSource,
  opts: SeedRunOptions,
): Promise<void> {
  await ensureSeedLedger(ds);
  const seedsDir = resolveSeedsDir(opts.rootDir);
  let files = listCatalogSeedFiles(seedsDir);
  files = applyFromFilter(files, opts.fromRel ?? null);

  if (opts.mode === 'status') {
    await printSeedStatus(ds, files);
    return;
  }

  if (opts.mode === 'fresh') {
    const truncate = truncateSeedPath(seedsDir);
    if (truncate) {
      process.stdout.write('  truncate catalog... ');
      await ds.query(fs.readFileSync(truncate, 'utf8'));
      console.log('ok');
    }
    await clearSeedLedger(ds);
    console.log('  seed ledger cleared');
  }

  const applied = await loadAppliedChecksums(ds);
  let ran = 0;

  for (const file of files) {
    const sql = fs.readFileSync(file.filePath, 'utf8');
    const checksum = sha256Hex(sql);
    const prev = applied.get(file.version);

    if (opts.mode === 'pending' && prev === checksum) {
      continue;
    }

    const tag =
      prev && prev !== checksum ? 're-seed (checksum changed)' : 'seeding';
    process.stdout.write(`  ${tag} ${file.version}... `);
    await ds.query(sql);
    await upsertSeedLedger(ds, file.version, checksum);
    console.log('ok');
    ran += 1;
  }

  if (!opts.skipRefresh && (ran > 0 || opts.mode === 'fresh')) {
    await refreshCatalogMaterializedViews(ds);
  } else if (!opts.skipRefresh && ran === 0) {
    console.log('  MVs: skip (nenhum seed aplicado)');
  }

  console.log(
    opts.mode === 'fresh'
      ? `  ${ran} seed(s) aplicados (fresh)`
      : `  ${ran} seed(s) pendente(s) aplicados`,
  );
}

async function printSeedStatus(
  ds: DataSource,
  files: SeedFile[],
): Promise<void> {
  const applied = await loadAppliedChecksums(ds);
  let ok = 0;
  let pending = 0;
  let drift = 0;

  for (const file of files) {
    const sql = fs.readFileSync(file.filePath, 'utf8');
    const checksum = sha256Hex(sql);
    const prev = applied.get(file.version);
    if (!prev) {
      console.log(`  [ ] ${file.version}`);
      pending += 1;
    } else if (prev !== checksum) {
      console.log(`  [!] ${file.version} (checksum drift)`);
      drift += 1;
    } else {
      ok += 1;
    }
  }

  console.log(
    `\n  applied=${ok} pending=${pending} drift=${drift} total=${files.length}`,
  );
}
