import {
  resolveFeatSlugForGrantedSpell,
  resolveSpellcastingAbilityForSpell,
} from './resolve-granted-spellcasting-ability';
import { enrichSpellsWithSpellcastingStats } from './enrich-spells-with-spellcasting-stats';
import type { AbilityModifiers } from '../../sheet/domain/stats/character-derived-stats';

const mods: AbilityModifiers = {
  forca: 1,
  destreza: 2,
  constituicao: 1,
  inteligencia: 3,
  sabedoria: 0,
  carisma: 2,
};

describe('resolveSpellcastingAbilityForSpell', () => {
  it('uses class ability for class/subclass sources', () => {
    expect(
      resolveSpellcastingAbilityForSpell({
        source: 'class',
        spellSlug: 'fireball',
        classAbilitySlug: 'inteligencia',
      }),
    ).toBe('inteligencia');
    expect(
      resolveSpellcastingAbilityForSpell({
        source: 'subclass',
        spellSlug: 'shield',
        classAbilitySlug: 'carisma',
      }),
    ).toBe('carisma');
  });

  it('uses feat castingAbility for feat-granted spells', () => {
    expect(
      resolveSpellcastingAbilityForSpell({
        source: 'feat',
        spellSlug: 'cure-wounds',
        classAbilitySlug: null,
        featOptions: [
          {
            featSlug: 'magic-initiate',
            optionKey: 'firstLevelSpell',
            valueId: 'cure-wounds',
          },
          {
            featSlug: 'magic-initiate',
            optionKey: 'castingAbility',
            valueId: 'sabedoria',
          },
        ],
      }),
    ).toBe('sabedoria');
  });

  it('falls back to class ability when feat has no castingAbility', () => {
    expect(
      resolveSpellcastingAbilityForSpell({
        source: 'feat',
        spellSlug: 'passo-nebuloso',
        classAbilitySlug: 'inteligencia',
        featFixedSpells: [
          { featSlug: 'fey-touched', spellSlug: 'passo-nebuloso' },
        ],
        featOptions: [],
      }),
    ).toBe('inteligencia');
  });

  it('uses species casting ability choices', () => {
    expect(
      resolveSpellcastingAbilityForSpell({
        source: 'species',
        spellSlug: 'fogo-das-fadas',
        classAbilitySlug: null,
        speciesChoices: [
          { choiceKind: 'elf_lineage', choiceSlug: 'drow' },
          { choiceKind: 'elf_casting_ability', choiceSlug: 'carisma' },
        ],
      }),
    ).toBe('carisma');
  });
});

describe('resolveFeatSlugForGrantedSpell', () => {
  it('matches option and fixed catalog rows', () => {
    expect(
      resolveFeatSlugForGrantedSpell(
        'fire-bolt',
        [
          {
            featSlug: 'magic-initiate',
            optionKey: 'cantrip1',
            valueId: 'fire-bolt',
            instanceIndex: 1,
          },
        ],
      ),
    ).toEqual({ featSlug: 'magic-initiate', instanceIndex: 1 });

    expect(
      resolveFeatSlugForGrantedSpell('invisibilidade', [], [
        { featSlug: 'shadow-touched', spellSlug: 'invisibilidade' },
      ]),
    ).toEqual({ featSlug: 'shadow-touched', instanceIndex: 0 });
  });
});

describe('enrichSpellsWithSpellcastingStats', () => {
  it('fills CD and attack for feat spells with castingAbility', () => {
    const [spell] = enrichSpellsWithSpellcastingStats(
      [
        {
          spellSlug: 'cure-wounds',
          listType: 'always_prepared',
          source: 'feat',
        },
      ],
      {
        classAbilitySlug: null,
        proficiencyBonus: 2,
        abilityModifiers: mods,
        featOptions: [
          {
            featSlug: 'magic-initiate',
            optionKey: 'firstLevelSpell',
            valueId: 'cure-wounds',
          },
          {
            featSlug: 'magic-initiate',
            optionKey: 'castingAbility',
            valueId: 'inteligencia',
          },
        ],
      },
    );
    expect(spell).toMatchObject({
      spellcastingAbilitySlug: 'inteligencia',
      spellSaveDc: 13,
      spellAttackBonus: 5,
    });
  });
});
