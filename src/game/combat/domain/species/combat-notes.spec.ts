import type { CatalogEffect } from '@game/effects';
import { speciesCombatNotes } from './combat-notes';

function noteEffect(
  overrides: Partial<CatalogEffect> & Pick<CatalogEffect, 'kind' | 'label'>,
  noteText?: string,
): CatalogEffect {
  return {
    id: '1',
    ownerKind: 'species',
    ownerId: '1',
    ownerSlug: 'dwarf',
    trigger: 'passive',
    unlockLevel: 1,
    sortOrder: 0,
    minTraitTakes: 1,
    actionSlug: null,
    resourceSlug: null,
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: null,
    castEconomy: null,
    numeric: null,
    note: noteText ? { note: noteText } : null,
    resource: null,
    combatMod: null,
    proficiency: null,
    purchaseDiscount: null,
    damageDie: null,
    weapon: null,
    feat: null,
    saveAdvantage: null,
    sense: null,
    damageType: null,
    language: null,
    checkAdvantage: null,
    reach: null,
    restQuirk: null,
    environmentalImmunity: null,
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
    ...overrides,
  };
}

describe('speciesCombatNotes', () => {
  it('lists dwarf passives from effects', () => {
    const notes = speciesCombatNotes({
      speciesSlug: 'dwarf',
      speciesEffects: [
        noteEffect({ kind: 'grant_sense', label: 'Visão no Escuro 36 m' }),
        noteEffect(
          { kind: 'combat_mod', label: 'Tenacidade Anã' },
          'Tenacidade Anã: +1 PV máx. por nível.',
        ),
      ],
    });
    expect(notes.some((n) => /Visão no Escuro 36/i.test(n))).toBe(true);
    expect(notes.some((n) => /Tenacidade/i.test(n))).toBe(true);
  });

  it('formats dragon ancestry resistance from option', () => {
    const notes = speciesCombatNotes({
      speciesSlug: 'dragonborn',
      speciesChoices: [{ choiceKind: 'dragon_ancestry', choiceSlug: 'red' }],
      speciesEffects: [
        noteEffect({
          kind: 'damage_resistance',
          label: 'Resistência Dracônica',
          damageType: { damageTypeSlug: null, optionKey: 'dragonAncestryId' },
        }),
      ],
      optionDamageTypes: new Map([['dragonAncestryId:red', 'fire']]),
    });
    expect(notes.some((n) => /Ígneo/i.test(n))).toBe(true);
  });

  it('uses reach label for marionette', () => {
    const notes = speciesCombatNotes({
      speciesSlug: 'geppettin',
      speciesEffects: [
        noteEffect(
          {
            kind: 'reach_bonus',
            label: 'Marionete — alcance',
          },
          'Marionete: +1,5 m de alcance em arma corpo a corpo.',
        ),
      ],
    });
    expect(notes.some((n) => /1,5 m/i.test(n))).toBe(true);
  });

  it('lists bearfolk passives from effect labels', () => {
    const notes = speciesCombatNotes({
      speciesSlug: 'bearfolk',
      speciesEffects: [
        noteEffect({ kind: 'damage_resistance', label: 'Pelagem Espessa' }),
        noteEffect({ kind: 'save_advantage', label: 'Coração Selvagem' }),
      ],
    });
    expect(notes.some((n) => /Pelagem/i.test(n))).toBe(true);
    expect(notes.some((n) => /Coração Selvagem/i.test(n))).toBe(true);
  });

  it('returns empty without effects', () => {
    expect(speciesCombatNotes({ speciesSlug: 'dwarf' })).toEqual([]);
  });
});
