import {
  annotateCharacterSpellSources,
  collectFeatGrantedSpellSlugs,
  collectSpeciesGrantedSpellSlugs,
  mergeCharacterSpellsWithFeatGrants,
  mergeCharacterSpellsWithGrantedSources,
} from './granted-spells';

describe('granted-spells', () => {
  describe('collectFeatGrantedSpellSlugs', () => {
    it('collects magic-initiate cantrips and 1st-level spell', () => {
      const slugs = collectFeatGrantedSpellSlugs([
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
      ]);

      expect([...slugs].sort()).toEqual([
        'escudo-arcano',
        'luz',
        'prestidigitacao-arcana',
      ]);
    });

    it('adds fixed companions for fey-touched and shadow-touched', () => {
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
      );
      expect(shadow.has('invisibilidade')).toBe(true);
    });

    it('collects ritual-caster ritualSpell slots', () => {
      const slugs = collectFeatGrantedSpellSlugs([
        {
          featSlug: 'ritual-caster',
          instanceIndex: 0,
          optionKey: 'ritualSpell1',
          valueId: 'alarme',
        },
        {
          featSlug: 'ritual-caster',
          instanceIndex: 0,
          optionKey: 'ritualSpell2',
          valueId: 'detectar-magia',
        },
      ]);
      expect([...slugs].sort()).toEqual(['alarme', 'detectar-magia']);
    });
  });

  describe('collectSpeciesGrantedSpellSlugs', () => {
    it('grants aasimar light cantrip', () => {
      const slugs = collectSpeciesGrantedSpellSlugs('aasimar', [], 1);
      expect([...slugs]).toEqual(['luz']);
    });

    it('grants tiefling presence plus infernal legacy by level', () => {
      const choices = [
        { choiceKind: 'infernal_legacy', choiceSlug: 'infernal' },
      ];
      const lv1 = collectSpeciesGrantedSpellSlugs('tiefling', choices, 1);
      expect([...lv1].sort()).toEqual(['raio-de-fogo', 'taumaturgia']);

      const lv5 = collectSpeciesGrantedSpellSlugs('tiefling', choices, 5);
      expect([...lv5].sort()).toEqual([
        'escuridao',
        'raio-de-fogo',
        'repreensao-diabolica',
        'taumaturgia',
      ]);
    });

    it('gates elf lineage spells by level', () => {
      const choices = [{ choiceKind: 'elf_lineage', choiceSlug: 'drow' }];
      expect([...collectSpeciesGrantedSpellSlugs('elf', choices, 1)]).toEqual([
        'luzes-dancantes',
      ]);
      expect([...collectSpeciesGrantedSpellSlugs('elf', choices, 3)].sort()).toEqual([
        'fogo-das-fadas',
        'luzes-dancantes',
      ]);
      expect([...collectSpeciesGrantedSpellSlugs('elf', choices, 5)].sort()).toEqual([
        'escuridao',
        'fogo-das-fadas',
        'luzes-dancantes',
      ]);
    });

    it('grants gnome lineage spells at level 1', () => {
      const forest = collectSpeciesGrantedSpellSlugs(
        'gnome',
        [{ choiceKind: 'gnome_lineage', choiceSlug: 'forest-gnome' }],
        1,
      );
      expect([...forest].sort()).toEqual(['falar-com-animais', 'ilusao-menor']);
    });
  });

  describe('mergeCharacterSpellsWithFeatGrants', () => {
    it('adds always_prepared grants without dropping class spells', () => {
      const merged = mergeCharacterSpellsWithFeatGrants(
        [{ spellSlug: 'bola-de-fogo', listType: 'prepared' }],
        [
          {
            featSlug: 'magic-initiate',
            instanceIndex: 0,
            optionKey: 'cantrip1',
            valueId: 'luz',
          },
        ],
      );

      expect(merged).toEqual(
        expect.arrayContaining([
          { spellSlug: 'bola-de-fogo', listType: 'prepared' },
          { spellSlug: 'luz', listType: 'always_prepared' },
        ]),
      );
    });

    it('removes previous feat always_prepared when feat options change', () => {
      const merged = mergeCharacterSpellsWithFeatGrants(
        [
          { spellSlug: 'luz', listType: 'always_prepared' },
          { spellSlug: 'bola-de-fogo', listType: 'prepared' },
        ],
        [
          {
            featSlug: 'magic-initiate',
            instanceIndex: 0,
            optionKey: 'cantrip1',
            valueId: 'prestidigitacao-arcana',
          },
        ],
        {
          previousFeatOptions: [
            {
              featSlug: 'magic-initiate',
              instanceIndex: 0,
              optionKey: 'cantrip1',
              valueId: 'luz',
            },
          ],
        },
      );

      expect(merged.find((s) => s.spellSlug === 'luz')).toBeUndefined();
      expect(merged).toEqual(
        expect.arrayContaining([
          { spellSlug: 'bola-de-fogo', listType: 'prepared' },
          { spellSlug: 'prestidigitacao-arcana', listType: 'always_prepared' },
        ]),
      );
    });

    it('keeps always_prepared that were not from previous feat grants', () => {
      const merged = mergeCharacterSpellsWithFeatGrants(
        [{ spellSlug: 'cura-ferimentos', listType: 'always_prepared' }],
        [],
        {
          previousFeatOptions: [
            {
              featSlug: 'magic-initiate',
              instanceIndex: 0,
              optionKey: 'cantrip1',
              valueId: 'luz',
            },
          ],
        },
      );

      expect(merged).toEqual([
        { spellSlug: 'cura-ferimentos', listType: 'always_prepared' },
      ]);
    });
  });

  describe('mergeCharacterSpellsWithGrantedSources', () => {
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
