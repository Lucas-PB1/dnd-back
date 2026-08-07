import {
  abjurerArcaneWardHp,
  arcaneRecoveryMaxSlotLevels,
  isWizardClass,
  portentDiceCount,
  wizardCombatNotes,
} from './features';

describe('wizard-features', () => {
  it('identifies wizard class correctly', () => {
    expect(isWizardClass('wizard')).toBe(true);
    expect(isWizardClass('sorcerer')).toBe(false);
  });

  it('computes arcane recovery max slot level sum', () => {
    expect(arcaneRecoveryMaxSlotLevels(1)).toBe(1);
    expect(arcaneRecoveryMaxSlotLevels(3)).toBe(2);
    expect(arcaneRecoveryMaxSlotLevels(5)).toBe(3);
    expect(arcaneRecoveryMaxSlotLevels(20)).toBe(10);
  });

  it('computes abjurer arcane ward hp', () => {
    expect(abjurerArcaneWardHp(3, 3)).toBe(9);
    expect(abjurerArcaneWardHp(10, 4)).toBe(24);
  });

  it('computes portent dice count', () => {
    expect(portentDiceCount(3)).toBe(2);
    expect(portentDiceCount(14)).toBe(3);
  });

  it('generates combat notes for base wizard and subclasses', () => {
    const notes = wizardCombatNotes({ classSlug: 'wizard', level: 5 });
    expect(notes.some((n) => n.includes('Recuperação Arcana'))).toBe(true);

    const abjurerNotes = wizardCombatNotes({ classSlug: 'wizard', subclassSlug: 'abjurer', level: 3 });
    expect(abjurerNotes.some((n) => n.includes('Proteção Arcana'))).toBe(true);

    const divinerNotes = wizardCombatNotes({ classSlug: 'wizard', subclassSlug: 'diviner', level: 3 });
    expect(divinerNotes.some((n) => n.includes('Presságio'))).toBe(true);

    const mmNotes = wizardCombatNotes({
      classSlug: 'wizard',
      subclassSlug: 'magic-missile-mage',
      level: 14,
    });
    expect(mmNotes.some((n) => n.includes('Mago dos Mísseis'))).toBe(true);
    expect(mmNotes.some((n) => n.includes('Mísseis Versáteis'))).toBe(false);
    expect(mmNotes.some((n) => n.includes('Escudo de Mísseis'))).toBe(false);
    expect(mmNotes.some((n) => n.includes('Giga-Míssil'))).toBe(false);
  });
});
