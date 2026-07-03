import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbAlignment } from '../../entities/phb-alignment.entity';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';
import { ReferenceMapper } from './reference.mapper';
import { FindAlignmentsQuery } from './queries/find-alignments.query';
import { FindCharacterLevelsQuery } from './queries/find-character-levels.query';

describe('Reference queries', () => {
  let findAlignments: FindAlignmentsQuery;
  let findCharacterLevels: FindCharacterLevelsQuery;
  let alignmentsRepo: jest.Mocked<Pick<Repository<PhbAlignment>, 'find'>>;
  let levelsRepo: jest.Mocked<Pick<Repository<PhbCharacterLevel>, 'find'>>;

  beforeEach(async () => {
    alignmentsRepo = { find: jest.fn() };
    levelsRepo = { find: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ReferenceMapper,
        FindAlignmentsQuery,
        FindCharacterLevelsQuery,
        { provide: getRepositoryToken(PhbAlignment), useValue: alignmentsRepo },
        { provide: getRepositoryToken(PhbCharacterLevel), useValue: levelsRepo },
      ],
    }).compile();

    findAlignments = module.get(FindAlignmentsQuery);
    findCharacterLevels = module.get(FindCharacterLevelsQuery);
  });

  it('findAllAlignments returns paginated data', async () => {
    alignmentsRepo.find.mockResolvedValue([
      { id: '1', slug: 'lawful-good', name: 'Ordeiro e Bom', abbreviation: 'OB', description: null },
    ]);
    const result = await findAlignments.execute(1, 20);
    expect(result.data[0].slug).toBe('lawful-good');
  });

  it('findAllCharacterLevels returns levels', async () => {
    levelsRepo.find.mockResolvedValue([{ level: 1, proficiencyBonus: 2, xpThreshold: 0 }]);
    const result = await findCharacterLevels.execute(1, 20);
    expect(result.data[0].level).toBe(1);
  });
});
