import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { SpellsService } from './spells.service';
import { VPhbSpell } from '../../entities/views/v-phb-spell.entity';

describe('SpellsService', () => {
  let service: SpellsService;
  let repo: jest.Mocked<Pick<Repository<VPhbSpell>, 'find' | 'findOne'>>;

  const sample: VPhbSpell = {
    slug: 'alarme',
    name: 'Alarme',
    level: 1,
    levelLabel: '1º Círculo',
    schoolSlug: 'abjuracao',
    schoolName: 'Abjuração',
    castingTime: '1 minuto ou Ritual',
    range: '9 metros',
    hasVerbal: true,
    hasSomatic: true,
    hasMaterial: true,
    materialDescription: 'um sino e um fio de prata',
    componentsLabel: 'V, S, M (um sino e um fio de prata)',
    duration: '8 horas',
    concentration: false,
    ritual: true,
    description: 'Você define um alarme contra intrusão.',
    higherLevels: null,
    sourceChapter: 7,
    editionSlug: 'phb-2024-pt',
  };

  beforeEach(async () => {
    repo = { find: jest.fn(), findOne: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SpellsService,
        { provide: getRepositoryToken(VPhbSpell), useValue: repo },
      ],
    }).compile();
    service = module.get(SpellsService);
  });

  it('findAll returns paginated data', async () => {
    repo.find.mockResolvedValue([sample]);
    const result = await service.findAll(1, 20);
    expect(result.data[0].slug).toBe('alarme');
    expect(result.meta.total).toBe(1);
  });

  it('findBySlug returns dto', async () => {
    repo.findOne.mockResolvedValue(sample);
    const result = await service.findBySlug('alarme');
    expect(result.name).toBe('Alarme');
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(service.findBySlug('invalid')).rejects.toThrow(NotFoundException);
  });
});
