import { FIXTURE_CUNNING_STRIKE_EFFECTS } from './__fixtures__/mechanical-catalog.fixtures';
import { psiEnergyDiceSchedule } from './fighter-features';
import {
  availableCunningStrikeEffects,
  cunningStrikeSaveDc,
  hasSlipperyMind,
  rogueCombatNotes,
  sneakAttackDiceCount,
  sneakAttackDiceExpression,
  soulknifePsiDiceSchedule,
  validateCunningStrikeSelection,
} from './rogue-features';

describe('rogue features', () => {
  it('increases Sneak Attack by one die every odd Rogue level', () => {
    expect(sneakAttackDiceCount(1)).toBe(1);
    expect(sneakAttackDiceCount(2)).toBe(1);
    expect(sneakAttackDiceCount(3)).toBe(2);
    expect(sneakAttackDiceCount(20)).toBe(10);
  });

  it('uses d8 only for an arachnoid poisonous strike', () => {
    expect(
      sneakAttackDiceExpression({
        level: 9,
        subclassSlug: 'arachnoid-stalker',
      }),
    ).toBe('5d6');
    expect(
      sneakAttackDiceExpression({
        level: 9,
        subclassSlug: 'arachnoid-stalker',
        usePoisonousStrike: true,
      }),
    ).toBe('5d8');
    expect(
      sneakAttackDiceExpression({
        level: 9,
        subclassSlug: 'assassin',
        usePoisonousStrike: true,
      }),
    ).toBe('5d6');
  });

  it('defines every requested Cunning Strike cost and unlock', () => {
    expect(
      FIXTURE_CUNNING_STRIKE_EFFECTS.map(({ slug, cost, unlockLevel }) => ({
        slug,
        cost,
        unlockLevel,
      })),
    ).toEqual([
      { slug: 'poison', cost: 1, unlockLevel: 5 },
      { slug: 'withdraw', cost: 1, unlockLevel: 5 },
      { slug: 'trip', cost: 1, unlockLevel: 5 },
      { slug: 'hidden-attack', cost: 1, unlockLevel: 9 },
      { slug: 'daze', cost: 2, unlockLevel: 14 },
      { slug: 'knock-out', cost: 6, unlockLevel: 14 },
      { slug: 'obscure', cost: 3, unlockLevel: 14 },
      { slug: 'paralyze', cost: 4, unlockLevel: 17 },
    ]);
  });

  it('calculates the Cunning Strike save DC from Dexterity and proficiency', () => {
    expect(
      cunningStrikeSaveDc({
        dexterityModifier: 5,
        proficiencyBonus: 4,
      }),
    ).toBe(17);
  });

  it('offers only effects unlocked for the Rogue and subclass', () => {
    expect(
      availableCunningStrikeEffects(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 5,
      }).map((effect) => effect.slug),
    ).toEqual(['poison', 'withdraw', 'trip']);
    expect(
      availableCunningStrikeEffects(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 17,
        subclassSlug: 'arachnoid-stalker',
      }).map((effect) => effect.slug),
    ).toContain('paralyze');
    expect(
      availableCunningStrikeEffects(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 17,
        subclassSlug: 'assassin',
      }).map((effect) => effect.slug),
    ).not.toContain('paralyze');
  });

  it('allows two paid Cunning Strike effects from level 11 onward', () => {
    expect(
      validateCunningStrikeSelection(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 14,
        effectSlugs: ['daze', 'obscure'],
      }),
    ).toMatchObject({
      diceCost: 5,
      remainingSneakAttackDice: 2,
    });
  });

  it('rejects two Cunning Strike effects before level 11', () => {
    expect(() =>
      validateCunningStrikeSelection(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 10,
        effectSlugs: ['poison', 'withdraw'],
      }),
    ).toThrow(/at most 1/);
  });

  it('rejects effects that cost more than the available Sneak Attack dice', () => {
    expect(() =>
      validateCunningStrikeSelection(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 14,
        effectSlugs: ['knock-out', 'obscure'],
      }),
    ).toThrow(/costs 9 dice.*only 7/);
  });

  it('restricts Paralyze to level 17 arachnoid stalkers', () => {
    expect(() =>
      validateCunningStrikeSelection(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 17,
        subclassSlug: 'assassin',
        effectSlugs: ['paralyze'],
      }),
    ).toThrow(/arachnoid-stalker/);
    expect(
      validateCunningStrikeSelection(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 17,
        subclassSlug: 'arachnoid-stalker',
        effectSlugs: ['paralyze'],
      }).diceCost,
    ).toBe(4);
  });

  it('uses the Psi Warrior dice schedule for Soulknife', () => {
    for (const level of [3, 5, 9, 11, 13, 17]) {
      expect(soulknifePsiDiceSchedule(level)).toEqual(
        psiEnergyDiceSchedule(level),
      );
    }
  });

  it('unlocks Slippery Mind at level 15', () => {
    expect(hasSlipperyMind(14)).toBe(false);
    expect(hasSlipperyMind(15)).toBe(true);
  });

  it.each([
    ['soulknife', 'Adaga Espiritual'],
    ['assassin', 'Assassinar'],
    ['thief', 'Ladrão'],
    ['arcane-trickster', 'Trapaceiro Arcano'],
    ['arachnoid-stalker', 'Golpe Venenoso'],
  ])('adds base and %s subclass combat notes', (subclassSlug, expectedNote) => {
    const notes = rogueCombatNotes({
      classSlug: 'rogue',
      subclassSlug,
      level: 17,
    });

    expect(notes.some((note) => note.includes('Ataque Furtivo: 9d6'))).toBe(
      true,
    );
    expect(notes.some((note) => note.includes(expectedNote))).toBe(true);
  });

  it('does not emit Rogue notes for another class', () => {
    expect(
      rogueCombatNotes({
        classSlug: 'fighter',
        subclassSlug: 'soulknife',
        level: 17,
      }),
    ).toEqual([]);
  });
});
