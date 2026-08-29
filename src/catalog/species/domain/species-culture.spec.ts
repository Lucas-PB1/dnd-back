import {
  resolveDwarfCulture,
  resolveTraitPackageSlug,
} from './species-culture';

describe('species-culture', () => {
  it('resolves dwarf culture from species choices', () => {
    expect(
      resolveDwarfCulture('dwarf', [
        { choiceKind: 'dwarf_culture', choiceSlug: 'baugsmidr' },
      ]),
    ).toBe('baugsmidr');
    expect(resolveDwarfCulture('dwarf', [])).toBeNull();
    expect(resolveDwarfCulture('elf', [])).toBeNull();
  });

  it('resolves trait package from dwarf culture choice', () => {
    expect(
      resolveTraitPackageSlug('dwarf', [
        { choiceKind: 'dwarf_culture', choiceSlug: 'fjord' },
      ]),
    ).toBe('fjord-dwarf');
    expect(resolveTraitPackageSlug('dwarf', [])).toBe('dwarf');
    expect(resolveTraitPackageSlug('elf', [])).toBe('elf');
  });
});
