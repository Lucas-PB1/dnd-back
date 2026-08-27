import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbCharacterThread } from '@entities/phb-character-thread.entity';
import { VPhbCharacterThreadBundle } from '@entities/views/v-phb-character-thread-bundle.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import {
  CharacterThreadResponseDto,
  CharacterThreadSummaryResponseDto,
} from '../dto/character-thread-response.dto';
import { CharacterThreadMapper } from '../character-thread.mapper';

const CURSOR_KEYS = [
  { expr: 'thread.sortOrder', name: 'sortOrder' },
  { expr: 'thread.slug', name: 'slug' },
] as const;

@Injectable()
export class FindCharacterThreadsQuery {
  constructor(
    @InjectRepository(PhbCharacterThread)
    private readonly threads: Repository<PhbCharacterThread>,
    private readonly mapper: CharacterThreadMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    editionSlugs?: string[],
    fields?: 'summary',
  ): Promise<
    PaginatedResponseDto<
      CharacterThreadResponseDto | CharacterThreadSummaryResponseDto
    >
  > {
    const qb = this.threads
      .createQueryBuilder('thread')
      .orderBy('thread.sortOrder', 'ASC')
      .addOrderBy('thread.slug', 'ASC');

    if (fields === 'summary') {
      qb.select([
        'thread.slug',
        'thread.name',
        'thread.editionSlug',
        'thread.summary',
        'thread.sortOrder',
      ]);
    }

    applyIlikeSearch(qb, ['thread.name', 'thread.slug', 'thread.summary'], q);

    const slugs = editionSlugs?.map((slug) => slug.trim()).filter(Boolean);
    if (slugs?.length) {
      qb.andWhere('thread.editionSlug IN (:...editionSlugs)', {
        editionSlugs: slugs,
      });
    }

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: CURSOR_KEYS,
      encodeRow: (row) => ({ sortOrder: row.sortOrder, slug: row.slug }),
    });

    const data = rows.map((row) => this.mapper.toSummaryDto(row));
    return { data, meta };
  }
}

@Injectable()
export class FindCharacterThreadBySlugQuery {
  constructor(
    @InjectRepository(VPhbCharacterThreadBundle)
    private readonly bundles: Repository<VPhbCharacterThreadBundle>,
    private readonly mapper: CharacterThreadMapper,
  ) {}

  async execute(slug: string): Promise<CharacterThreadResponseDto> {
    const row = await this.bundles.findOne({ where: { slug } });
    if (!row) {
      throw new NotFoundException(`Character thread '${slug}' not found`);
    }
    return this.mapper.toDto(row);
  }
}
