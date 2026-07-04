import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { CharacterRepository } from '../shared/infrastructure/character.repository';
import { CharacterSheetRepository } from './infrastructure/character-sheet.repository';
import { CharacterMapper } from './infrastructure/character.mapper';
import { CreateCharacterHandler } from './application/create-character.handler';
import { GetCharacterQuery } from './application/get-character.query';
import { CharacterDomainService } from './domain/character-domain.service';
import { CharacterSheetValidator } from './domain/character-sheet.validator';
import { PlayerCharacter } from '../shared/infrastructure/player-character.entity';
import { CatalogLookupService } from '../../catalog/catalog-lookup.service';
import { EMPTY_SHEET_DATA } from './domain/character-sheet.types';

describe('Characters application layer', () => {
  let createHandler: CreateCharacterHandler;
  let getCharacter: GetCharacterQuery;
  let repo: {
    find: jest.Mock;
    findOne: jest.Mock;
    create: jest.Mock;
    save: jest.Mock;
    remove: jest.Mock;
  };
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'validateCharacterCatalogRefs'>>;
  let sheetValidator: jest.Mocked<
    Pick<
      CharacterSheetValidator,
      'validateSheetInput' | 'validateLevelRules' | 'validateCreateRequiredFields'
    >
  >;
  let sheetRepo: jest.Mocked<Pick<CharacterSheetRepository, 'sync' | 'load' | 'loadMany' | 'empty' | 'mergeSheetData'>>;
  let domain: jest.Mocked<Pick<CharacterDomainService, 'applyDerivedHitPoints' | 'getProficiencyBonus'>>;

  const userId = '11111111-1111-1111-1111-111111111111';
  const otherUserId = '22222222-2222-2222-2222-222222222222';

  const sample: PlayerCharacter = {
    id: '33333333-3333-3333-3333-333333333333',
    userId,
    name: 'Thorin',
    level: 1,
    classSlug: 'fighter',
    speciesSlug: 'dwarf',
    backgroundSlug: 'acolyte',
    subclassSlug: null,
    alignmentSlug: null,
    abilityScores: {
      forca: 10,
      destreza: 10,
      constituicao: 10,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 10,
    },
    hitPointsMax: 10,
    hitPointsCurrent: 10,
    abilityGenerationMethodSlug: null,
    createdAt: new Date(),
    updatedAt: new Date(),
  };

  beforeEach(async () => {
    repo = {
      find: jest.fn(),
      findOne: jest.fn(),
      create: jest.fn((data) => ({ ...sample, ...data }) as PlayerCharacter),
      save: jest.fn(async (entity: PlayerCharacter) => entity),
      remove: jest.fn(),
    };
    catalogLookup = { validateCharacterCatalogRefs: jest.fn().mockResolvedValue(undefined) };
    sheetValidator = {
      validateSheetInput: jest.fn().mockResolvedValue(undefined),
      validateLevelRules: jest.fn().mockResolvedValue(undefined),
      validateCreateRequiredFields: jest.fn().mockResolvedValue(undefined),
    };
    sheetRepo = {
      sync: jest.fn().mockResolvedValue(undefined),
      load: jest.fn().mockResolvedValue(EMPTY_SHEET_DATA),
      loadMany: jest.fn().mockResolvedValue(new Map()),
      empty: jest.fn().mockReturnValue(EMPTY_SHEET_DATA),
      mergeSheetData: jest.fn((base, slug) => ({ ...base, abilityGenerationMethodSlug: slug })),
    };
    domain = {
      applyDerivedHitPoints: jest.fn(async (entity) => {
        if (entity.hitPointsMax === null) {
          entity.hitPointsMax = 10;
          entity.hitPointsCurrent = 10;
        }
      }),
      getProficiencyBonus: jest.fn().mockResolvedValue(2),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        CharacterRepository,
        CharacterMapper,
        CreateCharacterHandler,
        GetCharacterQuery,
        { provide: getRepositoryToken(PlayerCharacter), useValue: repo },
        { provide: CatalogLookupService, useValue: catalogLookup },
        { provide: CharacterSheetValidator, useValue: sheetValidator },
        { provide: CharacterSheetRepository, useValue: sheetRepo },
        { provide: CharacterDomainService, useValue: domain },
      ],
    }).compile();

    createHandler = module.get(CreateCharacterHandler);
    getCharacter = module.get(GetCharacterQuery);
  });

  it('create validates catalog slugs', async () => {
    await createHandler.execute(userId, {
      name: 'Thorin',
      classSlug: 'fighter',
      speciesSlug: 'dwarf',
      backgroundSlug: 'acolyte',
    });
    expect(catalogLookup.validateCharacterCatalogRefs).toHaveBeenCalled();
    expect(domain.applyDerivedHitPoints).toHaveBeenCalled();
  });

  it('create persists requested starting level', async () => {
    await createHandler.execute(userId, {
      name: 'Veteran',
      level: 7,
      classSlug: 'fighter',
      speciesSlug: 'dwarf',
      backgroundSlug: 'acolyte',
      subclassSlug: 'champion',
    });

    expect(sheetValidator.validateLevelRules).toHaveBeenCalledWith(
      expect.objectContaining({ level: 7 }),
    );
    expect(repo.create).toHaveBeenCalledWith(
      expect.objectContaining({ level: 7 }),
    );
  });

  it('create persists class skill choices when provided', async () => {
    const result = await createHandler.execute(userId, {
      name: 'Thorin',
      classSlug: 'fighter',
      speciesSlug: 'dwarf',
      backgroundSlug: 'acolyte',
      classSkillSlugs: ['athletics', 'perception'],
    });

    expect(sheetValidator.validateSheetInput).toHaveBeenCalled();
    expect(sheetRepo.sync).toHaveBeenCalledWith(
      sample.id,
      expect.objectContaining({ classSkillSlugs: ['athletics', 'perception'] }),
    );
    expect(result.classSkillSlugs).toEqual([]);
  });

  it('findOwnedOrFail throws ForbiddenException for other user', async () => {
    repo.findOne.mockResolvedValue({ ...sample, userId: otherUserId });
    await expect(getCharacter.execute(userId, sample.id)).rejects.toThrow(ForbiddenException);
  });

  it('findOwnedOrFail throws NotFoundException when missing', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(getCharacter.execute(userId, sample.id)).rejects.toThrow(NotFoundException);
  });
});
