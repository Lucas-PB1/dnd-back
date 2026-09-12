import type { CatalogEffect } from '@game/effects';
import {
  annotateCharacterSpellSources,
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
  mergeCharacterSpellsWithGrantedSources,
  type FeatGrantedSpellRow,
} from './granted-spells';

const FEAT_FIXED: FeatGrantedSpellRow[] = [
  { featSlug: 'fey-touched', spellSlug: 'passo-nebuloso' },
  { featSlug: 'shadow-touched', spellSlug: 'invisibilidade' },
];

function grantSpellEffect(
  ownerSlug: string,
  spellSlug: string,
  unlockLevel: number,
): CatalogEffect {
  return {
    id: `${ownerSlug}-${spellSlug}-${unlockLevel}`,
    kind: 'grant_spell',
    ownerKind: 'species',
    ownerId: '1',
    ownerSlug,
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
    castEconomy: null,
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

function grantChoiceSpellEffect(
  ownerSlug: string,
  optionKey: string,
  unlockLevel = 1,
): CatalogEffect {
  return {
    ...grantSpellEffect(ownerSlug, `${optionKey}-placeholder`, unlockLevel),
    id: `${ownerSlug}-${optionKey}`,
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
  };
}

const AASIMAR_EFFECTS = [grantSpellEffect('aasimar', 'luz', 1)];
const TIEFLING_INFERNAL_EFFECTS = [
  grantSpellEffect('tiefling', 'taumaturgia', 1),
  grantSpellEffect('tiefling', 'raio-de-fogo', 1),
  grantSpellEffect('tiefling', 'repreensao-diabolica', 3),
  grantSpellEffect('tiefling', 'escuridao', 5),
];
const ELF_DROW_EFFECTS = [
  grantSpellEffect('elf', 'luzes-dancantes', 1),
  grantSpellEffect('elf', 'fogo-das-fadas', 3),
  grantSpellEffect('elf', 'escuridao', 5),
];
const ELF_HIGH_EFFECTS = [
  grantSpellEffect('elf', 'prestidigitacao-arcana', 1),
  grantSpellEffect('elf', 'detectar-magia', 3),
  grantChoiceSpellEffect('elf', 'high_elf_cantrip'),
];
const ANDARI_EFFECTS = [grantChoiceSpellEffect('bearfolk', 'andari_druid_cantrip')];
const GNOME_FOREST_EFFECTS = [
  grantSpellEffect('gnome', 'ilusao-menor', 1),
  grantSpellEffect('gnome', 'falar-com-animais', 1),
];

describe('granted-spells', () => {
  describe('collectFeatGrantedSpellSlugs', () => {
    it('collects magic-initiate cantrips and 1st-level spell', () => {
      const slugs = collectFeatGrantedSpellSlugs(
        [
          {
            featSlug: 'magic-initiate',
            instanceIndex: 0,
            optionKey: 'spellList',
            valueId: 'wizard',
          },
          {
            featSlug: 'magic-initiate',
            instanceIndex: 0,
            optionKey: 'cantrip1',
            valueId: 'luz',
          },
          {
            featSlug: 'magic-initiate',
            instanceIndex: 0,
            optionKey: 'cantrip2',
            valueId: 'prestidigitacao-arcana',
          },
          {
            featSlug: 'magic-initiate',
            instanceIndex: 0,
            optionKey: 'firstLevelSpell',
            valueId: 'escudo-arcano',
          },
        ],
        undefined,
        FEAT_FIXED,
      );

      expect([...slugs].sort()).toEqual([
        'escudo-arcano',
        'luz',
        'prestidigitacao-arcana',
      ]);
    });

    it('collects blessed/druidic warrior cantrips', () => {
      const slugs = collectFeatGrantedSpellSlugs(
        [
          {
            featSlug: 'blessed-warrior',
            instanceIndex: 0,
            optionKey: 'cantrip1',
            valueId: 'chama-sagrada',
          },
          {
            featSlug: 'blessed-warrior',
            instanceIndex: 0,
            optionKey: 'cantrip2',
            valueId: 'orientacao',
          },
        ],
        [{ featSlug: 'blessed-warrior', instanceIndex: 0 }],
      );
      expect([...slugs].sort()).toEqual(['chama-sagrada', 'orientacao']);
    });

    it('collects Northlands blessing bonusSpell + fixed grants', () => {
      const slugs = collectFeatGrantedSpellSlugs(
        [
          {
            featSlug: 'blessing-of-boreas',
            instanceIndex: 0,
            optionKey: 'castingAbility',
            valueId: 'inteligencia',
          },
          {
            featSlug: 'blessing-of-boreas',
            instanceIndex: 0,
            optionKey: 'bonusSpell',
            valueId: 'armadura-de-agathys',
          },
        ],
        [{ featSlug: 'blessing-of-boreas', instanceIndex: 0 }],
        [
          {
            featSlug: 'blessing-of-boreas',
            spellSlug: 'raio-de-gelo',
          },
        ],
      );
      expect([...slugs].sort()).toEqual([
        'armadura-de-agathys',
        'raio-de-gelo',
      ]);
    });

    it('adds fixed companions from catalog for fey/shadow touched', () => {
      const fey = collectFeatGrantedSpellSlugs(
        [
          {
            featSlug: 'fey-touched',
            instanceIndex: 0,
            optionKey: 'bonusSpell',
            valueId: 'detectar-magia',
          },
        ],
        [{ featSlug: 'fey-touched', instanceIndex: 0 }],
        FEAT_FIXED,
      );
      expect(fey.has('detectar-magia')).toBe(true);
      expect(fey.has('passo-nebuloso')).toBe(true);

      const shadow = collectFeatGrantedSpellSlugs(
        [
          {
            featSlug: 'shadow-touched',
            instanceIndex: 0,
            optionKey: 'bonusSpell',
            valueId: 'infligir-ferimentos',
          },
        ],
        [{ featSlug: 'shadow-touched', instanceIndex: 0 }],
        FEAT_FIXED,
      );
      expect(shadow.has('invisibilidade')).toBe(true);
    });
  });

  describe('collectSpeciesGrantedSpellSlugs', () => {
    it('grants aasimar light cantrip from effects', () => {
      const slugs = collectSpeciesGrantedSpellSlugs(
        'aasimar',
        [],
        1,
        AASIMAR_EFFECTS,
      );
      expect([...slugs]).toEqual(['luz']);
    });

    it('grants tiefling presence plus infernal legacy by level', () => {
      const choices = [
        { choiceKind: 'infernal_legacy', choiceSlug: 'infernal' },
      ];
      const lv1 = collectSpeciesGrantedSpellSlugs(
        'tiefling',
        choices,
        1,
        TIEFLING_INFERNAL_EFFECTS,
      );
      expect([...lv1].sort()).toEqual(['raio-de-fogo', 'taumaturgia']);

      const lv5 = collectSpeciesGrantedSpellSlugs(
        'tiefling',
        choices,
        5,
        TIEFLING_INFERNAL_EFFECTS,
      );
      expect([...lv5].sort()).toEqual([
        'escuridao',
        'raio-de-fogo',
        'repreensao-diabolica',
        'taumaturgia',
      ]);
    });

    it('gates elf lineage spells by level', () => {
      const choices = [{ choiceKind: 'elf_lineage', choiceSlug: 'drow' }];
      expect([
        ...collectSpeciesGrantedSpellSlugs('elf', choices, 1, ELF_DROW_EFFECTS),
      ]).toEqual(['luzes-dancantes']);
      expect([
        ...collectSpeciesGrantedSpellSlugs('elf', choices, 3, ELF_DROW_EFFECTS),
      ].sort()).toEqual(['fogo-das-fadas', 'luzes-dancantes']);
    });

    it('grants gnome lineage spells at level 1', () => {
      const forest = collectSpeciesGrantedSpellSlugs(
        'gnome',
        [{ choiceKind: 'gnome_lineage', choiceSlug: 'forest-gnome' }],
        1,
        GNOME_FOREST_EFFECTS,
      );
      expect([...forest].sort()).toEqual(['falar-com-animais', 'ilusao-menor']);
    });

    it('replaces high-elf L1 cantrip when high_elf_cantrip is chosen', () => {
      const defaultSlugs = collectSpeciesGrantedSpellSlugs(
        'elf',
        [{ choiceKind: 'elf_lineage', choiceSlug: 'high-elf' }],
        1,
        ELF_HIGH_EFFECTS,
      );
      expect([...defaultSlugs]).toEqual(['prestidigitacao-arcana']);

      const swapped = collectSpeciesGrantedSpellSlugs(
        'elf',
        [
          { choiceKind: 'elf_lineage', choiceSlug: 'high-elf' },
          { choiceKind: 'high_elf_cantrip', choiceSlug: 'raio-de-fogo' },
        ],
        3,
        ELF_HIGH_EFFECTS,
      );
      expect([...swapped].sort()).toEqual(['detectar-magia', 'raio-de-fogo']);
    });

    it('uses grant_spell effects only (no MV fallback)', () => {
      const slugs = collectSpeciesGrantedSpellSlugs(
        'elf',
        [{ choiceKind: 'elf_lineage', choiceSlug: 'drow' }],
        1,
        [grantSpellEffect('elf', 'luzes-dancantes', 1)],
      );
      expect([...slugs]).toEqual(['luzes-dancantes']);
    });

    it('adds Andari Druid cantrip when andari_druid_cantrip is chosen', () => {
      const without = collectSpeciesGrantedSpellSlugs(
        'bearfolk',
        [{ choiceKind: 'bearfolk_lineage', choiceSlug: 'andari' }],
        1,
        ANDARI_EFFECTS,
      );
      expect([...without]).toEqual([]);

      const withCantrip = collectSpeciesGrantedSpellSlugs(
        'bearfolk',
        [
          { choiceKind: 'bearfolk_lineage', choiceSlug: 'andari' },
          { choiceKind: 'andari_druid_cantrip', choiceSlug: 'druidismo' },
        ],
        1,
        ANDARI_EFFECTS,
      );
      expect([...withCantrip]).toEqual(['druidismo']);
    });
  });

  describe('mergeCharacterSpellsWithGrantedSources', () => {
    it('adds class always_prepared grants without counting as a pick', () => {
      const merged = mergeCharacterSpellsWithGrantedSources(
        [{ spellSlug: 'curar-ferimentos', listType: 'prepared' }],
        {
          level: 1,
          classGrantedSpells: [
            { spellSlug: 'marca-do-predador', unlockLevel: 1 },
          ],
        },
      );

      expect(merged).toEqual([
        { spellSlug: 'curar-ferimentos', listType: 'prepared' },
        { spellSlug: 'marca-do-predador', listType: 'always_prepared' },
      ]);
    });

    it('unlocks paladin mount at 5 without dropping smite', () => {
      const merged = mergeCharacterSpellsWithGrantedSources(
        [{ spellSlug: 'destruicao-divina', listType: 'always_prepared' }],
        {
          level: 5,
          previousLevel: 4,
          classGrantedSpells: [
            { spellSlug: 'destruicao-divina', unlockLevel: 2 },
            { spellSlug: 'convocar-montaria', unlockLevel: 5 },
          ],
        },
      );

      expect(merged).toEqual(
        expect.arrayContaining([
          { spellSlug: 'destruicao-divina', listType: 'always_prepared' },
          { spellSlug: 'convocar-montaria', listType: 'always_prepared' },
        ]),
      );
    });

    it('promotes prepared subclass spell to always_prepared instead of duplicating', () => {
      const merged = mergeCharacterSpellsWithGrantedSources(
        [{ spellSlug: 'restauracao-maior', listType: 'prepared' }],
        {
          level: 12,
          subclassGrantedSpells: [
            { spellSlug: 'restauracao-maior', unlockLevel: 9 },
          ],
        },
      );

      expect(merged).toEqual([
        { spellSlug: 'restauracao-maior', listType: 'always_prepared' },
      ]);
    });

    it('adds always_prepared feat grants without dropping class spells', () => {
      const merged = mergeCharacterSpellsWithGrantedSources(
        [{ spellSlug: 'bola-de-fogo', listType: 'prepared' }],
        {
          featOptions: [
            {
              featSlug: 'magic-initiate',
              instanceIndex: 0,
              optionKey: 'cantrip1',
              valueId: 'luz',
            },
          ],
        },
      );

      expect(merged).toEqual(
        expect.arrayContaining([
          { spellSlug: 'bola-de-fogo', listType: 'prepared' },
          { spellSlug: 'luz', listType: 'always_prepared' },
        ]),
      );
    });

    it('unlocks elf L3 spells on level-up without dropping L1', () => {
      const merged = mergeCharacterSpellsWithGrantedSources(
        [{ spellSlug: 'luzes-dancantes', listType: 'always_prepared' }],
        {
          speciesSlug: 'elf',
          speciesChoices: [{ choiceKind: 'elf_lineage', choiceSlug: 'drow' }],
          level: 3,
          previousSpeciesSlug: 'elf',
          previousSpeciesChoices: [
            { choiceKind: 'elf_lineage', choiceSlug: 'drow' },
          ],
          previousLevel: 2,
          speciesEffects: ELF_DROW_EFFECTS,
          previousSpeciesEffects: ELF_DROW_EFFECTS,
        },
      );

      expect(merged).toEqual(
        expect.arrayContaining([
          { spellSlug: 'luzes-dancantes', listType: 'always_prepared' },
          { spellSlug: 'fogo-das-fadas', listType: 'always_prepared' },
        ]),
      );
    });

    it('keeps species luz when feat grant of luz is removed', () => {
      const merged = mergeCharacterSpellsWithGrantedSources(
        [{ spellSlug: 'luz', listType: 'always_prepared' }],
        {
          featOptions: [],
          previousFeatOptions: [
            {
              featSlug: 'magic-initiate',
              instanceIndex: 0,
              optionKey: 'cantrip1',
              valueId: 'luz',
            },
          ],
          speciesSlug: 'aasimar',
          speciesChoices: [],
          level: 1,
          previousSpeciesSlug: 'aasimar',
          previousSpeciesChoices: [],
          previousLevel: 1,
          speciesEffects: AASIMAR_EFFECTS,
          previousSpeciesEffects: AASIMAR_EFFECTS,
          featFixedSpells: FEAT_FIXED,
        },
      );

      expect(merged).toEqual([
        { spellSlug: 'luz', listType: 'always_prepared' },
      ]);
    });
  });

  describe('annotateCharacterSpellSources', () => {
    it('marks feat, species and subclass ahead of class', () => {
      const annotated = annotateCharacterSpellSources(
        [
          { spellSlug: 'luz', listType: 'always_prepared' },
          { spellSlug: 'taumaturgia', listType: 'always_prepared' },
          { spellSlug: 'marca-divina', listType: 'always_prepared' },
          { spellSlug: 'bola-de-fogo', listType: 'prepared' },
        ],
        {
          featGrantedSlugs: new Set(['luz']),
          speciesGrantedSlugs: new Set(['luz', 'taumaturgia']),
          subclassSpellSlugs: new Set(['marca-divina']),
        },
      );

      expect(annotated).toEqual([
        { spellSlug: 'luz', listType: 'always_prepared', source: 'feat' },
        {
          spellSlug: 'taumaturgia',
          listType: 'always_prepared',
          source: 'species',
        },
        {
          spellSlug: 'marca-divina',
          listType: 'always_prepared',
          source: 'subclass',
        },
        { spellSlug: 'bola-de-fogo', listType: 'prepared', source: 'class' },
      ]);
    });
  });
});
