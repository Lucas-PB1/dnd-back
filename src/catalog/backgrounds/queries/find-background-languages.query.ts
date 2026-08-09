import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackgroundLanguage } from '@entities/views/v-phb-background-language.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PaginatedResponseDto, paginateOrNotFound } from '@common/dto/pagination.dto';
import { BackgroundLanguageResponseDto } from '../dto/background-language-response.dto';
import { BackgroundsMapper } from '../backgrounds.mapper';

@Injectable()
export class FindBackgroundLanguagesQuery {
  constructor(
    @InjectRepository(VPhbBackgroundLanguage)
    private readonly languagesRepo: Repository<VPhbBackgroundLanguage>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: BackgroundsMapper,
  ) {}

  async execute(
    backgroundSlug: string,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<BackgroundLanguageResponseDto>> {
    await this.catalogLookup.findBackgroundOrFail(backgroundSlug);
    const rows = await this.languagesRepo.find({
      where: { backgroundSlug },
      order: { languageName: 'ASC' },
    });
    return paginateOrNotFound(
      rows,
      (row) => this.mapper.toLanguageDto(row),
      page,
      limit,
      `Background '${backgroundSlug}' has no fixed languages`,
    );
  }
}
