jest.mock('@game/sheet/infrastructure/queries/background-origin.queries', () => ({
  loadBackgroundSkillSlugs: jest.fn(),
}));
jest.mock('@game/sheet/infrastructure/queries/skill-catalog.queries', () => ({
  loadClassSkillChoiceSlugs: jest.fn(),
}));

import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterClassExtraSkillValidator } from './character-class-extra-skill.validator';
import { loadBackgroundSkillSlugs } from '@game/sheet/infrastructure/queries/background-origin.queries';
import { loadClassSkillChoiceSlugs } from '@game/sheet/infrastructure/queries/skill-catalog.queries';

describe('CharacterClassExtraSkillValidator', () => {
  let validator: CharacterClassExtraSkillValidator;
  let dataSource: DataSource;

  beforeEach(() => {
    dataSource = {} as DataSource;
    validator = new CharacterClassExtraSkillValidator(dataSource);
  });

  it('rejects extra skill below unlock', async () => {
    await expect(
      validator.validateClassExtraSkillOptions(
        {
          classSlug: 'barbarian',
          level: 2,
          backgroundSlug: 'farmer',
          speciesSlug: 'human',
          subclassSlug: null,
        },
        [{ optionKey: 'primordialKnowledgeSkill', valueId: 'survival' }],
        ['athletics', 'perception'],
        undefined,
        undefined,
      ),
    ).rejects.toThrow(BadRequestException);
  });

  it('accepts barbarian L3 skill from class pool', async () => {
    jest.mocked(loadBackgroundSkillSlugs).mockResolvedValue([]);
    jest.mocked(loadClassSkillChoiceSlugs).mockResolvedValue(['survival', 'nature']);
    await expect(
      validator.validateClassExtraSkillOptions(
        {
          classSlug: 'barbarian',
          level: 3,
          backgroundSlug: 'farmer',
          speciesSlug: 'human',
          subclassSlug: 'berserker',
        },
        [{ optionKey: 'primordialKnowledgeSkill', valueId: 'survival' }],
        ['athletics', 'perception'],
        undefined,
        undefined,
      ),
    ).resolves.toBeUndefined();
  });

  it('rejects already proficient skill', async () => {
    jest.mocked(loadBackgroundSkillSlugs).mockResolvedValue([]);
    jest.mocked(loadClassSkillChoiceSlugs).mockResolvedValue(['athletics']);
    await expect(
      validator.validateClassExtraSkillOptions(
        {
          classSlug: 'barbarian',
          level: 3,
          backgroundSlug: 'farmer',
          speciesSlug: 'human',
          subclassSlug: 'berserker',
        },
        [{ optionKey: 'primordialKnowledgeSkill', valueId: 'athletics' }],
        ['athletics', 'perception'],
        undefined,
        undefined,
      ),
    ).rejects.toThrow(/já é proficiente/i);
  });
});
