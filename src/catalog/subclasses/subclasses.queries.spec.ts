import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VPhbSubclassMechanics } from '../../entities/views/v-phb-subclass-mechanics.entity';
import { VPhbSubclassPreparedSpell } from '../../entities/views/v-phb-subclass-prepared-spell.entity';
import { CatalogLookupService } from '../catalog-lookup.service';
import { SubclassesMapper } from './subclasses.mapper';
import { FindSubclassBySlugQuery } from './queries/find-subclass-by-slug.query';
import { FindSubclassMechanicsQuery } from './queries/find-subclass-mechanics.query';
import { FindSubclassSpellsQuery } from './queries/find-subclass-spells.query';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';

describe('Subclasses queries', () => {
  let findSubclassBySlug: FindSubclassBySlugQuery;
  let findSubclassMechanics: FindSubclassMechanicsQuery;
  let findSubclassSpells: FindSubclassSpellsQuery;
  let mechanicsRepo: jest.Mocked<Pick<Repository<VPhbSubclassMechanics>, 'find'>>;
  let spellsRepo: jest.Mocked<Pick<Repository<VPhbSubclassPreparedSpell>, 'find'>>;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'findSubclassOrFail'>>;

  const sampleSubclass: VPhbSubclass = {
    subclassSlug: 'champion',
    subclassName: 'Campeão',
    classSlug: 'fighter',
    className: 'Guerreiro',
    tagline: 'Busque o auge da proeza no combate',
    summary: 'Buscar o auge da proeza no combate.',
    sourceChapter: 3,
    editionSlug: 'phb-2024-pt',
    spellSourceSlug: null,
    spellSourceLabel: null,
  };

  const sampleMechanic: VPhbSubclassMechanics = {
    classSlug: 'fighter',
    subclassSlug: 'champion',
    featureLevel: 3,
    featureName: 'Atleta Extraordinário',
    featureKind: 'passive',
    optionKey: null,
    resourceSlug: null,
    resourceName: null,
    resourceUnlockLevel: null,
    maxFormula: null,
    fixedMax: null,
  };

  const sampleSpell: VPhbSubclassPreparedSpell = {
    subclassSlug: 'life',
    unlockLevel: 3,
    spellSlug: 'curar-ferimentos',
    spellName: 'Curar Ferimentos',
    terrainSlug: null,
    terrainLabel: null,
  };

  beforeEach(async () => {
    mechanicsRepo = { find: jest.fn() };
    spellsRepo = { find: jest.fn() };
    catalogLookup = {
      findSubclassOrFail: jest.fn(async (slug) => {
        if (slug === 'invalid') throw new NotFoundException();
        if (slug === 'life') {
          return { ...sampleSubclass, subclassSlug: 'life', subclassName: 'Vida' };
        }
        return sampleSubclass;
      }),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SubclassesMapper,
        FindSubclassBySlugQuery,
        FindSubclassMechanicsQuery,
        FindSubclassSpellsQuery,
        { provide: getRepositoryToken(VPhbSubclassMechanics), useValue: mechanicsRepo },
        { provide: getRepositoryToken(VPhbSubclassPreparedSpell), useValue: spellsRepo },
        { provide: CatalogLookupService, useValue: catalogLookup },
      ],
    }).compile();

    findSubclassBySlug = module.get(FindSubclassBySlugQuery);
    findSubclassMechanics = module.get(FindSubclassMechanicsQuery);
    findSubclassSpells = module.get(FindSubclassSpellsQuery);
  });

  it('findBySlug returns dto', async () => {
    const result = await findSubclassBySlug.execute('champion');
    expect(result.name).toBe('Campeão');
    expect(result.classSlug).toBe('fighter');
  });

  it('findBySlug throws NotFoundException', async () => {
    await expect(findSubclassBySlug.execute('invalid')).rejects.toThrow(NotFoundException);
  });

  it('findMechanics returns paginated mechanics', async () => {
    mechanicsRepo.find.mockResolvedValue([sampleMechanic]);
    const result = await findSubclassMechanics.execute('champion', 1, 20);
    expect(result.data[0].featureName).toBe('Atleta Extraordinário');
  });

  it('findMechanics throws when empty', async () => {
    mechanicsRepo.find.mockResolvedValue([]);
    await expect(findSubclassMechanics.execute('champion')).rejects.toThrow(NotFoundException);
  });

  it('findSpells returns paginated spells', async () => {
    spellsRepo.find.mockResolvedValue([sampleSpell]);
    const result = await findSubclassSpells.execute('life', 1, 20);
    expect(result.data[0].slug).toBe('curar-ferimentos');
  });

  it('findSpells throws when empty', async () => {
    spellsRepo.find.mockResolvedValue([]);
    await expect(findSubclassSpells.execute('life')).rejects.toThrow(NotFoundException);
  });
});
