import { BadRequestException } from '@nestjs/common';
import { LevelUpService } from './level-up.service';
import type { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import * as levelUpCatalog from '../infrastructure/queries/level-up-catalog.queries';
import * as classOptionQueries from '@game/sheet/infrastructure/queries/class-option.queries';
import { asDep } from '@common/testing/as-dep';

type Repo = { findOne: jest.Mock; find: jest.Mock };

function repo(): Repo {
  return { findOne: jest.fn(), find: jest.fn() };
}

function character(overrides: Partial<PlayerCharacter> = {}): PlayerCharacter {
  return {
    id: 'ch1',
    userId: 'u1',
    name: 'Merlin',
    level: 1,
    classSlug: 'wizard',
    speciesSlug: 'human',
    backgroundSlug: 'sage',
    subclassSlug: null,
    alignmentSlug: null,
    abilityScores: {
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 16,
      sabedoria: 12,
      carisma: 10,
    },
    hitPointsMax: 8,
    hitPointsCurrent: 8,
    abilityGenerationMethodSlug: null,
    createdAt: new Date(),
    updatedAt: new Date(),
    ...overrides,
  } as PlayerCharacter;
}

describe('LevelUpService', () => {
  let service: LevelUpService;
  let dataSource: { getRepository: jest.Mock };
  let domain: jest.Mocked<
    Pick<CharacterDomainService, 'calculateHitPointsMaxForCharacter'>
  >;
  let sheetRepository: jest.Mocked<Pick<CharacterSheetRepository, 'load'>>;
  let levelsRepo: Repo;
  let classSpellsRepo: Repo;
  let subclassSpellsRepo: Repo;

  beforeEach(() => {
    jest.restoreAllMocks();
    dataSource = { getRepository: jest.fn() };
    domain = { calculateHitPointsMaxForCharacter: jest.fn() };
    sheetRepository = { load: jest.fn() };
    levelsRepo = repo();
    classSpellsRepo = repo();
    subclassSpellsRepo = repo();

    jest
      .spyOn(levelUpCatalog, 'loadSubclassUnlockLevel')
      .mockResolvedValue(3);
    jest
      .spyOn(levelUpCatalog, 'loadAsiOrFeatLevels')
      .mockResolvedValue([4, 8, 12, 16, 19]);
    jest
      .spyOn(levelUpCatalog, 'loadClassWeaponMasteryProgression')
      .mockResolvedValue([
        { level: 1, weaponMastery: null },
        { level: 2, weaponMastery: null },
      ]);
    jest
      .spyOn(levelUpCatalog, 'loadSubclassSpellListClassSlug')
      .mockResolvedValue(null);
    jest
      .spyOn(levelUpCatalog, 'loadMaxSpellLevelForCharacter')
      .mockResolvedValue(1);
    jest
      .spyOn(levelUpCatalog, 'loadClassFeaturesAtLevel')
      .mockResolvedValue([]);
    jest
      .spyOn(levelUpCatalog, 'loadSubclassFeaturesAtLevel')
      .mockResolvedValue([]);

    service = new LevelUpService(
      asDep(dataSource),
      asDep(domain),
      asDep(sheetRepository),
      asDep(levelsRepo),
      asDep(classSpellsRepo),
      asDep(subclassSpellsRepo),
    );
  });

  it('throws when character is already at max level', async () => {
    await expect(
      service.buildPreview(character({ level: 20 })),
    ).rejects.toThrow(
      new BadRequestException('Character is already at maximum level'),
    );
  });

  it('buildPreview returns hp, pb, spells and mastery slots', async () => {
    const pc = character();
    sheetRepository.load.mockResolvedValue(
      asDep({ characterFeats: [{ featSlug: 'alert' }] }),
    );
    domain.calculateHitPointsMaxForCharacter
      .mockResolvedValueOnce(8)
      .mockResolvedValueOnce(14);
    levelsRepo.findOne
      .mockResolvedValueOnce({ proficiencyBonus: 2 })
      .mockResolvedValueOnce({ proficiencyBonus: 2 });
    classSpellsRepo.find.mockResolvedValue([
      { spellSlug: 'fire-bolt', spellName: 'Raio de Fogo', spellLevel: 0 },
      { spellSlug: 'magic-missile', spellName: 'Míssil Mágico', spellLevel: 1 },
      { spellSlug: 'fireball', spellName: 'Bola de Fogo', spellLevel: 3 },
    ]);
    subclassSpellsRepo.find.mockResolvedValue([]);

    const preview = await service.buildPreview(pc);

    expect(sheetRepository.load).toHaveBeenCalledWith('ch1');
    expect(domain.calculateHitPointsMaxForCharacter).toHaveBeenCalledTimes(2);
    expect(levelsRepo.findOne).toHaveBeenCalledWith({ where: { level: 1 } });
    expect(levelsRepo.findOne).toHaveBeenCalledWith({ where: { level: 2 } });
    expect(classSpellsRepo.find).toHaveBeenCalledWith({
      where: { classSlug: 'wizard' },
      order: { spellLevel: 'ASC', spellName: 'ASC' },
    });
    expect(preview.currentLevel).toBe(1);
    expect(preview.nextLevel).toBe(2);
    expect(preview.estimatedHpGain).toBe(6);
    expect(preview.newSpellOptions.map((s) => s.spellSlug)).toEqual([
      'fire-bolt',
      'magic-missile',
    ]);
    expect(preview.newAlwaysPreparedSpells).toEqual([]);
    expect(preview.newSubclassOptionSlots).toEqual([]);
    expect(preview.newFeatures).toEqual([]);
  });

  it('does not treat subclass always-prepared as choosable spells', async () => {
    const pc = character({
      level: 12,
      classSlug: 'rogue',
      subclassSlug: 'blade-of-radiance',
    });
    sheetRepository.load.mockResolvedValue(asDep({ characterFeats: [] }));
    domain.calculateHitPointsMaxForCharacter
      .mockResolvedValueOnce(123)
      .mockResolvedValueOnce(133);
    levelsRepo.findOne
      .mockResolvedValueOnce({ proficiencyBonus: 4 })
      .mockResolvedValueOnce({ proficiencyBonus: 5 });
    jest
      .spyOn(levelUpCatalog, 'loadMaxSpellLevelForCharacter')
      .mockResolvedValue(0);
    jest
      .spyOn(levelUpCatalog, 'loadSubclassSpellListClassSlug')
      .mockResolvedValue(null);
    subclassSpellsRepo.find.mockResolvedValue([
      {
        spellSlug: 'heroismo',
        spellName: 'Heroísmo',
        unlockLevel: 13,
      },
      {
        spellSlug: 'escudo-da-fe',
        spellName: 'Escudo da Fé',
        unlockLevel: 13,
      },
    ]);
    dataSource.getRepository = jest.fn().mockReturnValue({
      findOne: jest.fn().mockResolvedValue({ id: 'sub1' }),
    });
    jest
      .spyOn(classOptionQueries, 'loadSubclassOptionSlotsNewAtLevel')
      .mockResolvedValue([
        {
          optionKey: 'holyRevelationCantrip1',
          label: 'Truque 1',
          unlockLevel: 13,
        },
        {
          optionKey: 'holyRevelationCantrip2',
          label: 'Truque 2',
          unlockLevel: 13,
        },
      ]);

    const preview = await service.buildPreview(pc);

    expect(preview.newSpellOptions).toEqual([]);
    expect(preview.newAlwaysPreparedSpells.map((s) => s.spellSlug)).toEqual([
      'heroismo',
      'escudo-da-fe',
    ]);
    expect(preview.newSubclassOptionSlots.map((s) => s.optionKey)).toEqual([
      'holyRevelationCantrip1',
      'holyRevelationCantrip2',
    ]);
  });
});
