import { BadRequestException } from '@nestjs/common';
import { LevelUpService } from './level-up.service';
import type { CharacterDomainService } from '../../sheet/domain/core/character-domain.service';
import type { CharacterSheetRepository } from '../../sheet/infrastructure/character-sheet.repository';
import type { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import type { PlayerCharacter } from '../../shared/infrastructure/player-character.entity';

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
  let dataSource: { query: jest.Mock };
  let catalogLookup: CatalogLookupService;
  let domain: jest.Mocked<Pick<CharacterDomainService, 'calculateHitPointsMaxForCharacter'>>;
  let sheetRepository: jest.Mocked<Pick<CharacterSheetRepository, 'load'>>;
  let levelsRepo: Repo;
  let classSpellsRepo: Repo;
  let subclassSpellsRepo: Repo;
  let spellSlotsRepo: Repo;
  let subclassSpellSlotsRepo: Repo;

  beforeEach(() => {
    dataSource = { query: jest.fn() };
    catalogLookup = {} as CatalogLookupService;
    domain = { calculateHitPointsMaxForCharacter: jest.fn() };
    sheetRepository = { load: jest.fn() };
    levelsRepo = repo();
    classSpellsRepo = repo();
    subclassSpellsRepo = repo();
    spellSlotsRepo = repo();
    subclassSpellSlotsRepo = repo();

    service = new LevelUpService(
      dataSource as never,
      catalogLookup,
      domain as never,
      sheetRepository as never,
      levelsRepo as never,
      classSpellsRepo as never,
      subclassSpellsRepo as never,
      spellSlotsRepo as never,
      subclassSpellSlotsRepo as never,
    );
  });

  it('throws when character is already at max level', async () => {
    await expect(
      service.buildPreview(character({ level: 20 })),
    ).rejects.toThrow(new BadRequestException('Character is already at maximum level'));
  });

  it('buildPreview returns hp, pb, spells and mastery slots', async () => {
    const pc = character();
    sheetRepository.load.mockResolvedValue({
      characterFeats: [{ featSlug: 'alert' }],
    } as never);
    domain.calculateHitPointsMaxForCharacter
      .mockResolvedValueOnce(8)
      .mockResolvedValueOnce(14);
    levelsRepo.findOne
      .mockResolvedValueOnce({ proficiencyBonus: 2 })
      .mockResolvedValueOnce({ proficiencyBonus: 2 });
    dataSource.query.mockImplementation(async (sql: string) => {
      if (sql.includes('subclass_unlock_level')) return [{ subclass_unlock_level: 3 }];
      return [
        { level: 1, weaponMastery: null },
        { level: 2, weaponMastery: null },
      ];
    });
    spellSlotsRepo.findOne.mockResolvedValue({
      spellSlots: { '1': 2 },
    });
    classSpellsRepo.find.mockResolvedValue([
      { spellSlug: 'fire-bolt', spellName: 'Raio de Fogo', spellLevel: 0 },
      { spellSlug: 'magic-missile', spellName: 'Míssil Mágico', spellLevel: 1 },
      { spellSlug: 'fireball', spellName: 'Bola de Fogo', spellLevel: 3 },
    ]);

    const preview = await service.buildPreview(pc);

    expect(sheetRepository.load).toHaveBeenCalledWith('ch1');
    expect(domain.calculateHitPointsMaxForCharacter).toHaveBeenCalledTimes(2);
    expect(levelsRepo.findOne).toHaveBeenCalledWith({ where: { level: 1 } });
    expect(levelsRepo.findOne).toHaveBeenCalledWith({ where: { level: 2 } });
    expect(classSpellsRepo.find).toHaveBeenCalledWith({
      where: { classSlug: 'wizard' },
      order: { spellLevel: 'ASC', spellName: 'ASC' },
    });
    expect(preview).toMatchObject({
      currentLevel: 1,
      nextLevel: 2,
      currentProficiencyBonus: 2,
      nextProficiencyBonus: 2,
      estimatedHpGain: 6,
      estimatedHitPointsMax: 14,
      subclassRequired: false,
      subclassUnlockLevel: 3,
      isAsiOrFeatLevel: false,
      newClassExpertiseSlots: [{ optionKey: 'expertiseSkill1', unlockLevel: 2 }],
      newWeaponMasterySlots: [],
    });
    expect(preview.newSpellOptions).toEqual([
      { spellSlug: 'fire-bolt', spellName: 'Raio de Fogo', spellLevel: 0 },
      { spellSlug: 'magic-missile', spellName: 'Míssil Mágico', spellLevel: 1 },
    ]);
  });
});
