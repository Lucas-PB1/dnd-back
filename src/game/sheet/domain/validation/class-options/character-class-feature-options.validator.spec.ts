import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterClassFeatureOptionsValidator } from './character-class-feature-options.validator';

describe('CharacterClassFeatureOptionsValidator', () => {
  let validator: CharacterClassFeatureOptionsValidator;
  let dataSource: jest.Mocked<Pick<DataSource, 'query'>>;

  const ctx = {
    level: 12,
    classSlug: 'cleric',
    speciesSlug: 'human',
    backgroundSlug: 'farmer',
    subclassSlug: 'life',
  };

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    validator = new CharacterClassFeatureOptionsValidator(
      dataSource as unknown as DataSource,
    );
  });

  it('lists unlocked option keys by level', async () => {
    dataSource.query.mockResolvedValue([
      { optionKey: 'divineOrder', unlockLevel: 1 },
      { optionKey: 'blessedStrikes', unlockLevel: 7 },
    ]);
    await expect(validator.loadOptionKeysAtLevel('cleric', 1)).resolves.toEqual([
      'divineOrder',
    ]);
    await expect(validator.loadOptionKeysAtLevel('cleric', 12)).resolves.toEqual([
      'divineOrder',
      'blessedStrikes',
    ]);
  });

  it('rejects unknown value for a class feature option', async () => {
    dataSource.query
      .mockResolvedValueOnce([
        { optionKey: 'divineOrder', unlockLevel: 1 },
      ])
      .mockResolvedValueOnce([]);
    await expect(
      validator.validate(ctx, [{ optionKey: 'divineOrder', valueId: 'nope' }]),
    ).rejects.toThrow(BadRequestException);
  });

  it('ignores expertise keys that are not class feature defs', async () => {
    dataSource.query.mockResolvedValue([
      { optionKey: 'divineOrder', unlockLevel: 1 },
    ]);
    await expect(
      validator.validate(ctx, [{ optionKey: 'expertiseSkill1', valueId: 'religion' }]),
    ).resolves.toBeUndefined();
  });
});
