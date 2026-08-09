import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbEldritchInvocation } from '@entities/phb-eldritch-invocation.entity';
import { EldritchInvocationResponseDto } from '../dto/eldritch-invocation-response.dto';

@Injectable()
export class FindEldritchInvocationsQuery {
  constructor(
    @InjectRepository(PhbEldritchInvocation)
    private readonly repo: Repository<PhbEldritchInvocation>,
  ) {}

  async execute(maxMinLevel?: number): Promise<EldritchInvocationResponseDto[]> {
    const qb = this.repo
      .createQueryBuilder('inv')
      .orderBy('inv.sortOrder', 'ASC')
      .addOrderBy('inv.name', 'ASC');

    if (maxMinLevel != null) {
      qb.andWhere('inv.minLevel <= :maxMinLevel', { maxMinLevel });
    }

    const rows = await qb.getMany();
    return rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      description: row.description,
      minLevel: row.minLevel,
      requiresPactSlug: row.requiresPactSlug,
      requiresInvocationSlug: row.requiresInvocationSlug,
      repeatable: row.repeatable,
      kind: row.kind,
      grantedSpellSlug: row.grantedSpellSlug,
      sortOrder: row.sortOrder,
    }));
  }
}
