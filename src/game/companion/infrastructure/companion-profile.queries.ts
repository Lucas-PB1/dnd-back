import { DataSource } from 'typeorm';
import { PhbSubclassRef } from '@entities/subclass-feature/phb-subclass-ref.entity';
import {
  PhbCompanionProfile,
  PhbCompanionTemplateMap,
} from '@entities/companion/phb-companion-profile.entity';
import type {
  CompanionProfile,
  CompanionTemplateMapRow,
} from '../domain/companion-profiles';

export async function loadCompanionProfileBySubclass(
  dataSource: DataSource,
  subclassSlug: string | null | undefined,
): Promise<CompanionProfile | null> {
  if (!subclassSlug) return null;
  const subclass = await dataSource.getRepository(PhbSubclassRef).findOne({
    where: { slug: subclassSlug },
    select: ['id', 'slug'],
  });
  if (!subclass) return null;
  const row = await dataSource.getRepository(PhbCompanionProfile).findOne({
    where: { subclassId: subclass.id },
  });
  if (!row) return null;
  return {
    profileId: row.profileId,
    subclassSlug: subclass.slug,
    minLevel: row.minLevel,
  };
}

export async function loadCompanionTemplateMaps(
  dataSource: DataSource,
  profileId: string,
): Promise<CompanionTemplateMapRow[]> {
  const rows = await dataSource.getRepository(PhbCompanionTemplateMap).find({
    where: { profileId },
    order: { id: 'ASC' },
  });
  return rows.map((row) => ({
    optionMatches: row.optionMatches ?? {},
    templateSlug: row.templateSlug,
    variantLabel: row.variantLabel,
  }));
}
