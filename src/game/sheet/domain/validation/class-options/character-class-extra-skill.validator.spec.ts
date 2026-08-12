import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterClassExtraSkillValidator } from './character-class-extra-skill.validator';

describe('CharacterClassExtraSkillValidator', () => {
  let validator: CharacterClassExtraSkillValidator;
  let dataSource: { query: jest.Mock };

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    validator = new CharacterClassExtraSkillValidator(
      dataSource as unknown as DataSource,
    );
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
    dataSource.query
      .mockResolvedValueOnce([])
      .mockResolvedValueOnce([{ slug: 'survival' }, { slug: 'nature' }]);
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
    dataSource.query
      .mockResolvedValueOnce([])
      .mockResolvedValueOnce([{ slug: 'athletics' }]);
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
