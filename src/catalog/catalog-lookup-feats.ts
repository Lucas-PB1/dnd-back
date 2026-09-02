import { Repository } from 'typeorm';
import { requireCatalog } from '../common/assert';
import { requireFound } from '../common/require-found';
import { VPhbFeat } from '../entities/views/v-phb-feat.entity';

export async function findFeatOrFail(
  featsRepo: Repository<VPhbFeat>,
  featSlug: string,
): Promise<VPhbFeat> {
  return requireFound(
    await featsRepo.findOne({ where: { featSlug } }),
    `Feat '${featSlug}' not found`,
  );
}

export async function assertFeatInCatalog(
  featsRepo: Repository<VPhbFeat>,
  featSlug: string,
): Promise<VPhbFeat> {
  return requireCatalog(
    await featsRepo.findOne({ where: { featSlug } }),
    `Feat '${featSlug}' not found in catalog`,
  );
}

export async function findEpicBoonFeatSlugs(
  featsRepo: Repository<VPhbFeat>,
): Promise<Set<string>> {
  const rows = await featsRepo.find({
    where: { categorySlug: 'epic-boon' },
  });
  return new Set(rows.map((row) => row.featSlug));
}
