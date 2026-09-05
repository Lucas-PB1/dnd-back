import {
  consumeGrantedFreeCast,
  freeCastMaxUses,
  freeCastsRemaining,
  GREATER_FREYR_FEAT_SLUG,
  resolveGrantedSpellCastEconomy,
} from './resolve-granted-spell-cast-economy';
import type { CatalogEffect } from '@game/effects';

function speciesSpellEffect(
  spellSlug: string,
  unlockLevel: number,
  economy: 'at_will' | 'once_per_long_rest',
): CatalogEffect {
  return {
    id: `${spellSlug}-${unlockLevel}`,
    kind: 'grant_spell',
    ownerKind: 'species',
    ownerId: '1',
    ownerSlug: 'elf',
    trigger: 'on_build',
    unlockLevel,
    sortOrder: 0,
    minTraitTakes: 1,
    actionSlug: null,
    resourceSlug: null,
    label: null,
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: {
      spellId: '1',
      spellSlug,
      optionKey: null,
      spellLevel: unlockLevel <= 1 ? 0 : 1,
    },
    castEconomy: {
      economy,
      usesFormula: 'fixed',
      fixedUses: economy === 'once_per_long_rest' ? 1 : null,
    },
    numeric: null,
    note: null,
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
  };
}

const ELF_DROW_EFFECTS = [
  speciesSpellEffect('luzes-dancantes', 1, 'at_will'),
  speciesSpellEffect('fogo-das-fadas', 3, 'once_per_long_rest'),
];

describe('resolveGrantedSpellCastEconomy', () => {
  it('marks class spells as slot_only', () => {
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'fireball',
        source: 'class',
      }),
    ).toBe('slot_only');
  });

  it('marks feat cantrips at_will and first-level once_per_long_rest', () => {
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'fire-bolt',
        source: 'feat',
        featOptions: [
          { featSlug: 'magic-initiate', optionKey: 'cantrip1', valueId: 'fire-bolt' },
        ],
      }),
    ).toBe('at_will');
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'cure-wounds',
        source: 'feat',
        featOptions: [
          {
            featSlug: 'magic-initiate',
            optionKey: 'firstLevelSpell',
            valueId: 'cure-wounds',
          },
        ],
      }),
    ).toBe('once_per_long_rest');
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'sangue-vital',
        source: 'feat',
        featOptions: [
          {
            featSlug: 'sangromantic-initiate',
            optionKey: 'bloodMagicSpell',
            valueId: 'sangue-vital',
          },
        ],
      }),
    ).toBe('once_per_long_rest');
  });

  it('prefers phb_effect cast economy when catalog covers the feat option', () => {
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'cure-wounds',
        source: 'feat',
        featOptions: [
          {
            featSlug: 'magic-initiate',
            optionKey: 'firstLevelSpell',
            valueId: 'cure-wounds',
          },
        ],
        featEffects: [
          {
            id: '1',
            kind: 'grant_spell',
            ownerKind: 'feat',
            ownerId: '1',
            ownerSlug: 'magic-initiate',
            trigger: 'on_build',
            unlockLevel: 1,
            sortOrder: 0,
            minTraitTakes: 1,
            actionSlug: null,
            resourceSlug: null,
            label: null,
            requiresOptionKey: null,
            requiresOptionValue: null,
            spell: {
              spellId: null,
              spellSlug: null,
              optionKey: 'firstLevelSpell',
              spellLevel: 1,
            },
            castEconomy: {
              economy: 'once_per_long_rest',
              usesFormula: 'fixed',
              fixedUses: 1,
            },
            numeric: null,
            note: null,
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
          },
        ],
      }),
    ).toBe('once_per_long_rest');
  });

  it('reads species cast economy from phb_effect', () => {
    const choices = [{ choiceKind: 'elf_lineage', choiceSlug: 'drow' }];
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'luzes-dancantes',
        source: 'species',
        speciesSlug: 'elf',
        speciesChoices: choices,
        speciesEffects: ELF_DROW_EFFECTS,
      }),
    ).toBe('at_will');
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'fogo-das-fadas',
        source: 'species',
        speciesSlug: 'elf',
        speciesChoices: choices,
        speciesEffects: ELF_DROW_EFFECTS,
      }),
    ).toBe('once_per_long_rest');
  });

  it('marks high-elf choice cantrip as at_will without fixed effect', () => {
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'raio-de-fogo',
        source: 'species',
        speciesSlug: 'elf',
        speciesChoices: [
          { choiceKind: 'elf_lineage', choiceSlug: 'high-elf' },
          { choiceKind: 'high_elf_cantrip', choiceSlug: 'raio-de-fogo' },
        ],
        speciesEffects: [],
      }),
    ).toBe('at_will');
  });
});

describe('freeCast helpers', () => {
  it('tracks remaining and consume', () => {
    expect(freeCastsRemaining('at_will', 'x', {})).toBeNull();
    expect(freeCastsRemaining('slot_only', 'x', {})).toBe(0);
    expect(freeCastsRemaining('once_per_long_rest', 'x', {})).toBe(1);
    expect(freeCastsRemaining('once_per_long_rest', 'x', { x: 1 })).toBe(0);
    expect(consumeGrantedFreeCast({ x: 0 }, 'x')).toEqual({ x: 1 });
  });

  it('uses PB max for Greater Freyr Curar Ferimentos', () => {
    expect(
      freeCastMaxUses({
        economy: 'once_per_long_rest',
        spellSlug: 'curar-ferimentos',
        featSlug: GREATER_FREYR_FEAT_SLUG,
        proficiencyBonus: 3,
      }),
    ).toBe(3);
    expect(
      freeCastsRemaining(
        'once_per_long_rest',
        'curar-ferimentos',
        { 'curar-ferimentos': 2 },
        3,
      ),
    ).toBe(1);
    expect(
      freeCastMaxUses({
        economy: 'once_per_long_rest',
        spellSlug: 'curar-ferimentos',
        featSlug: 'magic-initiate',
        proficiencyBonus: 3,
      }),
    ).toBe(1);
  });
});
