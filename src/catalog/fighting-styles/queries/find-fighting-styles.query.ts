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
  ): Promise<PaginatedResponseDto<FightingStyleResponseDto>> {
    const qb = this.stylesRepo
      .createQueryBuilder('style')
      .orderBy('style.name', 'ASC');

    const trimmedClass = classSlug?.trim();
    if (trimmedClass) {
      qb.andWhere(
        `EXISTS (
          SELECT 1
          FROM rpg.phb_class_fighting_style cfs
          JOIN rpg.phb_class c ON c.id = cfs.class_id
          WHERE cfs.fighting_style_id = style.id
            AND c.slug = :classSlug
        )`,
        { classSlug: trimmedClass },
      );
    }

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toDto(row)), meta };
  }
}
