import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSubclass } from '@entities/views/v-phb-subclass.entity';
import {
  applyEditionSlugFilter,
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import { SubclassResponseDto } from '../dto/subclass-response.dto';
import { SubclassesMapper } from '../subclasses.mapper';

const SUBCLASS_CURSOR_KEYS = [
  { expr: 'sc.className', name: 'className' },
  { expr: 'sc.subclassName', name: 'subclassName' },
  { expr: 'sc.subclassSlug', name: 'subclassSlug' },
] as const;

@Injectable()
export class FindSubclassesQuery {
  constructor(
    @InjectRepository(VPhbSubclass)
    private readonly subclassesRepo: Repository<VPhbSubclass>,
    private readonly mapper: SubclassesMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    classSlug?: string,
    editionSlugs?: string[],
  ): Promise<PaginatedResponseDto<SubclassResponseDto>> {
    const qb = this.subclassesRepo
      .createQueryBuilder('sc')
      .orderBy('sc.className', 'ASC')
      .addOrderBy('sc.subclassName', 'ASC')
      .addOrderBy('sc.subclassSlug', 'ASC');

    applyIlikeSearch(qb, [
      'sc.subclassName',
      'sc.subclassSlug',
      'sc.className',
      'sc.classSlug',
      "COALESCE(sc.tagline, '')",
      "COALESCE(sc.summary, '')",
    ], q);

    const klass = classSlug?.trim();
    if (klass) {
      qb.andWhere('sc.classSlug = :classSlug', { classSlug: klass });
    }
    applyEditionSlugFilter(qb, 'sc.editionSlug', editionSlugs);

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: SUBCLASS_CURSOR_KEYS,
      encodeRow: (row) => ({
        className: row.className,
        subclassName: row.subclassName,
        subclassSlug: row.subclassSlug,
      }),
    });
    return { data: rows.map((row) => this.mapper.toSubclassDto(row)), meta };
  }
}
