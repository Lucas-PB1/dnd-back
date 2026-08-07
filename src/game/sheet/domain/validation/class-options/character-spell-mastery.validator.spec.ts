import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterSpellMasteryValidator } from './character-spell-mastery.validator';

describe('CharacterSpellMasteryValidator', () => {
  let validator: CharacterSpellMasteryValidator;
  let dataSource: { query: jest.Mock };

  const ctx = {
    level: 18,
    classSlug: 'wizard',
    speciesSlug: 'human',
    backgroundSlug: 'sage',
    subclassSlug: 'evoker',
  };

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    validator = new CharacterSpellMasteryValidator(
      dataSource as unknown as DataSource,
    );
  });

  it('allows empty mastery options', async () => {
    await expect(
      validator.validateSpellMasteryOptions(ctx, [], []),
    ).resolves.toBeUndefined();
  });

  it('rejects non-wizard', async () => {
    await expect(
      validator.validateSpellMasteryOptions(
        { ...ctx, classSlug: 'fighter' },
        [{ optionKey: 'spellMastery1', valueId: 'alarme' }],
        [{ spellSlug: 'alarme', listType: 'prepared' }],
      ),
    ).rejects.toThrow(BadRequestException);
  });

  it('rejects below level 18', async () => {
    await expect(
      validator.validateSpellMasteryOptions(
        { ...ctx, level: 17 },
        [{ optionKey: 'spellMastery1', valueId: 'alarme' }],
        [{ spellSlug: 'alarme', listType: 'prepared' }],
      ),
    ).rejects.toThrow(/level 18/i);
  });

  it('rejects unprepared spell', async () => {
    await expect(
      validator.validateSpellMasteryOptions(
        ctx,
        [{ optionKey: 'spellMastery1', valueId: 'alarme' }],
        [{ spellSlug: 'alarme', listType: 'known' }],
      ),
    ).rejects.toThrow(/prepared/i);
  });

  it('rejects wrong spell level for key', async () => {
    dataSource.query.mockResolvedValue([{ level: 2 }]);
    await expect(
      validator.validateSpellMasteryOptions(
        ctx,
        [{ optionKey: 'spellMastery1', valueId: 'invisibilidade' }],
        [{ spellSlug: 'invisibilidade', listType: 'prepared' }],
      ),
    ).rejects.toThrow(/level 1/i);
  });

  it('accepts valid 1st and 2nd picks', async () => {
    dataSource.query
      .mockResolvedValueOnce([{ level: 1 }])
      .mockResolvedValueOnce([{ level: 2 }]);
    await expect(
      validator.validateSpellMasteryOptions(
        ctx,
        [
          { optionKey: 'spellMastery1', valueId: 'alarme' },
          { optionKey: 'spellMastery2', valueId: 'invisibilidade' },
        ],
        [
          { spellSlug: 'alarme', listType: 'prepared' },
          { spellSlug: 'invisibilidade', listType: 'always_prepared' },
        ],
      ),
    ).resolves.toBeUndefined();
  });
});
