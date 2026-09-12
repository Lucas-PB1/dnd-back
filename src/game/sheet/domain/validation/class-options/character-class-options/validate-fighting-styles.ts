import { BadRequestException } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { assertUnique } from '@common/assert';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { ClassProficienciesQuery } from '@catalog/game-port';
import { CharacterSheetInput } from '@game/sheet/domain/character-sheet.types';
import { CharacterFeatDto } from '@game/sheet/dto/character-sheet.dto';
import { isGeneralFeatFightingStylePick } from '@game/shared/domain/fighting-style-general-feat';
import {
  FIGHTING_STYLE_FEAT_CATEGORY,
  collectFightingStyleSlugsFromSubclassOptions,
} from '../fighting-style-feat-options';
import {
  fightingStyleExists,
  loadClassFightingStyleSlugs,
} from '@game/sheet/infrastructure/queries/feat-option.queries';

export type FightingStyleValidationDeps = {
  dataSource: DataSource;
  proficiencies: ClassProficienciesQuery;
  catalogLookup: CatalogLookupService;
};

export async function validateFightingStyleSelections(
  deps: FightingStyleValidationDeps,
  classSlug: string,
  characterFeats: CharacterFeatDto[],
  subclassOptions: CharacterSheetInput['subclassOptions'],
  level = 1,
): Promise<void> {
  const allowedSlugs = await loadClassFightingStyleSlugs(
    deps.proficiencies,
    classSlug,
  );
  const allowed = new Set(allowedSlugs);
  const styleSlugs: string[] = [];

  for (const feat of characterFeats) {
    const meta = await deps.catalogLookup.assertFeatInCatalog(feat.featSlug);
    if (meta.categorySlug !== FIGHTING_STYLE_FEAT_CATEGORY) continue;
    if (isGeneralFeatFightingStylePick(feat.featSlug, level)) {
      styleSlugs.push(feat.featSlug);
      continue;
    }
    if (!allowed.has(feat.featSlug)) {
      throw new BadRequestException(
        `Fighting style feat '${feat.featSlug}' is not available for class '${classSlug}'`,
      );
    }
    styleSlugs.push(feat.featSlug);
  }

  for (const slug of collectFightingStyleSlugsFromSubclassOptions(
    subclassOptions,
  )) {
    if (!(await fightingStyleExists(deps.dataSource, slug))) {
      throw new BadRequestException(`Unknown fighting style '${slug}'`);
    }
    if (!allowed.has(slug)) {
      throw new BadRequestException(
        `Fighting style '${slug}' is not available for class '${classSlug}'`,
      );
    }
    styleSlugs.push(slug);
  }

  if (styleSlugs.length > 0) {
    assertUnique(styleSlugs, 'Each fighting style can only be chosen once');
  }
}
