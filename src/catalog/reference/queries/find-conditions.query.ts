import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbCondition } from '../../../game/session/infrastructure/phb-condition.entity';
import { ConditionResponseDto } from '../dto/condition-response.dto';

@Injectable()
export class FindConditionsQuery {
  constructor(
    @InjectRepository(PhbCondition)
    private readonly conditions: Repository<PhbCondition>,
  ) {}

  async execute(): Promise<ConditionResponseDto[]> {
    const rows = await this.conditions.find({ order: { name: 'ASC' } });
    return rows.map((row) => ({ slug: row.slug, name: row.name }));
  }
}
