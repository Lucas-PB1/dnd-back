import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackground } from '../../entities/views/v-phb-background.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { BackgroundResponseDto } from './dto/background-response.dto';

@Injectable()
export class BackgroundsService {
  constructor(
    @InjectRepository(VPhbBackground)
    private readonly backgroundsRepo: Repository<VPhbBackground>,
  ) {}

  async findAll(page = 1, limit = 20): Promise<PaginatedResponseDto<BackgroundResponseDto>> {
    const rows = await this.backgroundsRepo.find({ order: { backgroundName: 'ASC' } });
    const dtos = rows.map((row) => this.toDto(row));
    return paginate(dtos, page, limit);
  }

  async findBySlug(slug: string): Promise<BackgroundResponseDto> {
    const row = await this.backgroundsRepo.findOne({ where: { backgroundSlug: slug } });
    if (!row) {
      throw new NotFoundException(`Background '${slug}' not found`);
    }
    return this.toDto(row);
  }

  private toDto(row: VPhbBackground): BackgroundResponseDto {
    return {
      slug: row.backgroundSlug,
      name: row.backgroundName,
      equipmentGoldOption: row.equipmentGoldOption,
      abilityOptionSlugs: row.abilityOptionSlugs ?? [],
      abilityOptionNames: row.abilityOptionNames ?? [],
      sourceChapter: row.sourceChapter,
      sourceChapterTitle: row.sourceChapterTitle,
      editionSlug: row.editionSlug,
    };
  }
}
