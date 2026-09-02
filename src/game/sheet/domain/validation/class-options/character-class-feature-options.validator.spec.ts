jest.mock('@game/sheet/infrastructure/queries/class-option.queries', () => ({
  loadClassOptionDefs: jest.fn(),
  classOptionValueExists: jest.fn(),
}));

import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterClassFeatureOptionsValidator } from './character-class-feature-options.validator';
import {
  classOptionValueExists,
  loadClassOptionDefs,
} from '@game/sheet/infrastructure/queries/class-option.queries';

describe('CharacterClassFeatureOptionsValidator', () => {
  let validator: CharacterClassFeatureOptionsValidator;
  let dataSource: DataSource;

  const ctx = {
    level: 12,
    classSlug: 'cleric',
    speciesSlug: 'human',
    backgroundSlug: 'farmer',
    subclassSlug: 'life',
  };

  beforeEach(() => {
    dataSource = {} as DataSource;
    validator = new CharacterClassFeatureOptionsValidator(dataSource);
  });

  it('lists unlocked option keys by level', async () => {
    jest.mocked(loadClassOptionDefs).mockResolvedValue([
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
    jest.mocked(loadClassOptionDefs).mockResolvedValue([
      { optionKey: 'divineOrder', unlockLevel: 1 },
    ]);
    jest.mocked(classOptionValueExists).mockResolvedValue(false);
    await expect(
      validator.validate(ctx, [{ optionKey: 'divineOrder', valueId: 'nope' }]),
    ).rejects.toThrow(BadRequestException);
  });

  it('ignores expertise keys that are not class feature defs', async () => {
    jest.mocked(loadClassOptionDefs).mockResolvedValue([
      { optionKey: 'divineOrder', unlockLevel: 1 },
    ]);
    await expect(
      validator.validate(ctx, [{ optionKey: 'expertiseSkill1', valueId: 'religion' }]),
    ).resolves.toBeUndefined();
  });
});
