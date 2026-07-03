import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '../../entities/views/v-phb-class.entity';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';
import { VSpellByClass } from '../../entities/views/v-spell-by-class.entity';
import { VClassSpellSlots } from '../../entities/views/v-class-spell-slots.entity';
import { VPhbClassEquipment } from '../../entities/views/v-phb-class-equipment.entity';
import { VPhbClassSkillChoice } from '../../entities/views/v-phb-class-skill-choice.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { ClassResponseDto } from './dto/class-response.dto';
import { SubclassResponseDto } from './dto/subclass-response.dto';
import { ClassSpellResponseDto } from './dto/class-spell-response.dto';
import { ClassSpellSlotsResponseDto } from './dto/class-spell-slots-response.dto';
import { ClassEquipmentResponseDto } from './dto/class-equipment-response.dto';
import { ClassSkillResponseDto } from './dto/class-skill-response.dto';

@Injectable()
export class ClassesService {
  constructor(
    @InjectRepository(VPhbClass)
    private readonly classesRepo: Repository<VPhbClass>,
    @InjectRepository(VPhbSubclass)
    private readonly subclassesRepo: Repository<VPhbSubclass>,
    @InjectRepository(VSpellByClass)
    private readonly spellsByClassRepo: Repository<VSpellByClass>,
    @InjectRepository(VClassSpellSlots)
    private readonly spellSlotsRepo: Repository<VClassSpellSlots>,
    @InjectRepository(VPhbClassEquipment)
    private readonly equipmentRepo: Repository<VPhbClassEquipment>,
    @InjectRepository(VPhbClassSkillChoice)
    private readonly skillsRepo: Repository<VPhbClassSkillChoice>,
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
    await this.assertClassExists(classSlug);

    const rows = await this.subclassesRepo.find({
      where: { classSlug },
      order: { subclassName: 'ASC' },
    });
    return paginate(rows.map((row) => this.toSubclassDto(row)), page, limit);
  }

  async findSpellsByClassSlug(
    classSlug: string,
    page = 1,
    limit = 20,
    maxLevel?: number,
  ): Promise<PaginatedResponseDto<ClassSpellResponseDto>> {
    await this.assertClassExists(classSlug);

    let rows = await this.spellsByClassRepo.find({
      where: { classSlug },
      order: { spellLevel: 'ASC', spellName: 'ASC' },
    });
    if (maxLevel !== undefined) {
      rows = rows.filter((row) => row.spellLevel <= maxLevel);
    }
    return paginate(rows.map((row) => this.toClassSpellDto(row)), page, limit);
  }

  async findSpellSlotsByClassSlug(
    classSlug: string,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<ClassSpellSlotsResponseDto>> {
    await this.assertClassExists(classSlug);

    const rows = await this.spellSlotsRepo.find({
      where: { classSlug },
      order: { classLevel: 'ASC' },
    });
    if (rows.length === 0) {
      throw new NotFoundException(`Class '${classSlug}' has no spell slot progression`);
    }
    return paginate(rows.map((row) => this.toSpellSlotsDto(row)), page, limit);
  }

  async findEquipmentByClassSlug(
    classSlug: string,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<ClassEquipmentResponseDto>> {
    await this.assertClassExists(classSlug);

    const rows = await this.equipmentRepo.find({
      where: { classSlug },
      order: { packageSlug: 'ASC', sortOrder: 'ASC' },
    });
    if (rows.length === 0) {
      throw new NotFoundException(`Class '${classSlug}' has no starting equipment`);
    }
    return paginate(rows.map((row) => this.toEquipmentDto(row)), page, limit);
  }

  async findSkillsByClassSlug(
    classSlug: string,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<ClassSkillResponseDto>> {
    await this.assertClassExists(classSlug);

    const rows = await this.skillsRepo.find({
      where: { classSlug },
      order: { skillName: 'ASC' },
    });
    if (rows.length === 0) {
      throw new NotFoundException(`Class '${classSlug}' has no skill choices`);
    }
    return paginate(rows.map((row) => this.toClassSkillDto(row)), page, limit);
  }

  private async assertClassExists(classSlug: string): Promise<void> {
    const exists = await this.classesRepo.findOne({ where: { classSlug } });
    if (!exists) {
      throw new NotFoundException(`Class '${classSlug}' not found`);
    }
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

  private toClassSpellDto(row: VSpellByClass): ClassSpellResponseDto {
    return {
      slug: row.spellSlug,
      name: row.spellName,
      level: row.spellLevel,
      schoolSlug: row.schoolSlug,
      schoolName: row.schoolName,
    };
  }

  private toSpellSlotsDto(row: VClassSpellSlots): ClassSpellSlotsResponseDto {
    return {
      classLevel: row.classLevel,
      patternSlug: row.patternSlug,
      patternName: row.patternName,
      spellSlots: row.spellSlots,
    };
  }

  private toEquipmentDto(row: VPhbClassEquipment): ClassEquipmentResponseDto {
    return {
      packageSlug: row.packageSlug,
      packageLabel: row.packageLabel,
      sortOrder: row.sortOrder,
      itemSlug: row.itemSlug,
      itemName: row.itemName,
      quantity: row.quantity,
      choiceText: row.choiceText,
      goldAmount: row.goldAmount,
    };
  }

  private toClassSkillDto(row: VPhbClassSkillChoice): ClassSkillResponseDto {
    return {
      slug: row.skillSlug,
      name: row.skillName,
      skillChoiceCount: row.skillChoiceCount,
      skillChoiceFrom: row.skillChoiceFrom,
    };
  }
}
