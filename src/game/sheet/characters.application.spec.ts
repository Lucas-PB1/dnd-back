import { beforeEach, describe, expect, it } from '@jest/globals';
import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { CharacterRepository } from '../shared/infrastructure/character.repository';
import { CharacterSheetRepository } from './infrastructure/character-sheet.repository';
import { CharacterMapper } from './infrastructure/character.mapper';
import { ResolveEquippedArmorClass } from '../combat/application/resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from '../combat/application/resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from '../combat/application/resolve-equipment-compliance';
import { ResolveActivePermanentItemEffects } from '../inventory/application/resolve-active-permanent-item-effects';
import { CreateCharacterHandler } from './application/create-character.handler';
import { GetCharacterQuery } from './application/get-character.query';
import { CharacterDomainService } from './domain/core/character-domain.service';
import { CharacterSheetValidator } from './domain/validation/character-sheet.validator';
import { PlayerCharacter } from '../shared/infrastructure/player-character.entity';
import { PlayerCharacterItem } from '../inventory/infrastructure/player-character-item.entity';
import { PhbSpecies } from '@entities/phb-species.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { EMPTY_SHEET_DATA } from './domain/character-sheet.types';
import { SeedStartingInventoryHandler } from '../inventory/application/seed-starting-inventory.handler';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { LoadGrantedSpellCatalog } from '../spellcasting/application/load-granted-spell-catalog';
import { CampaignCharacterAccessService } from '../campaign/infrastructure/campaign-character-access.service';
import { CampaignService } from '../campaign/application/campaign.service';

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
  let catalogLookup: jest.Mocked<
    Pick<
      CatalogLookupService,
      'validateCharacterCatalogRefs' | 'findBackgroundOrFail' | 'findEpicBoonFeatSlugs'
    >
  >;
  let sheetValidator: jest.Mocked<
    Pick<
      CharacterSheetValidator,
      | 'validateSheetInput'
      | 'validateLevelRules'
      | 'validateCreateRequiredFields'
      | 'validateBackgroundAbilityBoosts'
      | 'validateBackgroundToolChoice'
      | 'validateBackgroundOriginFeat'
      | 'resolveStartingGold'
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
    backgroundBoostMode: 'plus2plus1',
    backgroundBoostPlus2AbilitySlug: null,
    backgroundBoostPlus1AbilitySlug: null,
    backgroundBoostPlus1Slugs: null,
    backgroundToolItemSlug: null,
    coinCopper: 0,
    coinSilver: 0,
    coinElectrum: 0,
    coinGold: 0,
    coinPlatinum: 0,
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
    catalogLookup = {
      validateCharacterCatalogRefs: jest.fn().mockResolvedValue(undefined),
      findEpicBoonFeatSlugs: jest.fn().mockResolvedValue(new Set<string>()),
      findBackgroundOrFail: jest.fn().mockResolvedValue({
        backgroundSlug: 'acolyte',
        featSlug: 'magic-initiate',
        toolProficiencyKind: 'fixed',
        toolItemSlug: 'suprimentos-de-caligrafo',
        abilityOptionSlugs: [],
      }),
    };
    sheetValidator = {
      validateSheetInput: jest.fn().mockResolvedValue(undefined),
      validateLevelRules: jest.fn().mockResolvedValue(undefined),
      validateCreateRequiredFields: jest.fn().mockResolvedValue(undefined),
      validateBackgroundAbilityBoosts: jest.fn().mockResolvedValue(undefined),
      validateBackgroundToolChoice: jest.fn().mockResolvedValue(undefined),
      validateBackgroundOriginFeat: jest.fn().mockResolvedValue(undefined),
      resolveStartingGold: jest.fn().mockResolvedValue(0),
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
        {
          provide: DataSource,
          useValue: {
            query: jest.fn().mockResolvedValue([{ ok: 1 }]),
          },
        },
        { provide: getRepositoryToken(PlayerCharacter), useValue: repo },
        { provide: CatalogLookupService, useValue: catalogLookup },
        { provide: CharacterSheetValidator, useValue: sheetValidator },
        { provide: CharacterSheetRepository, useValue: sheetRepo },
        { provide: CharacterDomainService, useValue: domain },
        {
          provide: ResolveEquippedArmorClass,
          useValue: {
            resolve: jest.fn().mockResolvedValue({
              armorClass: 10,
              armorClassNote: 'Sem armadura',
            }),
          },
        },
        {
          provide: ResolveEquippedWeaponAttacks,
          useValue: {
            resolve: jest.fn().mockResolvedValue([]),
          },
        },
        {
          provide: ResolveEquipmentCompliance,
          useValue: {
            resolve: jest.fn().mockResolvedValue({
              lacksArmorTraining: false,
              strengthPenalty: null,
              stealthDisadvantage: false,
              cannotCastSpells: false,
              strDexTestDisadvantage: false,
              speedPenaltyMeters: 0,
              warnings: [],
            }),
          },
        },
        {
          provide: ResolveActivePermanentItemEffects,
          useValue: {
            resolve: jest.fn().mockResolvedValue({
              acBonus: 0,
              attackBonus: 0,
              damageBonus: 0,
              abilityBonuses: {},
              savingThrowBonuses: {},
              speedBonusMeters: 0,
              hpBonus: 0,
              sourceNames: [],
            }),
          },
        },
        {
          provide: getRepositoryToken(PhbSpecies),
          useValue: {
            findOne: jest.fn().mockResolvedValue({
              slug: 'dwarf',
              size: 'Médio (cerca de 1,20-1,50 metro de altura)',
            }),
          },
        },
        {
          provide: getRepositoryToken(PlayerCharacterItem),
          useValue: {
            exist: jest.fn().mockResolvedValue(false),
            find: jest.fn().mockResolvedValue([]),
          },
        },
        {
          provide: getRepositoryToken(VPhbSubclassPreparedSpell),
          useValue: { find: jest.fn().mockResolvedValue([]) },
        },
        {
          provide: LoadGrantedSpellCatalog,
          useValue: {
            loadMergeCatalog: jest.fn().mockResolvedValue({
              speciesCatalog: [],
              featFixedSpells: [],
            }),
            loadSpeciesCatalog: jest.fn().mockResolvedValue([]),
            loadFeatFixedSpells: jest.fn().mockResolvedValue([]),
          },
        },
        {
          provide: SeedStartingInventoryHandler,
          useValue: { execute: jest.fn().mockResolvedValue(undefined) },
        },
        {
          provide: CampaignCharacterAccessService,
          useValue: { hasAccess: jest.fn().mockResolvedValue(false) },
        },
        {
          provide: CampaignService,
          useValue: {
            listCampaignRefsByCharacterIds: jest
              .fn()
              .mockResolvedValue(new Map()),
          },
        },
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
      backgroundAbilityBoostPlus2Slug: 'sabedoria',
      backgroundAbilityBoostPlus1Slug: 'carisma',
    });
    expect(catalogLookup.validateCharacterCatalogRefs).toHaveBeenCalled();
    expect(domain.applyDerivedHitPoints).toHaveBeenCalled();
  });

  it('create forwards feat slugs to the hit points calculation', async () => {
    await createHandler.execute(userId, {
      name: 'Thorin',
      classSlug: 'fighter',
      speciesSlug: 'dwarf',
      backgroundSlug: 'acolyte',
      backgroundAbilityBoostPlus2Slug: 'sabedoria',
      backgroundAbilityBoostPlus1Slug: 'carisma',
      characterFeats: [{ featSlug: 'tough', instanceIndex: 0 }],
    });

    expect(domain.applyDerivedHitPoints).toHaveBeenCalledWith(
      expect.anything(),
      expect.anything(),
      expect.arrayContaining(['tough']),
    );
  });

  it('create persists requested starting level', async () => {
    await createHandler.execute(userId, {
      name: 'Veteran',
      level: 7,
      classSlug: 'fighter',
      speciesSlug: 'dwarf',
      backgroundSlug: 'acolyte',
      subclassSlug: 'champion',
      backgroundAbilityBoostPlus2Slug: 'sabedoria',
      backgroundAbilityBoostPlus1Slug: 'carisma',
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
      backgroundAbilityBoostPlus2Slug: 'sabedoria',
      backgroundAbilityBoostPlus1Slug: 'carisma',
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
