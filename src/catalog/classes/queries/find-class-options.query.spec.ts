import { FindClassOptionsQuery } from './find-class-options.query';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbOptionValue } from '@entities/phb-option.entity';

describe('FindClassOptionsQuery', () => {
  let query: FindClassOptionsQuery;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'findClassOrFail'>>;
  let optionValuesRepo: { manager: { query: jest.Mock } };

  beforeEach(() => {
    catalogLookup = { findClassOrFail: jest.fn().mockResolvedValue({}) };
    optionValuesRepo = { manager: { query: jest.fn() } };
    query = new FindClassOptionsQuery(
      optionValuesRepo as never,
      catalogLookup as unknown as CatalogLookupService,
    );
  });

  it('groups class option values and paginates', async () => {
    optionValuesRepo.manager.query.mockResolvedValue([
      {
        optionKey: 'divineOrder',
        optionLabel: 'Ordem Divina',
        unlockLevel: 1,
        valueType: 'catalog',
        valueId: 'protector',
        valueLabel: 'Protetor',
        sortOrder: 1,
        benefit: 'Armas marciais e armadura pesada.',
      },
      {
        optionKey: 'divineOrder',
        optionLabel: 'Ordem Divina',
        unlockLevel: 1,
        valueType: 'catalog',
        valueId: 'thaumaturge',
        valueLabel: 'Taumaturgo',
        sortOrder: 2,
        benefit: 'Truque extra.',
      },
      {
        optionKey: 'blessedStrikes',
        optionLabel: 'Golpes Abençoados',
        unlockLevel: 7,
        valueType: 'catalog',
        valueId: 'divine-strike',
        valueLabel: 'Golpe Divino',
        sortOrder: 2,
        benefit: '+1d8.',
      },
    ]);

    const result = await query.execute('cleric', 12, 1, 20);

    expect(catalogLookup.findClassOrFail).toHaveBeenCalledWith('cleric');
    expect(optionValuesRepo.manager.query).toHaveBeenCalledWith(
      expect.stringContaining("scope = 'class'"),
      ['cleric', 12],
    );
    expect(result.data).toHaveLength(2);
    expect(result.data[0]?.optionKey).toBe('divineOrder');
    expect(result.data[0]?.values).toHaveLength(2);
    expect(result.data[1]?.optionKey).toBe('blessedStrikes');
  });

  it('returns empty page when class has no feature options', async () => {
    optionValuesRepo.manager.query.mockResolvedValue([]);
    const result = await query.execute('fighter', 5);
    expect(result.data).toEqual([]);
    expect(result.meta.total).toBe(0);
  });
});
