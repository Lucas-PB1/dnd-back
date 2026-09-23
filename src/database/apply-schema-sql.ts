import fs from 'fs';
import path from 'path';
import { QueryRunner } from 'typeorm';

export function resolveSchemaDir(): string {
  return path.resolve(__dirname, '../../database/schema');
}

export function listSchemaSqlFiles(schemaDir = resolveSchemaDir()): string[] {
  if (!fs.existsSync(schemaDir)) {
    throw new Error(`Schema declarative ausente: ${schemaDir}`);
  }

  const files: string[] = [];

  const walk = (dir: string) => {
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      const fullPath = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        walk(fullPath);
      } else if (entry.isFile() && entry.name.endsWith('.sql')) {
        files.push(fullPath);
      }
    }
  };

  walk(schemaDir);
  files.sort();
  return files;
}

export async function assertSchemaEmptyForBaseline(
  queryRunner: QueryRunner,
): Promise<void> {
  const rows: Array<{ has_catalog: boolean | string }> =
    await queryRunner.query(`
      SELECT EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'rpg' AND table_name = 'phb_edition'
      ) AS has_catalog
    `);

  const flag = rows[0]?.has_catalog;
  if (flag === true || flag === 't') {
    throw new Error(
      'Baseline pendente, mas o schema rpg já tem catálogo. Rode: npm run db:reset && npm run db:migrate',
    );
  }
}

export async function applySchemaSqlFiles(
  query: (sql: string) => Promise<unknown>,
  schemaDir = resolveSchemaDir(),
): Promise<number> {
  const files = listSchemaSqlFiles(schemaDir);
  let applied = 0;

  for (const filePath of files) {
    const sql = fs.readFileSync(filePath, 'utf8').trim();
    if (!sql) continue;
    await query(sql);
    applied += 1;
  }

  return applied;
}
