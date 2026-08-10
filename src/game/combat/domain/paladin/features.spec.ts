import {
  auraOfProtectionBonus,
  auraRangeMeters,
  divineSmiteDice,
  hasAuraOfProtection,
  isPaladinClass,
  paladinAttacksPerAction,
  paladinCombatNotes,
  paladinSavingThrowAuraBonus,
  radiantStrikesDie,
} from './features';

describe('paladin-features', () => {
  it('identifies the paladin class', () => {
    expect(isPaladinClass('paladin')).toBe(true);
    expect(isPaladinClass('cleric')).toBe(false);
    expect(isPaladinClass(null)).toBe(false);
  });

  describe('divineSmiteDice', () => {
    it('rolls 2d8 with a 1st-level slot', () => {
      expect(divineSmiteDice({ slotLevel: 1 })).toBe('2d8');
    });

    it('adds 1d8 per slot level above the 1st', () => {
      expect(divineSmiteDice({ slotLevel: 2 })).toBe('3d8');
      expect(divineSmiteDice({ slotLevel: 5 })).toBe('6d8');
    });

    it('adds 1d8 against undead or fiends', () => {
      expect(divineSmiteDice({ slotLevel: 1, vsUndeadOrFiend: true })).toBe(
        '3d8',
      );
      expect(divineSmiteDice({ slotLevel: 3, vsUndeadOrFiend: true })).toBe(
        '5d8',
      );
    });
  });

  describe('radiantStrikesDie', () => {
    it('grants 1d8 only at level 11+', () => {
      expect(radiantStrikesDie(10)).toBeNull();
      expect(radiantStrikesDie(11)).toBe('1d8');
    });
  });

  describe('Aura of Protection', () => {
    it('unlocks at level 6', () => {
      expect(hasAuraOfProtection(5)).toBe(false);
      expect(hasAuraOfProtection(6)).toBe(true);
    });

    it('uses the Charisma modifier with a minimum of +1', () => {
      expect(auraOfProtectionBonus(4)).toBe(4);
      expect(auraOfProtectionBonus(0)).toBe(1);
      expect(auraOfProtectionBonus(-2)).toBe(1);
    });

    it('exposes sheet/roll aura bonus only for paladin 6+', () => {
      expect(
        paladinSavingThrowAuraBonus({
          classSlug: 'paladin',
          level: 6,
          charismaModifier: 3,
        }),
      ).toBe(3);
      expect(
        paladinSavingThrowAuraBonus({
          classSlug: 'paladin',
          level: 5,
          charismaModifier: 3,
        }),
      ).toBe(0);
      expect(
        paladinSavingThrowAuraBonus({
          classSlug: 'fighter',
          level: 10,
          charismaModifier: 3,
        }),
      ).toBe(0);
    });

    it('expands the aura range at level 18', () => {
      expect(auraRangeMeters(6)).toBe(3);
      expect(auraRangeMeters(18)).toBe(9);
    });
  });

  it('grants Extra Attack at level 5', () => {
    expect(paladinAttacksPerAction(4)).toBe(1);
    expect(paladinAttacksPerAction(5)).toBe(2);
  });

  describe('paladinCombatNotes', () => {
    it('returns nothing for non-paladins', () => {
      expect(paladinCombatNotes({ classSlug: 'fighter', level: 6 })).toEqual([]);
    });

    it('lists core notes by level', () => {
      const notes = paladinCombatNotes({ classSlug: 'paladin', level: 11 });
      expect(notes.join(' ')).toContain('Mãos Consagradas');
      expect(notes.join(' ')).toContain('Destruição Divina');
      expect(notes.join(' ')).toContain('Aura de Proteção');
      expect(notes.join(' ')).toContain('Golpes Radiantes');
    });

    it('adds subclass notes', () => {
      const notes = paladinCombatNotes({
        classSlug: 'paladin',
        subclassSlug: 'vengeance',
        level: 3,
      });
      expect(notes.join(' ')).toContain('Voto de Inimizade');
    });
  });
});
