import {
  annotateCharacterSpellSources,
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
  mergeCharacterSpellsWithGrantedSources,
  type FeatGrantedSpellRow,
  type SpeciesGrantedSpellRow,
} from './granted-spells';

const FEAT_FIXED: FeatGrantedSpellRow[] = [
  { featSlug: 'fey-touched', spellSlug: 'passo-nebuloso' },
  { featSlug: 'shadow-touched', spellSlug: 'invisibilidade' },
];

const SPECIES_CATALOG: SpeciesGrantedSpellRow[] = [
  {
    speciesSlug: 'aasimar',
    choiceKind: null,
    choiceSlug: null,
    unlockLevel: 1,
    spellSlug: 'luz',
  },
  {
    speciesSlug: 'tiefling',
    choiceKind: null,
    choiceSlug: null,
    unlockLevel: 1,
    spellSlug: 'taumaturgia',
  },
  {
    speciesSlug: 'tiefling',
    choiceKind: 'infernal_legacy',
    choiceSlug: 'infernal',
    unlockLevel: 1,
    spellSlug: 'raio-de-fogo',
  },
  {
    speciesSlug: 'tiefling',
    choiceKind: 'infernal_legacy',
    choiceSlug: 'infernal',
    unlockLevel: 3,
    spellSlug: 'repreensao-diabolica',
  },
  {
    speciesSlug: 'tiefling',
    choiceKind: 'infernal_legacy',
    choiceSlug: 'infernal',
    unlockLevel: 5,
    spellSlug: 'escuridao',
  },
  {
    speciesSlug: 'elf',
    choiceKind: 'elf_lineage',
    choiceSlug: 'drow',
    unlockLevel: 1,
    spellSlug: 'luzes-dancantes',
  },
  {
    speciesSlug: 'elf',
    choiceKind: 'elf_lineage',
    choiceSlug: 'drow',
    unlockLevel: 3,
    spellSlug: 'fogo-das-fadas',
  },
  {
    speciesSlug: 'elf',
    choiceKind: 'elf_lineage',
    choiceSlug: 'drow',
    unlockLevel: 5,
    spellSlug: 'escuridao',
  },
  {
    speciesSlug: 'gnome',
    choiceKind: 'gnome_lineage',
    choiceSlug: 'forest-gnome',
    unlockLevel: 1,
    spellSlug: 'ilusao-menor',
  },
  {
    speciesSlug: 'gnome',
    choiceKind: 'gnome_lineage',
    choiceSlug: 'forest-gnome',
    unlockLevel: 1,
    spellSlug: 'falar-com-animais',
  },
  {
    speciesSlug: 'elf',
    choiceKind: 'elf_lineage',
    choiceSlug: 'high-elf',
    unlockLevel: 1,
    spellSlug: 'prestidigitacao-arcana',
  },
  {
    speciesSlug: 'elf',
    choiceKind: 'elf_lineage',
    choiceSlug: 'high-elf',
    unlockLevel: 3,
    spellSlug: 'detectar-magia',
  },
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
    it('grants aasimar light cantrip from catalog', () => {
      const slugs = collectSpeciesGrantedSpellSlugs(
        'aasimar',
        [],
        1,
        SPECIES_CATALOG,
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
        SPECIES_CATALOG,
      );
      expect([...lv1].sort()).toEqual(['raio-de-fogo', 'taumaturgia']);

      const lv5 = collectSpeciesGrantedSpellSlugs(
        'tiefling',
        choices,
        5,
        SPECIES_CATALOG,
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
        ...collectSpeciesGrantedSpellSlugs('elf', choices, 1, SPECIES_CATALOG),
      ]).toEqual(['luzes-dancantes']);
      expect([
        ...collectSpeciesGrantedSpellSlugs('elf', choices, 3, SPECIES_CATALOG),
      ].sort()).toEqual(['fogo-das-fadas', 'luzes-dancantes']);
    });

    it('grants gnome lineage spells at level 1', () => {
      const forest = collectSpeciesGrantedSpellSlugs(
        'gnome',
        [{ choiceKind: 'gnome_lineage', choiceSlug: 'forest-gnome' }],
        1,
        SPECIES_CATALOG,
      );
      expect([...forest].sort()).toEqual(['falar-com-animais', 'ilusao-menor']);
    });

    it('replaces high-elf L1 cantrip when high_elf_cantrip is chosen', () => {
      const defaultSlugs = collectSpeciesGrantedSpellSlugs(
        'elf',
        [{ choiceKind: 'elf_lineage', choiceSlug: 'high-elf' }],
        1,
        SPECIES_CATALOG,
      );
      expect([...defaultSlugs]).toEqual(['prestidigitacao-arcana']);

      const swapped = collectSpeciesGrantedSpellSlugs(
        'elf',
        [
          { choiceKind: 'elf_lineage', choiceSlug: 'high-elf' },
          { choiceKind: 'high_elf_cantrip', choiceSlug: 'raio-de-fogo' },
        ],
        3,
        SPECIES_CATALOG,
      );
      expect([...swapped].sort()).toEqual(['detectar-magia', 'raio-de-fogo']);
    });
  });

  describe('mergeCharacterSpellsWithGrantedSources', () => {
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
          speciesCatalog: SPECIES_CATALOG,
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
          speciesCatalog: SPECIES_CATALOG,
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
