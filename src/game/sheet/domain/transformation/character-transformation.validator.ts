import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource, InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbFeatRef } from '@entities/feat/phb-feat-ref.entity';
import { PhbOptionValue } from '@entities/reference/phb-option.entity';
import type { CharacterTransformation } from './validate-transformation';
import {
  GH_TRANSFORMATION_CATEGORY,
  validateTransformationShape,
} from './validate-transformation';
import { validateTransformationChoices } from './validate-transformation-choices';
import { loadTransformationChoiceRule } from './load-transformation-choice-rule';

@Injectable()
export class CharacterTransformationValidator {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    @InjectRepository(PhbFeatRef)
    private readonly featRefRepo: Repository<PhbFeatRef>,
    @InjectRepository(PhbOptionValue)
    private readonly optionValueRepo: Repository<PhbOptionValue>,
    @InjectDataSource()
    private readonly dataSource: DataSource,
  ) {}

  async validate(
    transformation: CharacterTransformation | null | undefined,
  ): Promise<void> {
    if (transformation === undefined || transformation === null) return;

    validateTransformationShape(transformation);
    const slug = transformation.slug.trim();
    const feat = await this.catalogLookup.assertFeatInCatalog(slug);
    if (feat.categorySlug !== GH_TRANSFORMATION_CATEGORY) {
      throw new BadRequestException(
        `Feat '${slug}' is not a Cap. 6 transformation`,
      );
    }

    const featRef = await this.featRefRepo.findOne({ where: { slug } });
    if (!featRef) {
      throw new BadRequestException(`Feat '${slug}' not found`);
    }

    const values = await this.optionValueRepo.find({
      where: { scope: 'feat', ownerId: featRef.id },
    });
    const allowedValuesByKey = new Map<string, Set<string>>();
    for (const row of values) {
      const set = allowedValuesByKey.get(row.optionKey) ?? new Set<string>();
      set.add(row.valueId);
      allowedValuesByKey.set(row.optionKey, set);
    }

    const rules = await loadTransformationChoiceRule(this.dataSource, slug);
    if (!rules) {
      throw new BadRequestException(`No Cap. 6 choice rules for '${slug}'`);
    }

    validateTransformationChoices({
      transformation,
      allowedValuesByKey,
      rules,
    });
  }
}
