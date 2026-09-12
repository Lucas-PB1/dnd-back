import { FIXTURE_CUNNING_STRIKE_EFFECTS } from './__fixtures__/mechanical-catalog';
import { psiEnergyDiceSchedule } from './fighter';
import {
  availableCunningStrikeEffects,
  cunningStrikeSaveDc,
  hasSlipperyMind,
  sneakAttackDiceCount,
  sneakAttackDiceExpression,
  soulknifePsiDiceSchedule,
  validateCunningStrikeSelection,
} from './rogue';
import { fixtureSchedulesFor } from './feature-schedule.fixtures';

describe('rogue features', () => {
  const rogueBands = fixtureSchedulesFor('rogue');

  it('increases Sneak Attack by one die every odd Rogue level', () => {
    expect(sneakAttackDiceCount(1, rogueBands)).toBe(1);
    expect(sneakAttackDiceCount(2, rogueBands)).toBe(1);
    expect(sneakAttackDiceCount(3, rogueBands)).toBe(2);
    expect(sneakAttackDiceCount(20, rogueBands)).toBe(10);
  });

  it('uses d8 only for an arachnoid poisonous strike', () => {
    expect(
      sneakAttackDiceExpression({
        level: 9,
        subclassSlug: 'arachnoid-stalker',
        featureSchedules: rogueBands,
      }),
    ).toBe('5d6');
    expect(
      sneakAttackDiceExpression({
        level: 9,
        subclassSlug: 'arachnoid-stalker',
        usePoisonousStrike: true,
        featureSchedules: rogueBands,
      }),
    ).toBe('5d8');
    expect(
      sneakAttackDiceExpression({
        level: 9,
        subclassSlug: 'assassin',
        usePoisonousStrike: true,
        featureSchedules: rogueBands,
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
        featureSchedules: rogueBands,
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
        featureSchedules: rogueBands,
      }),
    ).toThrow(/at most 1/);
  });

  it('rejects effects that cost more than the available Sneak Attack dice', () => {
    expect(() =>
      validateCunningStrikeSelection(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 14,
        effectSlugs: ['knock-out', 'obscure'],
        featureSchedules: rogueBands,
      }),
    ).toThrow(/costs 9 dice.*only 7/);
  });

  it('restricts Paralyze to level 17 arachnoid stalkers', () => {
    expect(() =>
      validateCunningStrikeSelection(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 17,
        subclassSlug: 'assassin',
        effectSlugs: ['paralyze'],
        featureSchedules: rogueBands,
      }),
    ).toThrow(/arachnoid-stalker/);
    expect(
      validateCunningStrikeSelection(FIXTURE_CUNNING_STRIKE_EFFECTS, {
        level: 17,
        subclassSlug: 'arachnoid-stalker',
        effectSlugs: ['paralyze'],
        featureSchedules: rogueBands,
      }).diceCost,
    ).toBe(4);
  });

  it('uses the Psi Warrior dice schedule for Soulknife', () => {
    const soulknifeBands = fixtureSchedulesFor('rogue', 'soulknife');
    for (const level of [3, 5, 9, 11, 13, 17]) {
      expect(soulknifePsiDiceSchedule(level, soulknifeBands)).toEqual(
        psiEnergyDiceSchedule(level, soulknifeBands),
      );
    }
  });

  it('unlocks Slippery Mind at level 15', () => {
    expect(hasSlipperyMind(14, 15)).toBe(false);
    expect(hasSlipperyMind(15, 15)).toBe(true);
  });
});
