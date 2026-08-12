import { filterSubclassGrantedSpellRows } from './filter-subclass-granted-spells';

describe('filterSubclassGrantedSpellRows', () => {
  const rows = [
    { unlockLevel: 3, spellSlug: 'maos-flamejantes', terrainSlug: 'arid' },
    { unlockLevel: 3, spellSlug: 'nevoa-obscurecente', terrainSlug: 'polar' },
    { unlockLevel: 3, spellSlug: 'marca-do-predador', terrainSlug: null },
  ];

  it('keeps null-terrain rows for any subclass', () => {
    expect(
      filterSubclassGrantedSpellRows(rows, 'moon', []),
    ).toEqual([rows[2]]);
  });

  it('filters land rows by selected terrain and keeps shared rows', () => {
    expect(
      filterSubclassGrantedSpellRows(rows, 'land', [
        { optionKey: 'circleTerrain', valueId: 'polar' },
      ]),
    ).toEqual([rows[1], rows[2]]);
  });

  it('returns only shared rows when land has no terrain pick', () => {
    expect(filterSubclassGrantedSpellRows(rows, 'land', [])).toEqual([rows[2]]);
  });
});
