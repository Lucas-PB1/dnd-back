import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbAbilityGenerationMethod } from '@entities/reference/phb-ability-generation-method.entity';
import {
  POINT_BUY_BUDGET,
  POINT_BUY_COST,
  POINT_BUY_MAX,
  POINT_BUY_MIN,
  ROLL_OPTION_COUNT,
  ROLL_TOTAL_MAX,
  ROLL_TOTAL_MIN,
  STANDARD_ARRAY,
} from '@game/build/domain/ability-generation';
import {
  AbilityGenerationMethodResponseDto,
  AbilityGenerationPointBuyDto,
} from '../dto/ability-generation-method-response.dto';

function pointBuyDto(): AbilityGenerationPointBuyDto {
  const costByScore: Record<string, number> = {};
  for (const [score, cost] of Object.entries(POINT_BUY_COST)) {
    costByScore[score] = cost;
  }
  return {
    budget: POINT_BUY_BUDGET,
    minScore: POINT_BUY_MIN,
    maxScore: POINT_BUY_MAX,
    costByScore,
  };
}

function toDto(row: PhbAbilityGenerationMethod): AbilityGenerationMethodResponseDto {
  const base: AbilityGenerationMethodResponseDto = {
    slug: row.slug,
    name: row.name,
    description: row.description,
  };
  if (row.slug === 'point-buy') {
    return { ...base, pointBuy: pointBuyDto() };
  }
  if (row.slug === 'standard-array') {
    return { ...base, pool: [...STANDARD_ARRAY] };
  }
  if (row.slug === 'roll') {
    return {
      ...base,
      rollTotalMin: ROLL_TOTAL_MIN,
      rollTotalMax: ROLL_TOTAL_MAX,
      rollOptionCount: ROLL_OPTION_COUNT,
    };
  }
  return base;
}

@Injectable()
export class FindAbilityGenerationMethodsQuery {
  constructor(
    @InjectRepository(PhbAbilityGenerationMethod)
    private readonly repo: Repository<PhbAbilityGenerationMethod>,
  ) {}

  async execute(): Promise<AbilityGenerationMethodResponseDto[]> {
    const rows = await this.repo.find({ order: { slug: 'ASC' } });
    return rows.map(toDto);
  }
}
