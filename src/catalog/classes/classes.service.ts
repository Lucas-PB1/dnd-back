import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '../../entities/views/v-phb-class.entity';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { ClassResponseDto } from './dto/class-response.dto';
import { SubclassResponseDto } from './dto/subclass-response.dto';

@Injectable()
export class ClassesService {
  constructor(
    @InjectRepository(VPhbClass)
    private readonly classesRepo: Repository<VPhbClass>,
    @InjectRepository(VPhbSubclass)
    private readonly subclassesRepo: Repository<VPhbSubclass>,
  ) {}

  async findAll(page = 1, limit = 20): Promise<PaginatedResponseDto<ClassResponseDto>> {
    const rows = await this.classesRepo.find({ order: { className: 'ASC' } });
    const dtos = rows.map((row) => this.toDto(row));
    return paginate(dtos, page, limit);
  }

  async findBySlug(slug: string): Promise<ClassResponseDto> {
    const row = await this.classesRepo.findOne({ where: { classSlug: slug } });
    if (!row) {
      throw new NotFoundException(`Class '${slug}' not found`);
    }
    return this.toDto(row);
  }

  async findSubclassesByClassSlug(
    classSlug: string,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<SubclassResponseDto>> {
    const classRow = await this.classesRepo.findOne({ where: { classSlug } });
    if (!classRow) {
      throw new NotFoundException(`Class '${classSlug}' not found`);
    }

    const rows = await this.subclassesRepo.find({
      where: { classSlug },
      order: { subclassName: 'ASC' },
    });
    const dtos = rows.map((row) => this.toSubclassDto(row));
    return paginate(dtos, page, limit);
  }

  private toDto(row: VPhbClass): ClassResponseDto {
    return {
      slug: row.classSlug,
      name: row.className,
      hitDie: row.hitDie,
      primaryAbilityLabel: row.primaryAbilityLabel,
      primaryAbilityOperator: row.primaryAbilityOperator,
      primaryAbilitySlugs: row.primaryAbilitySlugs ?? [],
      hpLevel1DieValue: row.hpLevel1DieValue,
      hpFixedPerLevel: row.hpFixedPerLevel,
      skillChoiceCount: row.skillChoiceCount,
      skillChoiceFrom: row.skillChoiceFrom,
      sourceChapter: row.sourceChapter,
      editionSlug: row.editionSlug,
    };
  }

  private toSubclassDto(row: VPhbSubclass): SubclassResponseDto {
    return {
      slug: row.subclassSlug,
      name: row.subclassName,
      classSlug: row.classSlug,
      className: row.className,
      tagline: row.tagline,
      summary: row.summary,
      sourceChapter: row.sourceChapter,
      editionSlug: row.editionSlug,
      spellSourceSlug: row.spellSourceSlug,
      spellSourceLabel: row.spellSourceLabel,
    };
  }
}
