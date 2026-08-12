import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterMysticArcanumValidator } from './character-mystic-arcanum.validator';

describe('CharacterMysticArcanumValidator', () => {
  let validator: CharacterMysticArcanumValidator;
  let dataSource: { query: jest.Mock };

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    validator = new CharacterMysticArcanumValidator(
      dataSource as unknown as DataSource,
    );
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
    dataSource.query.mockResolvedValue([{ ok: 1 }]);
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
