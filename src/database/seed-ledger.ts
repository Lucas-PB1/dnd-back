import { DataSource } from 'typeorm';

export const SEED_LEDGER_DDL = `
CREATE TABLE IF NOT EXISTS rpg.seed_migration (
  version TEXT PRIMARY KEY,
  checksum TEXT NOT NULL,
  applied_at TIMESTAMPTZ NOT NULL DEFAULT now()
)
`;

export async function ensureSeedLedger(ds: DataSource): Promise<void> {
  await ds.query(SEED_LEDGER_DDL);
}

export async function loadAppliedChecksums(
  ds: DataSource,
): Promise<Map<string, string>> {
  const rows: Array<{ version: string; checksum: string }> = await ds.query(
    `SELECT version, checksum FROM rpg.seed_migration`,
  );
  return new Map(rows.map((r) => [r.version, r.checksum]));
}

export async function upsertSeedLedger(
  ds: DataSource,
  version: string,
  checksum: string,
): Promise<void> {
  await ds.query(
    `
    INSERT INTO rpg.seed_migration (version, checksum)
    VALUES ($1, $2)
    ON CONFLICT (version) DO UPDATE
      SET checksum = EXCLUDED.checksum,
          applied_at = now()
    `,
    [version, checksum],
  );
}

export async function clearSeedLedger(ds: DataSource): Promise<void> {
  await ds.query(`TRUNCATE TABLE rpg.seed_migration`);
}
