import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { assertUnique, requireCatalog } from '../common/assert';
import { VPhbClass } from '../entities/views/v-phb-class.entity';
import { VPhbClassSkillChoice } from '../entities/views/v-phb-class-skill-choice.entity';
import { PhbSkill } from '../entities/reference/phb-skill.entity';

export async function assertSkillInCatalog(
  skillsRepo: Repository<PhbSkill>,
  skillSlug: string,
): Promise<void> {
  requireCatalog(
    await skillsRepo.findOne({ where: { slug: skillSlug } }),
    `Skill '${skillSlug}' not found in catalog`,
  );
}

export async function validateClassSkillChoices(input: {
  classSlug: string;
  skillSlugs: string[];
  findClassOrFail: (classSlug: string) => Promise<VPhbClass>;
  classSkillChoiceRepo: Repository<VPhbClassSkillChoice>;
  skillsRepo: Repository<PhbSkill>;
}): Promise<void> {
  const { classSlug, skillSlugs } = input;
  const phbClass = await input.findClassOrFail(classSlug);
  const expected = phbClass.skillChoiceCount ?? 0;

  if (skillSlugs.length !== expected) {
    throw new BadRequestException(
      `Class '${classSlug}' requires exactly ${expected} skill choice(s), got ${skillSlugs.length}`,
    );
  }

  if (expected === 0) return;

  assertUnique(skillSlugs, 'Duplicate skill choices are not allowed');

  if (phbClass.skillChoiceFrom === 'any') {
    for (const slug of skillSlugs) {
      await assertSkillInCatalog(input.skillsRepo, slug);
    }
    return;
  }

  const poolRows = await input.classSkillChoiceRepo.find({
    where: { classSlug },
  });
  const pool = new Set(poolRows.map((row) => row.skillSlug));

  for (const slug of skillSlugs) {
    if (!pool.has(slug)) {
      throw new BadRequestException(
        `Skill '${slug}' is not in the choice pool for class '${classSlug}'`,
      );
    }
  }
}
