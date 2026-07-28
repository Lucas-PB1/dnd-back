import { NotFoundException } from '@nestjs/common';
import { FindSubclassSpellcastingQuery } from './find-subclass-spellcasting.query';

describe('FindSubclassSpellcastingQuery', () => {
  let catalogLookup: { findSubclassOrFail: jest.Mock };
  let dataSource: { query: jest.Mock };
  let query: FindSubclassSpellcastingQuery;

  beforeEach(() => {
    catalogLookup = { findSubclassOrFail: jest.fn().mockResolvedValue({}) };
    dataSource = {
      query: jest.fn().mockResolvedValue([
        {
          subclass_slug: 'evoker',
          casting_type: 'prepared',
          ability_slug: 'intelligence',
          focus_label: null,
          spell_list_class_slug: 'wizard',
          spell_slot_pattern_slug: 'full',
          ritual: false,
        },
      ]),
    };
    query = new FindSubclassSpellcastingQuery(
      catalogLookup as never,
      dataSource as never,
    );
  });

  it('maps spellcasting row', async () => {
    const result = await query.execute('evoker');
    expect(dataSource.query).toHaveBeenCalledWith(expect.any(String), ['evoker']);
    expect(result).toMatchObject({
      subclassSlug: 'evoker',
      castingType: 'prepared',
      spellcastingMode: 'prepared',
    });
  });

  it('throws when subclass has no spellcasting', async () => {
    dataSource.query.mockResolvedValue([]);
    await expect(query.execute('evoker')).rejects.toThrow(NotFoundException);
  });
});
