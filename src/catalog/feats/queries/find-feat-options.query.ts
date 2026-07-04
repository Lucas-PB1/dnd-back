import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import {
  PhbFeatOptionDef,
  PhbFeatOptionValue,
  PhbFeatRef,
} from '../../../entities/phb-feat-option.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { FeatOptionResponseDto } from '../dto/feat-option-response.dto';

@Injectable()
export class FindFeatOptionsQuery {
  constructor(
    @InjectRepository(PhbFeatRef)
    private readonly featRepo: Repository<PhbFeatRef>,
    @InjectRepository(PhbFeatOptionDef)
    private readonly optionDefRepo: Repository<PhbFeatOptionDef>,
    @InjectRepository(PhbFeatOptionValue)
    private readonly optionValueRepo: Repository<PhbFeatOptionValue>,
  ) {}

  async execute(
    featSlug: string,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<FeatOptionResponseDto>> {
    const feat = await this.featRepo.findOne({ where: { slug: featSlug } });
    if (!feat) {
      throw new NotFoundException(`Feat '${featSlug}' not found`);
    }

    const defs = await this.optionDefRepo.find({
      where: { featId: feat.id },
      order: { sortOrder: 'ASC', optionKey: 'ASC' },
    });

    const values = await this.optionValueRepo.find({
      where: { featId: feat.id },
      order: { sortOrder: 'ASC', valueId: 'ASC' },
    });

    const valuesByKey = new Map<string, FeatOptionResponseDto['values']>();
    for (const value of values) {
      const list = valuesByKey.get(value.optionKey) ?? [];
      list.push({
        valueId: value.valueId,
        label: value.label,
        sortOrder: value.sortOrder,
      });
      valuesByKey.set(value.optionKey, list);
    }

    const options: FeatOptionResponseDto[] = defs.map((def) => ({
      optionKey: def.optionKey,
      label: def.label,
      valueType: def.valueType,
      sortOrder: def.sortOrder,
      dependsOnOptionKey: def.dependsOnOptionKey,
      spellMaxLevel: def.spellMaxLevel,
      values: def.valueType === 'catalog' ? (valuesByKey.get(def.optionKey) ?? []) : [],
    }));

    return paginate(options, page, limit);
  }
}
