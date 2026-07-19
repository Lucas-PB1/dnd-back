import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { VPhbSpell } from '../../entities/views/v-phb-spell.entity';
import { SpellsMapper } from './spells.mapper';
import { FindSpellsQuery } from './queries/find-spells.query';
import { FindSpellBySlugQuery } from './queries/find-spell-by-slug.query';

describe('Spells queries', () => {
  let findSpells: FindSpellsQuery;
  let findSpellBySlug: FindSpellBySlugQuery;
  let repo: jest.Mocked<
    Pick<Repository<VPhbSpell>, 'findOne' | 'createQueryBuilder'>
  >;

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

  function mockQb(rows: VPhbSpell[], total: number) {
    return {
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      skip: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getCount: jest.fn().mockResolvedValue(total),
      getMany: jest.fn().mockResolvedValue(rows),
    };
  }

  beforeEach(async () => {
    repo = {
      findOne: jest.fn(),
      createQueryBuilder: jest.fn(),
    };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SpellsMapper,
        FindSpellsQuery,
        FindSpellBySlugQuery,
        { provide: getRepositoryToken(VPhbSpell), useValue: repo },
      ],
    }).compile();

    findSpells = module.get(FindSpellsQuery);
    findSpellBySlug = module.get(FindSpellBySlugQuery);
  });

  it('findAll returns paginated data', async () => {
    repo.createQueryBuilder.mockReturnValue(mockQb([sample], 1) as never);
    const result = await findSpells.execute(1, 20);
    expect(result.data[0].slug).toBe('alarme');
    expect(result.meta.total).toBe(1);
  });

  it('findAll applies search filter', async () => {
    const qb = mockQb([sample], 1);
    repo.createQueryBuilder.mockReturnValue(qb as never);
    await findSpells.execute(1, 20, 'alarme');
    expect(qb.andWhere).toHaveBeenCalled();
  });

  it('findBySlug returns dto', async () => {
    repo.findOne.mockResolvedValue(sample);
    const result = await findSpellBySlug.execute('alarme');
    expect(result.name).toBe('Alarme');
  });

  it('findBySlug throws NotFoundException', async () => {
    repo.findOne.mockResolvedValue(null);
    await expect(findSpellBySlug.execute('invalid')).rejects.toThrow(NotFoundException);
  });
});
