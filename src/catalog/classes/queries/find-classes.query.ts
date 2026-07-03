import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '../../../entities/views/v-phb-class.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { ClassResponseDto } from '../dto/class-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassesQuery {
  constructor(
    @InjectRepository(VPhbClass)
    private readonly classesRepo: Repository<VPhbClass>,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<ClassResponseDto>> {
    const rows = await this.classesRepo.find({ order: { className: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toClassDto(row)), page, limit);
  }
}
