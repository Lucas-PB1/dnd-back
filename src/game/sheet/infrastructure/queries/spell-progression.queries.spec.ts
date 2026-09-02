import { DataSource } from 'typeorm';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { PhbClassProgression } from '@entities/phb-class-progression.entity';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import {
  loadSpellProgressionLimits,
  loadSubclassSpellcasting,
  maxSpellLevelForCharacter,
} from './spell-progression.queries';

describe('spell-progression.queries', () => {
  let subclassRepo: { findOne: jest.Mock };
  let classSlotsRepo: { findOne: jest.Mock };
  let classProgressionRepo: { findOne: jest.Mock };
  let dataSource: DataSource;

  beforeEach(() => {
    subclassRepo = { findOne: jest.fn() };
    classSlotsRepo = { findOne: jest.fn() };
    classProgressionRepo = { findOne: jest.fn() };
    dataSource = {
      getRepository: jest.fn((entity) => {
        if (entity === VSubclassSpellSlots) return subclassRepo;
        if (entity === VClassSpellSlots) return classSlotsRepo;
        if (entity === PhbClassProgression) return classProgressionRepo;
        throw new Error(`Unexpected entity ${entity}`);
      }),
    } as unknown as DataSource;
  });

  describe('loadSubclassSpellcasting', () => {
    it('returns null for falsy subclass slug', async () => {
      await expect(loadSubclassSpellcasting(dataSource, null)).resolves.toBeNull();
      await expect(loadSubclassSpellcasting(dataSource, '')).resolves.toBeNull();
      expect(subclassRepo.findOne).not.toHaveBeenCalled();
    });

    it('returns spell list class when row exists', async () => {
      subclassRepo.findOne.mockResolvedValue({ spellListClassSlug: 'wizard' });
      await expect(loadSubclassSpellcasting(dataSource, 'evoker')).resolves.toEqual({
        spellListClassSlug: 'wizard',
        spellcastingMode: 'prepared',
      });
    });

    it('returns null when subclass has no spellcasting row', async () => {
      subclassRepo.findOne.mockResolvedValue(null);
      await expect(loadSubclassSpellcasting(dataSource, 'champion')).resolves.toBeNull();
    });
  });

  describe('maxSpellLevelForCharacter', () => {
    it('uses subclass slot table when available', async () => {
      subclassRepo.findOne.mockResolvedValue({ spellSlots: { '1': 2, '2': 1 } });
      await expect(
        maxSpellLevelForCharacter(dataSource, 'fighter', 3, 'eldritch-knight'),
      ).resolves.toBe(2);
      expect(subclassRepo.findOne).toHaveBeenCalledWith({
        where: { subclassSlug: 'eldritch-knight', classLevel: 3 },
      });
      expect(classSlotsRepo.findOne).not.toHaveBeenCalled();
    });

    it('falls back to class slots when subclass has none', async () => {
      subclassRepo.findOne.mockResolvedValue(null);
      classSlotsRepo.findOne.mockResolvedValue({ spellSlots: { '1': 4, '3': 2 } });
      await expect(
        maxSpellLevelForCharacter(dataSource, 'wizard', 5, 'evoker'),
      ).resolves.toBe(3);
    });

    it('queries class table when subclassSlug is null', async () => {
      classSlotsRepo.findOne.mockResolvedValue({ spellSlots: { '1': 2 } });
      await expect(
        maxSpellLevelForCharacter(dataSource, 'cleric', 1, null),
      ).resolves.toBe(1);
      expect(classSlotsRepo.findOne).toHaveBeenCalledWith({
        where: { classSlug: 'cleric', classLevel: 1 },
        select: ['spellSlots'],
      });
    });
  });

  describe('loadSpellProgressionLimits', () => {
    const ctx = { classSlug: 'wizard', subclassSlug: 'evoker', level: 3 };

    it('loads subclass progression when subclassCasting provided', async () => {
      subclassRepo.findOne.mockResolvedValue({
        cantrips: 3,
        preparedSpells: 10,
      });
      await expect(
        loadSpellProgressionLimits(
          dataSource,
          ctx,
          { spellListClassSlug: 'wizard', spellcastingMode: 'prepared' },
        ),
      ).resolves.toEqual({ cantripsMax: 3, preparedOrKnownMax: 10 });
      expect(subclassRepo.findOne).toHaveBeenCalledWith({
        where: { subclassSlug: 'evoker', classLevel: 3 },
      });
    });

    it('returns null when subclass progression row missing', async () => {
      subclassRepo.findOne.mockResolvedValue(null);
      await expect(
        loadSpellProgressionLimits(
          dataSource,
          ctx,
          { spellListClassSlug: 'wizard', spellcastingMode: 'prepared' },
        ),
      ).resolves.toBeNull();
    });

    it('loads class progression when no subclass casting', async () => {
      classProgressionRepo.findOne.mockResolvedValue({
        cantrips: 2,
        preparedSpells: 6,
      });
      await expect(
        loadSpellProgressionLimits(dataSource, ctx, null),
      ).resolves.toEqual({ cantripsMax: 2, preparedOrKnownMax: 6 });
      expect(classProgressionRepo.findOne).toHaveBeenCalledWith({
        where: { klass: { slug: 'wizard' }, level: 3 },
      });
    });

    it('returns null when class progression row missing', async () => {
      classProgressionRepo.findOne.mockResolvedValue(null);
      await expect(
        loadSpellProgressionLimits(dataSource, ctx, null),
      ).resolves.toBeNull();
    });
  });
});
