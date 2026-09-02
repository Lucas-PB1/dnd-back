jest.mock('@game/sheet/infrastructure/queries/spell-catalog.queries', () => ({
  spellOnClassList: jest.fn(),
}));

import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterMysticArcanumValidator } from './character-mystic-arcanum.validator';
import { spellOnClassList } from '@game/sheet/infrastructure/queries/spell-catalog.queries';

describe('CharacterMysticArcanumValidator', () => {
  let validator: CharacterMysticArcanumValidator;
  let dataSource: DataSource;

  beforeEach(() => {
    dataSource = {} as DataSource;
    validator = new CharacterMysticArcanumValidator(dataSource);
  });

  it('allows empty options', async () => {
    await expect(
      validator.validateMysticArcanumOptions(
        {
          classSlug: 'warlock',
          level: 11,
          backgroundSlug: 'hermit',
          speciesSlug: 'human',
          subclassSlug: 'fiend',
        },
        [],
      ),
    ).resolves.toBeUndefined();
  });

  it('rejects non-warlock', async () => {
    await expect(
      validator.validateMysticArcanumOptions(
        {
          classSlug: 'wizard',
          level: 11,
          backgroundSlug: 'sage',
          speciesSlug: 'human',
          subclassSlug: null,
        },
        [{ optionKey: 'mysticArcanum6', valueId: 'circulo-da-morte' }],
      ),
    ).rejects.toThrow(BadRequestException);
  });

  it('accepts warlock 6th-circle spell at 11', async () => {
    jest.mocked(spellOnClassList).mockResolvedValue(true);
    await expect(
      validator.validateMysticArcanumOptions(
        {
          classSlug: 'warlock',
          level: 11,
          backgroundSlug: 'hermit',
          speciesSlug: 'human',
          subclassSlug: 'fiend',
        },
        [{ optionKey: 'mysticArcanum6', valueId: 'circulo-da-morte' }],
      ),
    ).resolves.toBeUndefined();
  });
});
