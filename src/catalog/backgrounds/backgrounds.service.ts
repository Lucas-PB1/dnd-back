import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackground } from '../../entities/views/v-phb-background.entity';
import { VPhbBackgroundEquipment } from '../../entities/views/v-phb-background-equipment.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { BackgroundResponseDto } from './dto/background-response.dto';
import { BackgroundEquipmentResponseDto } from './dto/background-equipment-response.dto';

@Injectable()
export class BackgroundsService {
  constructor(
    @InjectRepository(VPhbBackground)
    private readonly backgroundsRepo: Repository<VPhbBackground>,
    @InjectRepository(VPhbBackgroundEquipment)
    private readonly equipmentRepo: Repository<VPhbBackgroundEquipment>,
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

  async findEquipmentByBackgroundSlug(
    backgroundSlug: string,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<BackgroundEquipmentResponseDto>> {
    const background = await this.backgroundsRepo.findOne({ where: { backgroundSlug } });
    if (!background) {
      throw new NotFoundException(`Background '${backgroundSlug}' not found`);
    }

    const rows = await this.equipmentRepo.find({
      where: { backgroundSlug },
      order: { packageSlug: 'ASC', sortOrder: 'ASC' },
    });
    if (rows.length === 0) {
      throw new NotFoundException(`Background '${backgroundSlug}' has no starting equipment`);
    }
    return paginate(rows.map((row) => this.toEquipmentDto(row)), page, limit);
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

  private toEquipmentDto(row: VPhbBackgroundEquipment): BackgroundEquipmentResponseDto {
    return {
      packageSlug: row.packageSlug,
      packageLabel: row.packageLabel,
      packageGold: row.packageGold,
      sortOrder: row.sortOrder,
      itemSlug: row.itemSlug,
      itemName: row.itemName,
      quantity: row.quantity,
      choiceText: row.choiceText,
    };
  }
}
