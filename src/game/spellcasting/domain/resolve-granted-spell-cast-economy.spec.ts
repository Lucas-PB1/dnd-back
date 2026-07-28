import {
  consumeGrantedFreeCast,
  freeCastsRemaining,
  resolveGrantedSpellCastEconomy,
} from './resolve-granted-spell-cast-economy';
import type { SpeciesGrantedSpellRow } from './granted-spells/types';

const SPECIES_CATALOG: SpeciesGrantedSpellRow[] = [
  {
    speciesSlug: 'elf',
    choiceKind: 'elf_lineage',
    choiceSlug: 'drow',
    unlockLevel: 1,
    spellSlug: 'luzes-dancantes',
  },
  {
    speciesSlug: 'elf',
    choiceKind: 'elf_lineage',
    choiceSlug: 'drow',
    unlockLevel: 3,
    spellSlug: 'fogo-das-fadas',
  },
];

describe('resolveGrantedSpellCastEconomy', () => {
  it('marks class spells as slot_only', () => {
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'fireball',
        source: 'class',
      }),
    ).toBe('slot_only');
  });

  it('marks feat cantrips at_will and first-level once_per_long_rest', () => {
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'fire-bolt',
        source: 'feat',
        featOptions: [
          { featSlug: 'magic-initiate', optionKey: 'cantrip1', valueId: 'fire-bolt' },
        ],
      }),
    ).toBe('at_will');
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'cure-wounds',
        source: 'feat',
        featOptions: [
          {
            featSlug: 'magic-initiate',
            optionKey: 'firstLevelSpell',
            valueId: 'cure-wounds',
          },
        ],
      }),
    ).toBe('once_per_long_rest');
  });

  it('marks species L1 at_will and L3+ once_per_long_rest', () => {
    const choices = [{ choiceKind: 'elf_lineage', choiceSlug: 'drow' }];
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'luzes-dancantes',
        source: 'species',
        speciesSlug: 'elf',
        speciesChoices: choices,
        speciesCatalog: SPECIES_CATALOG,
      }),
    ).toBe('at_will');
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'fogo-das-fadas',
        source: 'species',
        speciesSlug: 'elf',
        speciesChoices: choices,
        speciesCatalog: SPECIES_CATALOG,
      }),
    ).toBe('once_per_long_rest');
  });
});

describe('freeCast helpers', () => {
  it('tracks remaining and consume', () => {
    expect(freeCastsRemaining('at_will', 'x', {})).toBeNull();
    expect(freeCastsRemaining('slot_only', 'x', {})).toBe(0);
    expect(freeCastsRemaining('once_per_long_rest', 'x', {})).toBe(1);
    expect(freeCastsRemaining('once_per_long_rest', 'x', { x: 1 })).toBe(0);
    expect(consumeGrantedFreeCast({ x: 0 }, 'x')).toEqual({ x: 1 });
  });
});
