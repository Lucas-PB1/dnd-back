import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { requireCatalog } from '../common/assert';
import { requireFound } from '../common/require-found';
import { VPhbClass } from '../entities/views/v-phb-class.entity';
import { PhbSpecies } from '../entities/phb-species.entity';
import { PhbHeritage } from '../entities/phb-heritage.entity';
import { VPhbBackground } from '../entities/views/v-phb-background.entity';
import { VPhbSubclass } from '../entities/views/v-phb-subclass.entity';
import { PhbAlignment } from '../entities/phb-alignment.entity';

export async function findClassOrFail(
  classesRepo: Repository<VPhbClass>,
  classSlug: string,
): Promise<VPhbClass> {
  return requireFound(
    await classesRepo.findOne({ where: { classSlug } }),
    `Class '${classSlug}' not found`,
  );
}

export async function assertClassSlug(
  classesRepo: Repository<VPhbClass>,
  classSlug: string,
): Promise<void> {
  requireCatalog(
    await classesRepo.findOne({ where: { classSlug } }),
    `Class '${classSlug}' not found in catalog`,
  );
}

export async function findSpeciesOrFail(
  speciesRepo: Repository<PhbSpecies>,
  speciesSlug: string,
): Promise<PhbSpecies> {
  return requireFound(
    await speciesRepo.findOne({ where: { slug: speciesSlug } }),
    `Species '${speciesSlug}' not found`,
  );
}

export async function findHeritageOrFail(
  heritageRepo: Repository<PhbHeritage>,
  heritageSlug: string,
): Promise<PhbHeritage> {
  return requireFound(
    await heritageRepo.findOne({ where: { slug: heritageSlug } }),
    `Heritage '${heritageSlug}' not found`,
  );
}

export async function assertHeritageSlug(
  heritageRepo: Repository<PhbHeritage>,
  heritageSlug: string,
): Promise<void> {
  requireCatalog(
    await heritageRepo.findOne({ where: { slug: heritageSlug } }),
    `Heritage '${heritageSlug}' not found in catalog`,
  );
}

export async function findBackgroundOrFail(
  backgroundsRepo: Repository<VPhbBackground>,
  backgroundSlug: string,
): Promise<VPhbBackground> {
  return requireFound(
    await backgroundsRepo.findOne({ where: { backgroundSlug } }),
    `Background '${backgroundSlug}' not found`,
  );
}

export async function assertBackgroundSlug(
  backgroundsRepo: Repository<VPhbBackground>,
  backgroundSlug: string,
): Promise<void> {
  requireCatalog(
    await backgroundsRepo.findOne({ where: { backgroundSlug } }),
    `Background '${backgroundSlug}' not found in catalog`,
  );
}

export async function findSubclassOrFail(
  subclassesRepo: Repository<VPhbSubclass>,
  subclassSlug: string,
): Promise<VPhbSubclass> {
  return requireFound(
    await subclassesRepo.findOne({ where: { subclassSlug } }),
    `Subclass '${subclassSlug}' not found`,
  );
}

export async function assertSubclassForClass(
  subclassesRepo: Repository<VPhbSubclass>,
  subclassSlug: string,
  classSlug: string,
): Promise<void> {
  requireCatalog(
    await subclassesRepo.findOne({ where: { subclassSlug, classSlug } }),
    `Subclass '${subclassSlug}' is not valid for class '${classSlug}'`,
  );
}

export async function assertAlignmentSlug(
  alignmentsRepo: Repository<PhbAlignment>,
  alignmentSlug: string,
): Promise<void> {
  requireCatalog(
    await alignmentsRepo.findOne({ where: { slug: alignmentSlug } }),
    `Alignment '${alignmentSlug}' not found in catalog`,
  );
}

export async function validateCharacterCatalogRefs(input: {
  classSlug: string;
  speciesSlug?: string | null;
  heritageSlug?: string | null;
  backgroundSlug: string;
  subclassSlug?: string | null;
  alignmentSlug?: string | null;
  assertClassSlug: (slug: string) => Promise<void>;
  assertBackgroundSlug: (slug: string) => Promise<void>;
  assertHeritageSlug: (slug: string) => Promise<void>;
  assertSpeciesSlug: (slug: string) => Promise<void>;
  assertSubclassForClass: (subclassSlug: string, classSlug: string) => Promise<void>;
  assertAlignmentSlug: (slug: string) => Promise<void>;
}): Promise<void> {
  const originChecks: Promise<void>[] = [
    input.assertClassSlug(input.classSlug),
    input.assertBackgroundSlug(input.backgroundSlug),
  ];
  if (input.heritageSlug?.trim()) {
    originChecks.push(input.assertHeritageSlug(input.heritageSlug.trim()));
  } else if (input.speciesSlug?.trim()) {
    originChecks.push(input.assertSpeciesSlug(input.speciesSlug.trim()));
  } else {
    throw new BadRequestException('speciesSlug or heritageSlug is required');
  }
  await Promise.all(originChecks);

  if (input.subclassSlug) {
    await input.assertSubclassForClass(input.subclassSlug, input.classSlug);
  }
  if (input.alignmentSlug) {
    await input.assertAlignmentSlug(input.alignmentSlug);
  }
}
