import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbFightingStyle } from '../../../entities/phb-fighting-style.entity';
import {
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { FightingStyleResponseDto } from '../dto/fighting-style-response.dto';
import { FightingStylesMapper } from '../fighting-styles.mapper';

@Injectable()
export class FindFightingStylesQuery {
  constructor(
    @InjectRepository(PhbFightingStyle)
    private readonly stylesRepo: Repository<PhbFightingStyle>,
    private readonly mapper: FightingStylesMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    classSlug?: string,
    q?: string,
  ): Promise<PaginatedResponseDto<FightingStyleResponseDto>> {
    const qb = this.stylesRepo
      .createQueryBuilder('style')
      .orderBy('style.name', 'ASC');

    const trimmedQ = q?.trim();
    if (trimmedQ) {
      qb.andWhere(
        '(style.slug ILIKE :q OR style.name ILIKE :q OR style.description ILIKE :q)',
        { q: `%${trimmedQ}%` },
      );
    }

    const trimmedClass = classSlug?.trim();
    if (trimmedClass) {
      qb.andWhere(
        `EXISTS (
          SELECT 1
          FROM rpg.phb_class_proficiency cp
          JOIN rpg.phb_class c ON c.id = cp.class_id
          WHERE cp.ref_id = style.id
            AND cp.kind = 'fighting_style'::rpg.class_proficiency_kind
            AND c.slug = :classSlug
        )`,
        { classSlug: trimmedClass },
      );
    }

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toDto(row)), meta };
  }
}
