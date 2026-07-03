import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbAbilityGenerationMethod } from '../../../entities/phb-ability-generation-method.entity';
import { AbilityGenerationMethodResponseDto } from '../dto/ability-generation-method-response.dto';

@Injectable()
export class FindAbilityGenerationMethodsQuery {
  constructor(
    @InjectRepository(PhbAbilityGenerationMethod)
    private readonly repo: Repository<PhbAbilityGenerationMethod>,
  ) {}

  async execute(): Promise<AbilityGenerationMethodResponseDto[]> {
    const rows = await this.repo.find({ order: { slug: 'ASC' } });
    return rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      description: row.description,
    }));
  }
}
