import {
  consumeGrantedFreeCast,
  freeCastMaxUses,
  freeCastsRemaining,
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
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
  };
}

function featSpellEffect(input: {
  featSlug: string;
  optionKey: string;
  economy: 'at_will' | 'once_per_long_rest';
  usesFormula?: 'fixed' | 'proficiency_bonus';
  fixedUses?: number | null;
}): CatalogEffect {
  return {
    id: `${input.featSlug}-${input.optionKey}`,
    kind: 'grant_spell',
    ownerKind: 'feat',
    ownerId: '1',
    ownerSlug: input.featSlug,
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
      spellId: '1',
      spellSlug: null,
      optionKey: input.optionKey,
      spellLevel: 1,
    },
    castEconomy: {
      economy: input.economy,
      usesFormula: input.usesFormula ?? 'fixed',
      fixedUses:
        input.fixedUses !== undefined
          ? input.fixedUses
          : input.economy === 'once_per_long_rest'
            ? 1
            : null,
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
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
  };
}

function speciesChoiceSpellEffect(optionKey: string): CatalogEffect {
  return {
    id: `choice-${optionKey}`,
    kind: 'grant_spell',
    ownerKind: 'species',
    ownerId: '1',
    ownerSlug: 'elf',
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
      optionKey,
      spellLevel: 0,
    },
    castEconomy: {
      economy: 'at_will',
      usesFormula: 'fixed',
      fixedUses: null,
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
    condition: null,
    save: null,
    forcedMovement: null,
    dice: null,
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

  it('marks Blade of Radiance holy revelations as at_will', () => {
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'heroismo',
        source: 'subclass',
        subclassSlug: 'blade-of-radiance',
      }),
    ).toBe('at_will');
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'escudo-da-fe',
        source: 'class',
        subclassSlug: 'blade-of-radiance',
      }),
    ).toBe('at_will');
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'heroismo',
        source: 'subclass',
        subclassSlug: 'arcane-trickster',
      }),
    ).toBe('slot_only');
  });

  it('reads feat cast economy from phb_effect', () => {
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'fire-bolt',
        source: 'feat',
        featOptions: [
          { featSlug: 'magic-initiate', optionKey: 'cantrip1', valueId: 'fire-bolt' },
        ],
        featEffects: [
          featSpellEffect({
            featSlug: 'magic-initiate',
            optionKey: 'cantrip1',
            economy: 'at_will',
            fixedUses: null,
          }),
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
        featEffects: [
          featSpellEffect({
            featSlug: 'magic-initiate',
            optionKey: 'firstLevelSpell',
            economy: 'once_per_long_rest',
          }),
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
        featEffects: [
          featSpellEffect({
            featSlug: 'sangromantic-initiate',
            optionKey: 'bloodMagicSpell',
            economy: 'once_per_long_rest',
          }),
        ],
      }),
    ).toBe('once_per_long_rest');
  });

  it('defaults feat to slot_only without cast_economy effect', () => {
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
        featEffects: [],
      }),
    ).toBe('slot_only');
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

  it('marks high-elf choice cantrip as at_will from grant_spell option_key', () => {
    expect(
      resolveGrantedSpellCastEconomy({
        spellSlug: 'raio-de-fogo',
        source: 'species',
        speciesSlug: 'elf',
        speciesChoices: [
          { choiceKind: 'elf_lineage', choiceSlug: 'high-elf' },
          { choiceKind: 'high_elf_cantrip', choiceSlug: 'raio-de-fogo' },
        ],
        speciesEffects: [speciesChoiceSpellEffect('high_elf_cantrip')],
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

  it('uses PB max from cast_economy uses_formula', () => {
    expect(
      freeCastMaxUses({
        economy: 'once_per_long_rest',
        spellSlug: 'curar-ferimentos',
        featSlug: 'greater-blessing-of-freyr-and-freyja',
        optionKey: 'bonusSpell',
        proficiencyBonus: 3,
        featEffects: [
          featSpellEffect({
            featSlug: 'greater-blessing-of-freyr-and-freyja',
            optionKey: 'bonusSpell',
            economy: 'once_per_long_rest',
            usesFormula: 'proficiency_bonus',
            fixedUses: null,
          }),
        ],
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
        optionKey: 'firstLevelSpell',
        proficiencyBonus: 3,
        featEffects: [
          featSpellEffect({
            featSlug: 'magic-initiate',
            optionKey: 'firstLevelSpell',
            economy: 'once_per_long_rest',
          }),
        ],
      }),
    ).toBe(1);
  });
});
