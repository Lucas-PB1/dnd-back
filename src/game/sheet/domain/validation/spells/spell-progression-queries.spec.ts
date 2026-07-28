import { DataSource } from 'typeorm';
import {
  loadSpellProgressionLimits,
  loadSubclassSpellcasting,
  maxSpellLevelForCharacter,
} from './spell-progression-queries';

describe('spell-progression-queries', () => {
  let dataSource: { query: jest.Mock };

  beforeEach(() => {
    dataSource = { query: jest.fn() };
  });

  describe('loadSubclassSpellcasting', () => {
    it('returns null for falsy subclass slug', async () => {
      await expect(loadSubclassSpellcasting(dataSource as unknown as DataSource, null)).resolves.toBeNull();
      await expect(loadSubclassSpellcasting(dataSource as unknown as DataSource, '')).resolves.toBeNull();
      expect(dataSource.query).not.toHaveBeenCalled();
    });

    it('returns spell list class when row exists', async () => {
      dataSource.query.mockResolvedValue([{ spell_list_class_slug: 'wizard' }]);
      await expect(
        loadSubclassSpellcasting(dataSource as unknown as DataSource, 'evoker'),
      ).resolves.toEqual({
        spellListClassSlug: 'wizard',
        spellcastingMode: 'prepared',
      });
    });

    it('returns null when subclass has no spellcasting row', async () => {
      dataSource.query.mockResolvedValue([]);
      await expect(
        loadSubclassSpellcasting(dataSource as unknown as DataSource, 'champion'),
      ).resolves.toBeNull();
    });
  });

  describe('maxSpellLevelForCharacter', () => {
    it('uses subclass slot table when available', async () => {
      dataSource.query.mockResolvedValueOnce([{ spell_slots: { '1': 2, '2': 1 } }]);
      await expect(
        maxSpellLevelForCharacter(dataSource as unknown as DataSource, 'fighter', 3, 'eldritch-knight'),
      ).resolves.toBe(2);
      expect(dataSource.query).toHaveBeenCalledTimes(1);
    });

    it('falls back to class slots when subclass has none', async () => {
      dataSource.query
        .mockResolvedValueOnce([{ spell_slots: null }])
        .mockResolvedValueOnce([{ spell_slots: { '1': 4, '3': 2 } }]);
      await expect(
        maxSpellLevelForCharacter(dataSource as unknown as DataSource, 'wizard', 5, 'evoker'),
      ).resolves.toBe(3);
    });

    it('queries class table when subclassSlug is null', async () => {
      dataSource.query.mockResolvedValue([{ spell_slots: { '1': 2 } }]);
      await expect(
        maxSpellLevelForCharacter(dataSource as unknown as DataSource, 'cleric', 1, null),
      ).resolves.toBe(1);
      expect(dataSource.query).toHaveBeenCalledWith(
        expect.stringContaining('v_class_spell_slots'),
        ['cleric', 1],
      );
    });
  });

  describe('loadSpellProgressionLimits', () => {
    const ctx = { classSlug: 'wizard', subclassSlug: 'evoker', level: 3 };

    it('loads subclass progression when subclassCasting provided', async () => {
      dataSource.query.mockResolvedValue([{ cantrips: 3, prepared_spells: 10 }]);
      await expect(
        loadSpellProgressionLimits(
          dataSource as unknown as DataSource,
          ctx,
          { spellListClassSlug: 'wizard', spellcastingMode: 'prepared' },
        ),
      ).resolves.toEqual({ cantripsMax: 3, preparedOrKnownMax: 10 });
    });

    it('returns null when subclass progression row missing', async () => {
      dataSource.query.mockResolvedValue([]);
      await expect(
        loadSpellProgressionLimits(
          dataSource as unknown as DataSource,
          ctx,
          { spellListClassSlug: 'wizard', spellcastingMode: 'prepared' },
        ),
      ).resolves.toBeNull();
    });

    it('loads class progression when no subclass casting', async () => {
      dataSource.query.mockResolvedValue([{ cantrips: 2, prepared_spells: 6 }]);
      await expect(
        loadSpellProgressionLimits(dataSource as unknown as DataSource, ctx, null),
      ).resolves.toEqual({ cantripsMax: 2, preparedOrKnownMax: 6 });
      expect(dataSource.query).toHaveBeenCalledWith(
        expect.stringContaining('v_phb_class_progression'),
        ['wizard', 3],
      );
    });

    it('returns null when class progression row missing', async () => {
      dataSource.query.mockResolvedValue([]);
      await expect(
        loadSpellProgressionLimits(dataSource as unknown as DataSource, ctx, null),
      ).resolves.toBeNull();
    });
  });
});
