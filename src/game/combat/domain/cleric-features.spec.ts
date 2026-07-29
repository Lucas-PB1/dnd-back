import {
  clericCombatNotes,
  destroyUndeadDice,
  divineSparkDice,
  divineStrikeDice,
  isClericClass,
} from './cleric-features';

describe('cleric-features', () => {
  it('identifies only the Cleric class', () => {
    expect(isClericClass('cleric')).toBe(true);
    expect(isClericClass('paladin')).toBe(false);
    expect(isClericClass(null)).toBe(false);
  });

  it('scales Divine Spark at the class thresholds', () => {
    expect(divineSparkDice(2)).toBe('1d8');
    expect(divineSparkDice(7)).toBe('2d8');
    expect(divineSparkDice(13)).toBe('3d8');
    expect(divineSparkDice(18)).toBe('4d8');
  });

  it('uses at least one die for Sear Undead', () => {
    expect(destroyUndeadDice(8)).toBe('1d8');
    expect(destroyUndeadDice(18)).toBe('4d8');
  });

  it('scales Divine Strike at levels 7 and 14', () => {
    expect(divineStrikeDice(6)).toBeNull();
    expect(divineStrikeDice(7)).toBe('1d8');
    expect(divineStrikeDice(14)).toBe('2d8');
  });

  it('returns core and subclass notes available at the current level', () => {
    const notes = clericCombatNotes({
      classSlug: 'cleric',
      subclassSlug: 'war',
      level: 6,
    }).join(' ');

    expect(notes).toContain('Canalizar Divindade');
    expect(notes).toContain('Fulminar Mortos-Vivos');
    expect(notes).toContain('Sacerdote da Guerra');
    expect(notes).toContain('Bênção do Deus da Guerra');
    expect(notes).not.toContain('Intervenção Divina');
  });

  it('returns no notes for another class', () => {
    expect(clericCombatNotes({ classSlug: 'wizard', level: 20 })).toEqual([]);
  });
});
