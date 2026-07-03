import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbLanguage } from '../../../entities/phb-language.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { LanguageResponseDto } from '../dto/language-response.dto';
import { ReferenceMapper } from '../reference.mapper';

@Injectable()
export class FindLanguagesQuery {
  constructor(
    @InjectRepository(PhbLanguage)
    private readonly languagesRepo: Repository<PhbLanguage>,
    private readonly mapper: ReferenceMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<LanguageResponseDto>> {
    const rows = await this.languagesRepo.find({ order: { name: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toLanguageDto(row)), page, limit);
  }
}
