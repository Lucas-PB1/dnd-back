import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSubclass } from '../../../entities/views/v-phb-subclass.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { SubclassResponseDto } from '../dto/subclass-response.dto';
import { SubclassesMapper } from '../subclasses.mapper';

@Injectable()
export class FindSubclassesQuery {
  constructor(
    @InjectRepository(VPhbSubclass)
    private readonly subclassesRepo: Repository<VPhbSubclass>,
    private readonly mapper: SubclassesMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    classSlug?: string,
  ): Promise<PaginatedResponseDto<SubclassResponseDto>> {
    const qb = this.subclassesRepo
      .createQueryBuilder('sc')
      .orderBy('sc.className', 'ASC')
      .addOrderBy('sc.subclassName', 'ASC');

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

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toSubclassDto(row)), meta };
  }
}
