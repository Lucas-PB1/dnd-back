import { sha256Hex } from './seed-checksum';
import { applyFromFilter, SeedFile } from './seed-order';

describe('seed-checksum', () => {
  it('é estável para o mesmo conteúdo', () => {
    expect(sha256Hex('abc')).toBe(sha256Hex('abc'));
    expect(sha256Hex('abc')).not.toBe(sha256Hex('abd'));
  });
});

describe('applyFromFilter', () => {
  const files: SeedFile[] = [
    { version: 'a/one.sql', filePath: '/x/a/one.sql' },
    { version: 'b/two.sql', filePath: '/x/b/two.sql' },
    { version: 'c/three.sql', filePath: '/x/c/three.sql' },
  ];

  it('sem --from devolve a lista intacta', () => {
    expect(applyFromFilter(files, null)).toEqual(files);
  });

  it('corta a partir do needle', () => {
    expect(applyFromFilter(files, 'b/two.sql').map((f) => f.version)).toEqual([
      'b/two.sql',
      'c/three.sql',
    ]);
  });

  it('falha se --from não existir', () => {
    expect(() => applyFromFilter(files, 'missing.sql')).toThrow(/--from/);
  });
});
