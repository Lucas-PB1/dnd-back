/**
 * Specs do domínio Guerreiro (PHB 2024).
 */
import {
  attacksPerAction,
  championCritThreshold,
  indomitableMaxUses,
  isFighterClass,
  psiEnergyDiceCount,
  psiEnergyDieFaces,
  resolveFighterAttackCritThreshold,
  secondWindHealDice,
  superiorityDiceCount,
  superiorityDieFaces,
} from './features';
import { fixtureSchedulesFor } from '../feature-schedule.fixtures';

describe('fighter-features', () => {
  const fighterBands = fixtureSchedulesFor('fighter');
  const battleMasterBands = fixtureSchedulesFor('fighter', 'battle-master');
  const psiWarriorBands = fixtureSchedulesFor('fighter', 'psi-warrior');
  const championBands = fixtureSchedulesFor('fighter', 'champion');

  it('resolves attacks per action by level', () => {
    expect(attacksPerAction(1, fighterBands)).toBe(1);
    expect(attacksPerAction(5, fighterBands)).toBe(2);
    expect(attacksPerAction(11, fighterBands)).toBe(3);
    expect(attacksPerAction(20, fighterBands)).toBe(4);
  });

  it('builds second wind heal dice', () => {
    expect(secondWindHealDice(5)).toBe('1d10+5');
  });

  it('resolves indomitable uses', () => {
    expect(indomitableMaxUses(8, fighterBands)).toBe(0);
    expect(indomitableMaxUses(9, fighterBands)).toBe(1);
    expect(indomitableMaxUses(13, fighterBands)).toBe(2);
    expect(indomitableMaxUses(17, fighterBands)).toBe(3);
  });

  it('resolves superiority dice count and faces', () => {
    expect(superiorityDiceCount(3, battleMasterBands)).toBe(4);
    expect(superiorityDiceCount(7, battleMasterBands)).toBe(5);
    expect(superiorityDiceCount(15, battleMasterBands)).toBe(6);
    expect(superiorityDieFaces(3, battleMasterBands)).toBe(8);
    expect(superiorityDieFaces(10, battleMasterBands)).toBe(10);
    expect(superiorityDieFaces(18, battleMasterBands)).toBe(12);
  });

  it('resolves psi energy dice', () => {
    expect(psiEnergyDiceCount(3, psiWarriorBands)).toBe(4);
    expect(psiEnergyDieFaces(3, psiWarriorBands)).toBe(6);
    expect(psiEnergyDiceCount(5, psiWarriorBands)).toBe(6);
    expect(psiEnergyDieFaces(5, psiWarriorBands)).toBe(8);
    expect(psiEnergyDiceCount(17, psiWarriorBands)).toBe(12);
    expect(psiEnergyDieFaces(17, psiWarriorBands)).toBe(12);
  });

  it('resolves champion crit thresholds', () => {
    expect(championCritThreshold(3, championBands)).toBe(19);
    expect(championCritThreshold(15, championBands)).toBe(18);
    expect(
      resolveFighterAttackCritThreshold({
        classSlug: 'fighter',
        subclassSlug: 'champion',
        level: 15,
        featureSchedules: championBands,
      }),
    ).toBe(18);
    expect(
      resolveFighterAttackCritThreshold({
        classSlug: 'fighter',
        subclassSlug: 'battle-master',
        level: 15,
        featureSchedules: battleMasterBands,
      }),
    ).toBe(20);
  });

  it('recognizes fighter class', () => {
    expect(isFighterClass('fighter')).toBe(true);
    expect(isFighterClass('rogue')).toBe(false);
  });
});
