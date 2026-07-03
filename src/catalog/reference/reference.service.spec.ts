import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ReferenceService } from './reference.service';
import { PhbAlignment } from '../../entities/phb-alignment.entity';
import { PhbLanguage } from '../../entities/phb-language.entity';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';

describe('ReferenceService', () => {
  let service: ReferenceService;
  let alignmentsRepo: jest.Mocked<Pick<Repository<PhbAlignment>, 'find'>>;
  let languagesRepo: jest.Mocked<Pick<Repository<PhbLanguage>, 'find'>>;
  let levelsRepo: jest.Mocked<Pick<Repository<PhbCharacterLevel>, 'find'>>;

  beforeEach(async () => {
    alignmentsRepo = { find: jest.fn() };
    languagesRepo = { find: jest.fn() };
    levelsRepo = { find: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ReferenceService,
        { provide: getRepositoryToken(PhbAlignment), useValue: alignmentsRepo },
        { provide: getRepositoryToken(PhbLanguage), useValue: languagesRepo },
        { provide: getRepositoryToken(PhbCharacterLevel), useValue: levelsRepo },
      ],
    }).compile();
    service = module.get(ReferenceService);
  });

  it('findAllAlignments returns paginated data', async () => {
    alignmentsRepo.find.mockResolvedValue([
      { id: '1', slug: 'lawful-good', name: 'Ordeiro e Bom', abbreviation: 'OB', description: null },
    ]);
    const result = await service.findAllAlignments(1, 20);
    expect(result.data[0].slug).toBe('lawful-good');
  });

  it('findAllCharacterLevels returns 20 levels', async () => {
    levelsRepo.find.mockResolvedValue([{ level: 1, proficiencyBonus: 2, xpThreshold: 0 }]);
    const result = await service.findAllCharacterLevels(1, 20);
    expect(result.data[0].level).toBe(1);
  });
});
