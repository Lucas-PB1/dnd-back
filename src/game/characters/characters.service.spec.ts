import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { ForbiddenException, NotFoundException } from '@nestjs/common';
import { CharactersService } from './characters.service';
import { PlayerCharacter } from './player-character.entity';
import { CatalogLookupService } from '../../catalog/catalog-lookup.service';

describe('CharactersService', () => {
  let service: CharactersService;
  let repo: {
    find: jest.Mock;
    findOne: jest.Mock;
    create: jest.Mock;
    save: jest.Mock;
    remove: jest.Mock;
  };
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'validateCharacterCatalogRefs'>>;

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
    hitPointsMax: null,
    hitPointsCurrent: null,
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

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        CharactersService,
        { provide: getRepositoryToken(PlayerCharacter), useValue: repo },
        { provide: CatalogLookupService, useValue: catalogLookup },
      ],
    }).compile();
    service = module.get(CharactersService);
  });

  it('create validates catalog slugs', async () => {
    await service.create(userId, {
      name: 'Thorin',
      classSlug: 'fighter',
      speciesSlug: 'dwarf',
      backgroundSlug: 'acolyte',
    });
    expect(catalogLookup.validateCharacterCatalogRefs).toHaveBeenCalled();
  });

  it('findOneForUser throws ForbiddenException for other user', async () => {
    repo.findOne.mockResolvedValue({ ...sample, userId: otherUserId });
    await expect(service.findOneForUser(userId, sample.id)).rejects.toThrow(ForbiddenException);
  });

  it('findOneForUser throws NotFoundException when missing', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(service.findOneForUser(userId, sample.id)).rejects.toThrow(NotFoundException);
  });
});
