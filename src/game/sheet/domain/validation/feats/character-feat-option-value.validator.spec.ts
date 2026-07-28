jest.mock('./feat-option-proficiency', () => ({
  validateFeatProficiencyOption: jest.fn().mockResolvedValue(undefined),
}));

import { DataSource, Repository } from 'typeorm';
import { PhbFeatOptionDef, PhbFeatOptionValue } from '../../../../../entities/phb-feat-option.entity';
import { VSpellByClass } from '../../../../../entities/views/v-spell-by-class.entity';
import { CharacterFeatOptionValueValidator } from './character-feat-option-value.validator';
import { validateFeatProficiencyOption } from './feat-option-proficiency';
import { RESILIENT_FEAT_SLUG } from './resilient-feat-options';

function def(partial: Partial<PhbFeatOptionDef>): PhbFeatOptionDef {
  return { featId: '1', optionKey: 'pick', label: 'Pick', valueType: 'catalog', sortOrder: 0, dependsOnOptionKey: null, spellMaxLevel: null, spellSchoolSlugs: null, spellRitualOnly: false, ...partial };
}

describe('CharacterFeatOptionValueValidator', () => {
  let validator: CharacterFeatOptionValueValidator;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;
  let classSpellsRepo: jest.Mocked<Pick<Repository<VSpellByClass>, 'findOne'>>;
  let featOptionValueRepo: jest.Mocked<Pick<Repository<PhbFeatOptionValue>, 'findOne'>>;

  beforeEach(() => {
    dataSource = { query: jest.fn().mockResolvedValue([{ ok: 1 }]) };
    classSpellsRepo = { findOne: jest.fn().mockResolvedValue({ spellLevel: 1 }) };
    featOptionValueRepo = { findOne: jest.fn().mockResolvedValue({ valueId: 'x' }) };
    validator = new CharacterFeatOptionValueValidator(
      dataSource as unknown as DataSource,
      classSpellsRepo as unknown as Repository<VSpellByClass>,
      featOptionValueRepo as never,
    );
  });

  it('validates fighting style against class list and catalog', async () => {
    await expect(
      validator.validate(
        def({ valueType: 'fighting_style', optionKey: 'style' }),
        { featSlug: 'defense', optionKey: 'style', valueId: 'archery' },
        [],
        'defense',
        [],
        ['archery'],
      ),
    ).resolves.toBeUndefined();

    await expect(
      validator.validate(
        def({ valueType: 'fighting_style' }),
        { featSlug: 'defense', optionKey: 'style', valueId: 'archery' },
        [],
        'defense',
        [],
        ['dueling'],
      ),
    ).rejects.toThrow(/not a valid fighting style/i);

    dataSource.query.mockResolvedValueOnce([]);
    await expect(
      validator.validate(
        def({ valueType: 'fighting_style' }),
        { featSlug: 'defense', optionKey: 'style', valueId: 'archery' },
        [],
        'defense',
        [],
        ['archery'],
      ),
    ).rejects.toThrow(/is invalid/i);
  });

  it('rejects invalid catalog and resilient ability choices', async () => {
    featOptionValueRepo.findOne.mockResolvedValueOnce(null);
    await expect(
      validator.validate(
        def({ valueType: 'catalog' }),
        { featSlug: 'alert', optionKey: 'pick', valueId: 'bad' },
        [],
        'alert',
        [],
        [],
      ),
    ).rejects.toThrow(/is invalid/i);

    await expect(
      validator.validate(
        def({ valueType: 'ability', optionKey: 'abilityIncrease' }),
        { featSlug: RESILIENT_FEAT_SLUG, optionKey: 'abilityIncrease', valueId: 'sabedoria' },
        [],
        RESILIENT_FEAT_SLUG,
        ['sabedoria'],
        [],
      ),
    ).rejects.toThrow(/without save proficiency/i);
  });

  it('rejects invalid ritual and school spell queries', async () => {
    dataSource.query.mockResolvedValueOnce([]);
    await expect(
      validator.validate(
        def({ valueType: 'spell', spellRitualOnly: true, spellMaxLevel: 1 }),
        { featSlug: 'ritual-caster', optionKey: 'spell', valueId: 'detect-magic' },
        [],
        'ritual-caster',
        [],
        [],
      ),
    ).rejects.toThrow(/must be a level 1 ritual/i);

    dataSource.query.mockResolvedValueOnce([]);
    await expect(
      validator.validate(
        def({ valueType: 'spell', spellSchoolSlugs: ['evocation'], spellMaxLevel: 1 }),
        { featSlug: 'magic-initiate', optionKey: 'spell', valueId: 'fire-bolt' },
        [],
        'magic-initiate',
        [],
        [],
      ),
    ).rejects.toThrow(/not a valid choice/i);
  });

  it('requires dependent spell list before spell validation', async () => {
    await expect(
      validator.validate(
        def({ valueType: 'spell', dependsOnOptionKey: 'spellList' }),
        { featSlug: 'magic-initiate', optionKey: 'spell', valueId: 'bless' },
        [],
        'magic-initiate',
        [],
        [],
      ),
    ).rejects.toThrow(/requires 'spellList' first/i);
  });

  it('rejects spells missing from class list or wrong level', async () => {
    const spellDef = def({ valueType: 'spell', dependsOnOptionKey: 'spellList', spellMaxLevel: 1 });
    const featOptions = [
      { featSlug: 'magic-initiate', optionKey: 'spellList', valueId: 'cleric' },
      { featSlug: 'magic-initiate', optionKey: 'spell', valueId: 'fireball' },
    ];

    classSpellsRepo.findOne.mockResolvedValueOnce(null);
    await expect(
      validator.validate(
        spellDef,
        featOptions[1],
        featOptions,
        'magic-initiate',
        [],
        [],
      ),
    ).rejects.toThrow(/not on the 'cleric' list/i);

    classSpellsRepo.findOne.mockResolvedValueOnce({ spellLevel: 3 } as never);
    await expect(
      validator.validate(
        spellDef,
        featOptions[1],
        featOptions,
        'magic-initiate',
        [],
        [],
      ),
    ).rejects.toThrow(/must be level 1/i);
  });

  it('rejects duplicate cantrip choices', async () => {
    const featOptions = [
      { featSlug: 'magic-initiate', optionKey: 'spellList', valueId: 'wizard' },
      { featSlug: 'magic-initiate', optionKey: 'cantrip1', valueId: 'fire-bolt' },
      { featSlug: 'magic-initiate', optionKey: 'cantrip2', valueId: 'fire-bolt' },
    ];
    classSpellsRepo.findOne.mockResolvedValue({ spellLevel: 0 } as never);
    await expect(
      validator.validate(
        def({ valueType: 'spell', optionKey: 'cantrip2', dependsOnOptionKey: 'spellList', spellMaxLevel: 0 }),
        featOptions[2],
        featOptions,
        'magic-initiate',
        [],
        [],
      ),
    ).rejects.toThrow(/Cantrip choices must be different/i);
  });

  it('delegates proficiency options', async () => {
    await validator.validate(def({ valueType: 'proficiency' }), { featSlug: 'skilled', optionKey: 'skill', valueId: 'stealth' }, [], 'skilled', [], []);
    expect(validateFeatProficiencyOption).toHaveBeenCalled();
  });
});
