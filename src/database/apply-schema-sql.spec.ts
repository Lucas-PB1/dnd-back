import fs from 'fs';
import os from 'os';
import path from 'path';
import {
  listSchemaSqlFiles,
  resolveSchemaDir,
} from './apply-schema-sql';

describe('apply-schema-sql', () => {
  it('resolveSchemaDir aponta para database/schema', () => {
    const dir = resolveSchemaDir();
    expect(dir.replace(/\\/g, '/')).toMatch(/database\/schema$/);
    expect(fs.existsSync(dir)).toBe(true);
  });

  it('lista SQL em ordem de path (pastas numéricas primeiro)', () => {
    const files = listSchemaSqlFiles();
    expect(files.length).toBeGreaterThan(10);
    const rel = files.map((f) =>
      path.relative(resolveSchemaDir(), f).replace(/\\/g, '/'),
    );
    expect(rel[0]).toBe('000_rpg_schema.sql');
    expect(rel.some((r) => r.startsWith('010_enums/'))).toBe(true);
    expect(rel.some((r) => r.startsWith('020_tables/'))).toBe(true);
    expect([...rel].sort()).toEqual(rel);
    const firstEnum = rel.findIndex((r) => r.startsWith('010_enums/'));
    const firstTable = rel.findIndex((r) => r.startsWith('020_tables/'));
    expect(firstEnum).toBeGreaterThan(0);
    expect(firstTable).toBeGreaterThan(firstEnum);
  });

  it('lista diretório temporário ordenado', () => {
    const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'torm-schema-'));
    try {
      fs.writeFileSync(path.join(tmp, '020_b.sql'), 'SELECT 1');
      fs.writeFileSync(path.join(tmp, '010_a.sql'), 'SELECT 1');
      const files = listSchemaSqlFiles(tmp).map((f) => path.basename(f));
      expect(files).toEqual(['010_a.sql', '020_b.sql']);
    } finally {
      fs.rmSync(tmp, { recursive: true, force: true });
    }
  });
});
