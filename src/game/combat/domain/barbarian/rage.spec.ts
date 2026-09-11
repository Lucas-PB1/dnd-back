import {
  appliesRageDamageBonus,
  brutalStrikeDice,
  divineFuryExtraDice,
  fastMovementBonusMeters,
  hasDivineFury,
  isBarbarianClass,
  rageDamageBonus,
  zealotHealingDiceCount,
} from './rage';
import { fixtureSchedulesFor } from '../feature-schedule.fixtures';

describe('barbarian-rage', () => {
  const barbarianBands = fixtureSchedulesFor('barbarian');
  const zealotBands = fixtureSchedulesFor('barbarian', 'zealot');

  it('resolves rage damage by level band', () => {
    expect(rageDamageBonus(1, barbarianBands)).toBe(2);
    expect(rageDamageBonus(8, barbarianBands)).toBe(2);
    expect(rageDamageBonus(9, barbarianBands)).toBe(3);
    expect(rageDamageBonus(15, barbarianBands)).toBe(3);
    expect(rageDamageBonus(16, barbarianBands)).toBe(4);
    expect(rageDamageBonus(20, barbarianBands)).toBe(4);
  });

  it('applies rage only to barbarian melee Strength while active', () => {
    expect(
      appliesRageDamageBonus({
        classSlug: 'barbarian',
        level: 5,
        rageActive: true,
        mode: 'melee',
        abilitySlug: 'forca',
        featureSchedules: barbarianBands,
      }),
    ).toBe(2);
    expect(
      appliesRageDamageBonus({
        classSlug: 'barbarian',
        level: 5,
        rageActive: false,
        mode: 'melee',
        abilitySlug: 'forca',
        featureSchedules: barbarianBands,
      }),
    ).toBe(0);
    expect(
      appliesRageDamageBonus({
        classSlug: 'fighter',
        level: 5,
        rageActive: true,
        mode: 'melee',
        abilitySlug: 'forca',
        featureSchedules: [],
      }),
    ).toBe(0);
    expect(
      appliesRageDamageBonus({
        classSlug: 'barbarian',
        level: 5,
        rageActive: true,
        mode: 'ranged',
        abilitySlug: 'forca',
        featureSchedules: barbarianBands,
      }),
    ).toBe(0);
  });

  it('resolves brutal strike dice', () => {
    expect(brutalStrikeDice(8, barbarianBands)).toBeNull();
    expect(brutalStrikeDice(9, barbarianBands)).toBe('1d10');
    expect(brutalStrikeDice(16, barbarianBands)).toBe('1d10');
    expect(brutalStrikeDice(17, barbarianBands)).toBe('2d10');
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
    expect(zealotHealingDiceCount(3, zealotBands)).toBe(4);
    expect(zealotHealingDiceCount(6, zealotBands)).toBe(5);
    expect(zealotHealingDiceCount(12, zealotBands)).toBe(6);
    expect(zealotHealingDiceCount(17, zealotBands)).toBe(7);
  });

  it('recognizes barbarian slug', () => {
    expect(isBarbarianClass('barbarian')).toBe(true);
    expect(isBarbarianClass('gunslinger')).toBe(false);
  });
});
