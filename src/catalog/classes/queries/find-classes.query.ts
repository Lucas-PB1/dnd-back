import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '../../../entities/views/v-phb-class.entity';
import {
  applyEditionSlugFilter,
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { ClassResponseDto } from '../dto/class-response.dto';
import { ClassSummaryResponseDto } from '../dto/class-summary-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassesQuery {
  constructor(
    @InjectRepository(VPhbClass)
    private readonly classesRepo: Repository<VPhbClass>,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    editionSlugs?: string[],
    fields?: 'summary',
  ): Promise<PaginatedResponseDto<ClassResponseDto | ClassSummaryResponseDto>> {
    const qb = this.classesRepo
      .createQueryBuilder('klass')
      .orderBy('klass.className', 'ASC');

    if (fields === 'summary') {
      qb.select([
        'klass.classSlug',
        'klass.className',
        'klass.editionSlug',
      ]);
    }

    applyIlikeSearch(qb, [
      'klass.className',
      'klass.classSlug',
      "COALESCE(klass.tagline, '')",
      "COALESCE(klass.summary, '')",
    ], q);
    applyEditionSlugFilter(qb, 'klass.editionSlug', editionSlugs);

    const { rows, meta } = await paginateQb(qb, page, limit);
    const data =
      fields === 'summary'
        ? rows.map((row) => this.mapper.toClassSummaryDto(row))
        : rows.map((row) => this.mapper.toClassDto(row));
    return { data, meta };
  }
}
