import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '../../../entities/views/v-phb-class.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { ClassResponseDto } from '../dto/class-response.dto';
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
  ): Promise<PaginatedResponseDto<ClassResponseDto>> {
    const qb = this.classesRepo
      .createQueryBuilder('klass')
      .orderBy('klass.className', 'ASC');

    applyIlikeSearch(qb, [
      'klass.className',
      'klass.classSlug',
      "COALESCE(klass.tagline, '')",
      "COALESCE(klass.summary, '')",
    ], q);

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toClassDto(row)), meta };
  }
}
