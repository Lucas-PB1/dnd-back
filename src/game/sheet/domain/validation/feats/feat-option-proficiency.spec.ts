import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { validateFeatProficiencyOption } from './feat-option-proficiency';
import { PhbOptionDef, PhbOptionValue } from '../../../../../entities/phb-option.entity';
import type { FeatOptionDto } from '../../../dto/character-sheet.dto';

describe('validateFeatProficiencyOption', () => {
  let dataSource: { query: jest.Mock };
  let featOptionValueRepo: { findOne: jest.Mock; exists: jest.Mock };
  const def = { scope: 'feat', ownerId: '1', optionKey: 'proficiency1' } as PhbOptionDef;

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    featOptionValueRepo = { findOne: jest.fn(), exists: jest.fn() };
  });

  async function run(
    option: FeatOptionDto,
    featOptions: FeatOptionDto[] = [option],
  ): Promise<void> {
    await validateFeatProficiencyOption(
      dataSource as unknown as DataSource,
      featOptionValueRepo as unknown as Repository<PhbOptionValue>,
      def,
      option,
      featOptions,
    );
  }

  it('accepts whitelisted feat option value', async () => {
    featOptionValueRepo.findOne.mockResolvedValue({ valueId: 'athletics' });
    await expect(
      run({ featSlug: 'skilled', optionKey: 'proficiency1', valueId: 'athletics' }),
    ).resolves.toBeUndefined();
    expect(dataSource.query).not.toHaveBeenCalled();
  });

  it('rejects value not in whitelist when whitelist exists', async () => {
    featOptionValueRepo.findOne.mockResolvedValue(null);
    featOptionValueRepo.exists.mockResolvedValue(true);
    await expect(
      run({ featSlug: 'skilled', optionKey: 'proficiency1', valueId: 'invalid' }),
    ).rejects.toThrow(/is invalid/i);
  });

  it('accepts skill slug when no whitelist and catalog has match', async () => {
    featOptionValueRepo.findOne.mockResolvedValue(null);
    featOptionValueRepo.exists.mockResolvedValue(false);
    dataSource.query.mockResolvedValue([{ ok: 1 }]);
    await expect(
      run({ featSlug: 'skilled', optionKey: 'proficiency1', valueId: 'stealth' }),
    ).resolves.toBeUndefined();
  });

  it('rejects unknown slug when no whitelist', async () => {
    featOptionValueRepo.findOne.mockResolvedValue(null);
    featOptionValueRepo.exists.mockResolvedValue(false);
    dataSource.query.mockResolvedValue([]);
    await expect(
      run({ featSlug: 'skilled', optionKey: 'proficiency1', valueId: 'not-a-skill' }),
    ).rejects.toThrow(/not a valid skill or tool/i);
  });

  it('rejects duplicate skilled proficiencies', async () => {
    featOptionValueRepo.findOne.mockResolvedValue({ valueId: 'athletics' });
    const options: FeatOptionDto[] = [
      { featSlug: 'skilled', optionKey: 'proficiency1', valueId: 'athletics' },
      { featSlug: 'skilled', optionKey: 'proficiency2', valueId: 'athletics' },
    ];
    await expect(run(options[0], options)).rejects.toThrow(/Skilled proficiencies must be distinct/i);
  });

  it('rejects duplicate artisan tool choices', async () => {
    featOptionValueRepo.findOne.mockResolvedValue({ valueId: 'smiths-tools' });
    const options: FeatOptionDto[] = [
      { featSlug: 'artisan', optionKey: 'artisanTool1', valueId: 'smiths-tools' },
      { featSlug: 'artisan', optionKey: 'artisanTool2', valueId: 'smiths-tools' },
    ];
    await expect(run(options[0], options)).rejects.toThrow(/Artisan tool choices must be distinct/i);
  });

  it('rejects duplicate musical instrument choices', async () => {
    featOptionValueRepo.findOne.mockResolvedValue({ valueId: 'lute' });
    const options: FeatOptionDto[] = [
      { featSlug: 'musician', optionKey: 'musicalInstrument1', valueId: 'lute' },
      { featSlug: 'musician', optionKey: 'musicalInstrument2', valueId: 'lute' },
    ];
    await expect(run(options[0], options)).rejects.toThrow(
      /Musical instrument choices must be distinct/i,
    );
  });
});
