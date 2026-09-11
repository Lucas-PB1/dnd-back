import { BadRequestException } from '@nestjs/common';
import { Repository } from 'typeorm';
import { requireCatalog } from '../common/assert';
import { PhbSpecies } from '../entities/species/phb-species.entity';

export function isTraitPackageSpecies(row: PhbSpecies): boolean {
  const raw = row.sourceMeta?.variantOf;
  return typeof raw === 'string' && raw.trim().length > 0;
}

export function isCatalogOnlySpecies(row: PhbSpecies): boolean {
  const raw = row.sourceMeta?.catalogOnly;
  return raw === true || raw === 'true' || raw === 1 || raw === '1';
}

export function isNonPlayableSpecies(row: PhbSpecies): boolean {
  return isTraitPackageSpecies(row) || isCatalogOnlySpecies(row);
}

export async function assertPlayableSpeciesSlug(
  speciesRepo: Repository<PhbSpecies>,
  speciesSlug: string,
): Promise<void> {
  const row = await speciesRepo.findOne({ where: { slug: speciesSlug } });
  const species = requireCatalog(
    row,
    `Species '${speciesSlug}' not found in catalog`,
  );
  if (isTraitPackageSpecies(species)) {
    throw new BadRequestException(
      `Species '${speciesSlug}' is not a playable species`,
    );
  }
  if (isCatalogOnlySpecies(species)) {
    throw new BadRequestException(
      `Species '${speciesSlug}' is catalog-only and not playable`,
    );
  }
}

export function assertSpeciesIsPlayable(
  row: PhbSpecies,
  speciesSlug: string,
): void {
  if (isNonPlayableSpecies(row)) {
    throw new BadRequestException(
      `Species '${speciesSlug}' is not a playable species`,
    );
  }
}
