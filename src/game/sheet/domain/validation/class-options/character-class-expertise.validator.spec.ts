import { DataSource } from 'typeorm';
import { CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import { CharacterClassExpertiseValidator } from './character-class-expertise.validator';

describe('CharacterClassExpertiseValidator', () => {
  let validator: CharacterClassExpertiseValidator;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;

  function ctx(
    classSlug: string,
    level: number,
    backgroundSlug: string,
  ): CharacterSheetContext {
    return {
      classSlug,
      level,
      backgroundSlug,
      speciesSlug: 'human',
      subclassSlug: null,
    };
  }

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    validator = new CharacterClassExpertiseValidator(
      dataSource as unknown as DataSource,
    );
  });

  function mockBackgroundSkills(slugs: string[]) {
    dataSource.query.mockImplementation((sql: string, params?: unknown[]) => {
      if (sql.includes('phb_background_skill')) {
        return Promise.resolve(slugs.map((slug) => ({ slug })));
      }
      if (sql.includes('phb_skill WHERE slug')) {
        const skill = (params as string[])[0];
        return Promise.resolve(skill === 'fake-skill' ? [] : [{ ok: 1 }]);
      }
      return Promise.resolve([]);
    });
  }

  it('rejects expertise when class has no slots at level', async () => {
    await expect(
      validator.validateClassExpertiseOptions(
        ctx('fighter', 1, 'soldier'),
        [{ optionKey: 'expertiseSkill1', valueId: 'athletics' }],
        ['athletics'],
        undefined,
        undefined,
      ),
    ).rejects.toThrow(/no expertise options/i);
  });

  it('accepts proficient skill for rogue at level 1', async () => {
    mockBackgroundSkills(['insight']);

    await expect(
      validator.validateClassExpertiseOptions(
        ctx('rogue', 1, 'criminal'),
        [
          { optionKey: 'expertiseSkill1', valueId: 'stealth' },
          { optionKey: 'expertiseSkill2', valueId: 'insight' },
        ],
        ['stealth'],
        undefined,
        undefined,
      ),
    ).resolves.toBeUndefined();
  });

  it('rejects expertise on non-proficient skill', async () => {
    mockBackgroundSkills([]);

    await expect(
      validator.validateClassExpertiseOptions(
        ctx('rogue', 1, 'criminal'),
        [{ optionKey: 'expertiseSkill1', valueId: 'arcana' }],
        ['stealth'],
        undefined,
        undefined,
      ),
    ).rejects.toThrow(/requires proficiency/i);
  });

  it('rejects invalid skill slug', async () => {
    mockBackgroundSkills(['stealth']);

    await expect(
      validator.validateClassExpertiseOptions(
        ctx('rogue', 1, 'criminal'),
        [{ optionKey: 'expertiseSkill1', valueId: 'fake-skill' }],
        ['stealth'],
        undefined,
        undefined,
      ),
    ).rejects.toThrow(/not a valid skill/i);
  });

  it('restricts wizard expertise to scholar skills', async () => {
    mockBackgroundSkills([]);

    await expect(
      validator.validateClassExpertiseOptions(
        ctx('wizard', 2, 'sage'),
        [{ optionKey: 'expertiseSkill1', valueId: 'stealth' }],
        ['stealth'],
        undefined,
        undefined,
      ),
    ).rejects.toThrow(/not allowed for 'wizard'/i);

    await expect(
      validator.validateClassExpertiseOptions(
        ctx('wizard', 2, 'sage'),
        [{ optionKey: 'expertiseSkill1', valueId: 'arcana' }],
        ['arcana'],
        undefined,
        undefined,
      ),
    ).resolves.toBeUndefined();
  });
});
