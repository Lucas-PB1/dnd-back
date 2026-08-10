import {
  appliesRageDamageBonus,
  barbarianCombatNotes,
  brutalStrikeDice,
  divineFuryExtraDice,
  fastMovementBonusMeters,
  hasDivineFury,
  isBarbarianClass,
  rageDamageBonus,
  zealotHealingDiceCount,
} from './rage';

describe('barbarian-rage', () => {
  it('resolves rage damage by level band', () => {
    expect(rageDamageBonus(1)).toBe(2);
    expect(rageDamageBonus(8)).toBe(2);
    expect(rageDamageBonus(9)).toBe(3);
    expect(rageDamageBonus(15)).toBe(3);
    expect(rageDamageBonus(16)).toBe(4);
    expect(rageDamageBonus(20)).toBe(4);
  });

  it('applies rage only to barbarian melee Strength while active', () => {
    expect(
      appliesRageDamageBonus({
        classSlug: 'barbarian',
        level: 5,
        rageActive: true,
        mode: 'melee',
        abilitySlug: 'forca',
      }),
    ).toBe(2);
    expect(
      appliesRageDamageBonus({
        classSlug: 'barbarian',
        level: 5,
        rageActive: false,
        mode: 'melee',
        abilitySlug: 'forca',
      }),
    ).toBe(0);
    expect(
      appliesRageDamageBonus({
        classSlug: 'fighter',
        level: 5,
        rageActive: true,
        mode: 'melee',
        abilitySlug: 'forca',
      }),
    ).toBe(0);
    expect(
      appliesRageDamageBonus({
        classSlug: 'barbarian',
        level: 5,
        rageActive: true,
        mode: 'ranged',
        abilitySlug: 'forca',
      }),
    ).toBe(0);
  });

  it('resolves brutal strike dice', () => {
    expect(brutalStrikeDice(8)).toBeNull();
    expect(brutalStrikeDice(9)).toBe('1d10');
    expect(brutalStrikeDice(16)).toBe('1d10');
    expect(brutalStrikeDice(17)).toBe('2d10');
  });

  it('gives +3 m fast movement from level 5', () => {
    expect(fastMovementBonusMeters({ classSlug: 'barbarian', level: 4 })).toBe(
      0,
    );
    expect(fastMovementBonusMeters({ classSlug: 'barbarian', level: 5 })).toBe(
      3,
    );
  });

  it('builds divine fury and zealot healing schedule', () => {
    expect(hasDivineFury({ subclassSlug: 'zealot', level: 3 })).toBe(true);
    expect(divineFuryExtraDice(5)).toBe('1d6+2');
    expect(zealotHealingDiceCount(3)).toBe(4);
    expect(zealotHealingDiceCount(6)).toBe(5);
    expect(zealotHealingDiceCount(12)).toBe(6);
    expect(zealotHealingDiceCount(17)).toBe(7);
  });

  it('recognizes barbarian slug', () => {
    expect(isBarbarianClass('barbarian')).toBe(true);
    expect(isBarbarianClass('gunslinger')).toBe(false);
  });

  it('includes subclass combat notes', () => {
    const notes = barbarianCombatNotes({
      classSlug: 'barbarian',
      subclassSlug: 'berserker',
      level: 14,
    });
    expect(notes.some((n) => n.includes('Frenesi'))).toBe(true);
    expect(notes.some((n) => n.includes('Presença Intimidante'))).toBe(true);
  });
});
