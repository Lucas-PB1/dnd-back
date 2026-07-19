import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { requireFound } from '../../../common/require-found';
import { PhbLanguage } from '../../../entities/phb-language.entity';
import { LanguageResponseDto } from '../dto/language-response.dto';
import { ReferenceMapper } from '../reference.mapper';

@Injectable()
export class FindLanguageBySlugQuery {
  constructor(
    @InjectRepository(PhbLanguage)
    private readonly languagesRepo: Repository<PhbLanguage>,
    private readonly mapper: ReferenceMapper,
  ) {}

  async execute(slug: string): Promise<LanguageResponseDto> {
    const row = requireFound(
      await this.languagesRepo.findOne({ where: { slug } }),
      `Language not found: ${slug}`,
    );
    return this.mapper.toLanguageDto(row);
  }
}
