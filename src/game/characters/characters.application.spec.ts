import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { CharacterRepository } from './infrastructure/character.repository';
import { CharacterMapper } from './infrastructure/character.mapper';
import { CreateCharacterHandler } from './application/create-character.handler';
import { GetCharacterQuery } from './application/get-character.query';
import { CharacterDomainService } from './domain/character-domain.service';
import { PlayerCharacter } from './infrastructure/player-character.entity';
import { CatalogLookupService } from '../../catalog/catalog-lookup.service';

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

  it('findOwnedOrFail throws ForbiddenException for other user', async () => {
    repo.findOne.mockResolvedValue({ ...sample, userId: otherUserId });
    await expect(getCharacter.execute(userId, sample.id)).rejects.toThrow(ForbiddenException);
  });

  it('findOwnedOrFail throws NotFoundException when missing', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(getCharacter.execute(userId, sample.id)).rejects.toThrow(NotFoundException);
  });
});
