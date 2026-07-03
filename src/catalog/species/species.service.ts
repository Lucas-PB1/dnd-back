import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSpecies } from '../../entities/phb-species.entity';
import { PhbSpeciesTrait } from '../../entities/phb-species-trait.entity';
import { VPhbSpeciesTraitChoices } from '../../entities/views/v-phb-species-trait-choices.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { SpeciesResponseDto } from './dto/species-response.dto';
import { SpeciesTraitResponseDto } from './dto/species-trait-response.dto';
import { SpeciesTraitChoiceResponseDto } from './dto/species-trait-choice-response.dto';

@Injectable()
export class SpeciesService {
  constructor(
    @InjectRepository(PhbSpecies)
    private readonly speciesRepo: Repository<PhbSpecies>,
    @InjectRepository(PhbSpeciesTrait)
    private readonly traitsRepo: Repository<PhbSpeciesTrait>,
    @InjectRepository(VPhbSpeciesTraitChoices)
    private readonly traitChoicesRepo: Repository<VPhbSpeciesTraitChoices>,
  ) {}

  async findAll(page = 1, limit = 20): Promise<PaginatedResponseDto<SpeciesResponseDto>> {
    const rows = await this.speciesRepo.find({ order: { name: 'ASC' } });
    return paginate(rows.map((row) => this.toDto(row)), page, limit);
  }

  async findBySlug(slug: string): Promise<SpeciesResponseDto> {
    const row = await this.speciesRepo.findOne({ where: { slug } });
    if (!row) {
      throw new NotFoundException(`Species '${slug}' not found`);
    }
    return this.toDto(row);
  }

  async findTraitsBySpeciesSlug(
    speciesSlug: string,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<SpeciesTraitResponseDto>> {
    await this.assertSpeciesExists(speciesSlug);

    const rows = await this.traitsRepo.find({
      where: { species: { slug: speciesSlug } },
      order: { name: 'ASC' },
    });
    return paginate(rows.map((row) => this.toTraitDto(row)), page, limit);
  }

  async findTraitChoicesBySpeciesSlug(
    speciesSlug: string,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<SpeciesTraitChoiceResponseDto>> {
    await this.assertSpeciesExists(speciesSlug);

    const rows = await this.traitChoicesRepo.find({
      where: { speciesSlug },
      order: { traitName: 'ASC', choiceName: 'ASC' },
    });
    if (rows.length === 0) {
      throw new NotFoundException(`Species '${speciesSlug}' has no trait choices`);
    }
    return paginate(rows.map((row) => this.toTraitChoiceDto(row)), page, limit);
  }

  private async assertSpeciesExists(slug: string): Promise<void> {
    const exists = await this.speciesRepo.findOne({ where: { slug } });
    if (!exists) {
      throw new NotFoundException(`Species '${slug}' not found`);
    }
  }

  private toDto(row: PhbSpecies): SpeciesResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      creatureType: row.creatureType,
      size: row.size,
      speed: row.speed,
      description: row.description,
    };
  }

  private toTraitDto(row: PhbSpeciesTrait): SpeciesTraitResponseDto {
    return {
      name: row.name,
      description: row.description,
      choiceKind: row.choiceKind,
    };
  }

  private toTraitChoiceDto(row: VPhbSpeciesTraitChoices): SpeciesTraitChoiceResponseDto {
    return {
      traitName: row.traitName,
      choiceKind: row.choiceKind,
      choiceSlug: row.choiceSlug,
      choiceName: row.choiceName,
      level1Benefit: row.level1Benefit,
      spellLevel3Slug: row.spellLevel3Slug,
      spellLevel5Slug: row.spellLevel5Slug,
      damageType: row.damageType,
    };
  }
}
