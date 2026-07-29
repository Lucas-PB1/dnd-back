/**
 * Specs do domínio Guerreiro (PHB 2024).
 */
import {
  attacksPerAction,
  championCritThreshold,
  fighterCombatNotes,
  indomitableMaxUses,
  isFighterClass,
  psiEnergyDiceCount,
  psiEnergyDieFaces,
  resolveFighterAttackCritThreshold,
  secondWindHealDice,
  superiorityDiceCount,
  superiorityDieFaces,
} from './fighter-features';

describe('fighter-features', () => {
  it('resolves attacks per action by level', () => {
    expect(attacksPerAction(1)).toBe(1);
    expect(attacksPerAction(5)).toBe(2);
    expect(attacksPerAction(11)).toBe(3);
    expect(attacksPerAction(20)).toBe(4);
  });

  it('builds second wind heal dice', () => {
    expect(secondWindHealDice(5)).toBe('1d10+5');
  });

  it('resolves indomitable uses', () => {
    expect(indomitableMaxUses(8)).toBe(0);
    expect(indomitableMaxUses(9)).toBe(1);
    expect(indomitableMaxUses(13)).toBe(2);
    expect(indomitableMaxUses(17)).toBe(3);
  });

  it('resolves superiority dice count and faces', () => {
    expect(superiorityDiceCount(3)).toBe(4);
    expect(superiorityDiceCount(7)).toBe(5);
    expect(superiorityDiceCount(15)).toBe(6);
    expect(superiorityDieFaces(3)).toBe(8);
    expect(superiorityDieFaces(10)).toBe(10);
    expect(superiorityDieFaces(18)).toBe(12);
  });

  it('resolves psi energy dice', () => {
    expect(psiEnergyDiceCount(3)).toBe(4);
    expect(psiEnergyDieFaces(3)).toBe(6);
    expect(psiEnergyDiceCount(5)).toBe(6);
    expect(psiEnergyDieFaces(5)).toBe(8);
    expect(psiEnergyDiceCount(17)).toBe(12);
    expect(psiEnergyDieFaces(17)).toBe(12);
  });

  it('resolves champion crit thresholds', () => {
    expect(championCritThreshold(3)).toBe(19);
    expect(championCritThreshold(15)).toBe(18);
    expect(
      resolveFighterAttackCritThreshold({
        classSlug: 'fighter',
        subclassSlug: 'champion',
        level: 15,
      }),
    ).toBe(18);
    expect(
      resolveFighterAttackCritThreshold({
        classSlug: 'fighter',
        subclassSlug: 'battle-master',
        level: 15,
      }),
    ).toBe(20);
  });

  it('emits combat notes for fighter', () => {
    expect(isFighterClass('fighter')).toBe(true);
    const notes = fighterCombatNotes({
      classSlug: 'fighter',
      subclassSlug: 'champion',
      level: 15,
    });
    expect(notes.some((note) => note.includes('Ataques por ação: 3'))).toBe(
      true,
    );
    expect(notes.some((note) => note.includes('crítico 18–20'))).toBe(true);
  });
});
