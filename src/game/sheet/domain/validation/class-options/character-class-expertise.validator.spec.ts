jest.mock('@game/sheet/infrastructure/queries/background-origin.queries', () => ({
  loadBackgroundSkillSlugs: jest.fn(),
}));
jest.mock('@game/sheet/infrastructure/queries/skill-catalog.queries', () => ({
  skillExists: jest.fn(),
}));

import { DataSource } from 'typeorm';
import { CharacterSheetContext } from '@game/sheet/domain/character-sheet.types';
import { CharacterClassExpertiseValidator } from './character-class-expertise.validator';
import { loadBackgroundSkillSlugs } from '@game/sheet/infrastructure/queries/background-origin.queries';
import { skillExists } from '@game/sheet/infrastructure/queries/skill-catalog.queries';

describe('CharacterClassExpertiseValidator', () => {
  let validator: CharacterClassExpertiseValidator;
  let dataSource: DataSource;

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
    dataSource = {} as DataSource;
    validator = new CharacterClassExpertiseValidator(dataSource);
  });

  function mockBackgroundSkills(slugs: string[]) {
    jest.mocked(loadBackgroundSkillSlugs).mockResolvedValue(slugs);
    jest.mocked(skillExists).mockImplementation(async (_, skill) => skill !== 'fake-skill');
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
