import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { VPhbSpell } from '@entities/views/v-phb-spell.entity';
import { SpellsMapper } from './spells.mapper';
import { FindSpellsQuery } from './queries/find-spells.query';
import { FindSpellBySlugQuery } from './queries/find-spell-by-slug.query';
import { asDep } from '@common/testing/as-dep';

describe('Spells queries', () => {
  let findSpells: FindSpellsQuery;
  let findSpellBySlug: FindSpellBySlugQuery;
  let repo: jest.Mocked<
    Pick<Repository<VPhbSpell>, 'findOne' | 'createQueryBuilder'>
  >;
  let catalogLookup: jest.Mocked<Pick<CatalogLookupService, 'findSpellOrFail'>>;

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
    saveAbilitySlug: null,
    requiresAttackRoll: false,
  };

  function mockQb(rows: VPhbSpell[], total: number) {
    return {
      select: jest.fn().mockReturnThis(),
      orderBy: jest.fn().mockReturnThis(),
      addOrderBy: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      take: jest.fn().mockReturnThis(),
      getMany: jest.fn().mockResolvedValue(rows),
    };
  }

  beforeEach(async () => {
    repo = {
      findOne: jest.fn(),
      createQueryBuilder: jest.fn(),
    };
    catalogLookup = { findSpellOrFail: jest.fn() };
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SpellsMapper,
        FindSpellsQuery,
        FindSpellBySlugQuery,
        { provide: getRepositoryToken(VPhbSpell), useValue: repo },
        { provide: CatalogLookupService, useValue: catalogLookup },
      ],
    }).compile();

    findSpells = module.get(FindSpellsQuery);
    findSpellBySlug = module.get(FindSpellBySlugQuery);
  });

  it('findAll returns paginated data', async () => {
    repo.createQueryBuilder.mockReturnValue(asDep(mockQb([sample], 1)));
    const result = await findSpells.execute({ limit: 20 });
    expect(result.data[0].slug).toBe('alarme');
    expect(result.meta.hasMore).toBe(false);
    expect(result.meta.nextCursor).toBeNull();
    expect(result.data[0]).toHaveProperty('description');
  });

  it('findAll with fields=summary omits description', async () => {
    const qb = mockQb([sample], 1);
    repo.createQueryBuilder.mockReturnValue(asDep(qb));
    const result = await findSpells.execute({
      limit: 20,
      fields: 'summary',
    });
    expect(qb.select).toHaveBeenCalled();
    expect(result.data[0]).toEqual({
      slug: 'alarme',
      name: 'Alarme',
      level: 1,
      levelLabel: '1º Círculo',
      schoolSlug: 'abjuracao',
      schoolName: 'Abjuração',
      castingTime: '1 minuto ou Ritual',
      range: '9 metros',
      ritual: true,
      concentration: false,
      editionSlug: 'phb-2024-pt',
      saveAbilitySlug: null,
      requiresAttackRoll: false,
    });
  });

  it('findAll applies search filter', async () => {
    const qb = mockQb([sample], 1);
    repo.createQueryBuilder.mockReturnValue(asDep(qb));
    await findSpells.execute({ limit: 20, q: 'alarme' });
    expect(qb.andWhere).toHaveBeenCalled();
  });

  it('findBySlug returns dto', async () => {
    catalogLookup.findSpellOrFail.mockResolvedValue(sample);
    const result = await findSpellBySlug.execute('alarme');
    expect(result.name).toBe('Alarme');
  });

  it('findBySlug throws NotFoundException', async () => {
    catalogLookup.findSpellOrFail.mockRejectedValue(new NotFoundException());
    await expect(findSpellBySlug.execute('invalid')).rejects.toThrow(
      NotFoundException,
    );
  });
});
