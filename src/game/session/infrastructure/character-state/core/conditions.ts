import { BadRequestException } from '@nestjs/common';
import { In, Repository } from 'typeorm';
import { PhbCondition } from '../../phb-condition.entity';

export async function assertValidConditions(
  conditions: Repository<PhbCondition>,
  slugs: string[],
): Promise<void> {
  if (slugs.length === 0) return;
  const rows = await conditions.find({ where: { slug: In(slugs) } });
  const found = new Set(rows.map((r) => r.slug));
  const invalid = slugs.filter((s) => !found.has(s));
  if (invalid.length > 0) {
    throw new BadRequestException(`Unknown conditions: ${invalid.join(', ')}`);
  }
}
