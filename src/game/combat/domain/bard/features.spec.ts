import {
  bardicInspirationDie,
  bardicInspirationMaxUses,
  bardicInspirationRestRecovery,
  bardCombatNotes,
  isBardClass,
} from './features';

describe('bard-features', () => {
  it('identifies bard class correctly', () => {
    expect(isBardClass('bard')).toBe(true);
    expect(isBardClass('fighter')).toBe(false);
    expect(isBardClass(null)).toBe(false);
  });

  it('computes correct bardic inspiration die per level', () => {
    expect(bardicInspirationDie(1)).toBe('d6');
    expect(bardicInspirationDie(4)).toBe('d6');
    expect(bardicInspirationDie(5)).toBe('d8');
    expect(bardicInspirationDie(9)).toBe('d8');
    expect(bardicInspirationDie(10)).toBe('d10');
    expect(bardicInspirationDie(14)).toBe('d10');
    expect(bardicInspirationDie(15)).toBe('d12');
    expect(bardicInspirationDie(20)).toBe('d12');
  });

  it('computes max inspiration uses based on charisma score (min 1)', () => {
    expect(bardicInspirationMaxUses(16)).toBe(3); // mod +3
    expect(bardicInspirationMaxUses(20)).toBe(5); // mod +5
    expect(bardicInspirationMaxUses(8)).toBe(1);  // mod -1 -> min 1
  });

  it('computes rest recovery rule (short vs long rest)', () => {
    expect(bardicInspirationRestRecovery(1)).toBe('long');
    expect(bardicInspirationRestRecovery(4)).toBe('long');
    expect(bardicInspirationRestRecovery(5)).toBe('short');
    expect(bardicInspirationRestRecovery(10)).toBe('short');
  });

  it('generates combat notes for base bard and subclasses', () => {
    const baseNotes = bardCombatNotes({ classSlug: 'bard', level: 5 });
    expect(baseNotes.some((n) => n.includes('Inspiração Bárdica (d8)'))).toBe(true);
    expect(baseNotes.some((n) => n.includes('Fonte de Inspiração'))).toBe(true);

    const loreNotes = bardCombatNotes({ classSlug: 'bard', subclassSlug: 'lore', level: 3 });
    expect(loreNotes.some((n) => n.includes('Palavras Cortantes'))).toBe(true);

    const glamourNotes = bardCombatNotes({ classSlug: 'bard', subclassSlug: 'glamour', level: 3 });
    expect(glamourNotes.some((n) => n.includes('Desempenho Cativante'))).toBe(true);
  });
});
