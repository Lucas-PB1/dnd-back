import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { PhbOptionDef, PhbOptionValue } from '@entities/phb-option.entity';
import { PhbFeatRef } from '@entities/phb-feat-ref.entity';
import { FeatOptionResponseDto } from '../dto/feat-option-response.dto';

export type FeatOptionsBySlugDto = {
  featSlug: string;
  options: FeatOptionResponseDto[];
};

@Injectable()
export class FindFeatOptionsBySlugsQuery {
  constructor(
    @InjectRepository(PhbFeatRef)
    private readonly featRepo: Repository<PhbFeatRef>,
    @InjectRepository(PhbOptionDef)
    private readonly optionDefRepo: Repository<PhbOptionDef>,
    @InjectRepository(PhbOptionValue)
    private readonly optionValueRepo: Repository<PhbOptionValue>,
  ) {}

  async execute(slugs: string[]): Promise<FeatOptionsBySlugDto[]> {
    if (slugs.length === 0) return [];

    const feats = await this.featRepo.find({
      where: { slug: In(slugs) },
    });
    if (feats.length === 0) {
      return slugs.map((featSlug) => ({ featSlug, options: [] }));
    }

    const ownerIds = feats.map((feat) => feat.id);
    const [defs, values] = await Promise.all([
      this.optionDefRepo.find({
        where: { scope: 'feat', ownerId: In(ownerIds) },
        order: { sortOrder: 'ASC', optionKey: 'ASC' },
      }),
      this.optionValueRepo.find({
        where: { scope: 'feat', ownerId: In(ownerIds) },
        order: { sortOrder: 'ASC', valueId: 'ASC' },
      }),
    ]);

    const featById = new Map(feats.map((feat) => [feat.id, feat]));
    const valuesByOwnerKey = new Map<string, FeatOptionResponseDto['values']>();
    for (const value of values) {
      const key = `${value.ownerId}::${value.optionKey}`;
      const list = valuesByOwnerKey.get(key) ?? [];
      list.push({
        valueId: value.valueId,
        label: value.label,
        sortOrder: value.sortOrder,
        benefit: value.benefit ?? value.level1Benefit ?? null,
      });
      valuesByOwnerKey.set(key, list);
    }

    const optionsByOwner = new Map<string, FeatOptionResponseDto[]>();
    for (const def of defs) {
      const list = optionsByOwner.get(def.ownerId) ?? [];
      list.push({
        optionKey: def.optionKey,
        label: def.label,
        valueType: def.valueType,
        sortOrder: def.sortOrder,
        dependsOnOptionKey: def.dependsOnOptionKey,
        spellMaxLevel: def.spellMaxLevel,
        spellSchoolSlugs: def.spellSchoolSlugs,
        spellRitualOnly: def.spellRitualOnly,
        values: ['catalog', 'ability', 'proficiency'].includes(def.valueType)
          ? (valuesByOwnerKey.get(`${def.ownerId}::${def.optionKey}`) ?? [])
          : [],
      });
      optionsByOwner.set(def.ownerId, list);
    }

    const bySlug = new Map<string, FeatOptionResponseDto[]>();
    for (const [ownerId, options] of optionsByOwner) {
      const feat = featById.get(ownerId);
      if (feat) bySlug.set(feat.slug, options);
    }
    for (const feat of feats) {
      if (!bySlug.has(feat.slug)) bySlug.set(feat.slug, []);
    }

    return slugs.map((featSlug) => ({
      featSlug,
      options: bySlug.get(featSlug) ?? [],
    }));
  }
}
