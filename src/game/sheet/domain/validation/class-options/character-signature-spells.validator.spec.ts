import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterSignatureSpellsValidator } from './character-signature-spells.validator';

describe('CharacterSignatureSpellsValidator', () => {
  let validator: CharacterSignatureSpellsValidator;
  let dataSource: { query: jest.Mock };

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    validator = new CharacterSignatureSpellsValidator(
      dataSource as unknown as DataSource,
    );
  });

  it('allows empty options', async () => {
    await expect(
      validator.validateSignatureSpellOptions(
        {
          classSlug: 'wizard',
          level: 20,
          backgroundSlug: 'sage',
          speciesSlug: 'human',
          subclassSlug: 'evoker',
        },
        [],
        [],
      ),
    ).resolves.toBeUndefined();
  });

  it('rejects below level 20', async () => {
    await expect(
      validator.validateSignatureSpellOptions(
        {
          classSlug: 'wizard',
          level: 19,
          backgroundSlug: 'sage',
          speciesSlug: 'human',
          subclassSlug: 'evoker',
        },
        [{ optionKey: 'signatureSpell1', valueId: 'bola-de-fogo' }],
        [{ spellSlug: 'bola-de-fogo', listType: 'known' }],
      ),
    ).rejects.toThrow(/20/i);
  });

  it('accepts two distinct 3rd-circle book spells', async () => {
    dataSource.query
      .mockResolvedValueOnce([{ level: 3 }])
      .mockResolvedValueOnce([{ level: 3 }]);
    await expect(
      validator.validateSignatureSpellOptions(
        {
          classSlug: 'wizard',
          level: 20,
          backgroundSlug: 'sage',
          speciesSlug: 'human',
          subclassSlug: 'evoker',
        },
        [
          { optionKey: 'signatureSpell1', valueId: 'bola-de-fogo' },
          { optionKey: 'signatureSpell2', valueId: 'relampago' },
        ],
        [
          { spellSlug: 'bola-de-fogo', listType: 'known' },
          { spellSlug: 'relampago', listType: 'prepared' },
        ],
      ),
    ).resolves.toBeUndefined();
  });
});
