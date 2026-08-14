import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackgroundLanguage } from '@entities/views/v-phb-background-language.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
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
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<BackgroundLanguageResponseDto>> {
    await this.catalogLookup.findBackgroundOrFail(backgroundSlug);
    const rows = await this.languagesRepo.find({
      where: { backgroundSlug },
      order: { languageName: 'ASC', languageSlug: 'ASC' },
    });
    requireNonEmpty(
      rows,
      `Background '${backgroundSlug}' has no fixed languages`,
    );
    return paginateByKeys(
      rows.map((row) => this.mapper.toLanguageDto(row)),
      {
        cursor,
        limit,
        keyNames: ['name', 'slug'],
        encodeRow: (row) => ({ name: row.name, slug: row.slug }),
      },
    );
  }
}
