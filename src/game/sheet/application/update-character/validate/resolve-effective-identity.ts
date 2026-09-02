import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { UpdateCharacterDto } from '@game/sheet/dto/update-character.dto';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';

export type EffectiveCharacterIdentity = {
  level: number;
  classSlug: string;
  speciesSlug: string | null;
  heritageSlug: string | null;
  backgroundSlug: string;
  subclassSlug: string | null;
};

export function resolveEffectiveCharacterIdentity(
  dto: UpdateCharacterDto,
  row: PlayerCharacter,
): EffectiveCharacterIdentity {
  return {
    level: dto.level ?? row.level,
    classSlug: dto.classSlug ?? row.classSlug,
    speciesSlug:
      dto.speciesSlug !== undefined ? (dto.speciesSlug ?? null) : row.speciesSlug,
    heritageSlug:
      dto.heritageSlug !== undefined ? (dto.heritageSlug ?? null) : row.heritageSlug,
    backgroundSlug: dto.backgroundSlug ?? row.backgroundSlug,
    subclassSlug:
      dto.subclassSlug !== undefined ? (dto.subclassSlug ?? null) : row.subclassSlug,
  };
}

/** Valida refs de catálogo só quando o patch toca identidade/alinhamento. */
export async function validateUpdateCatalogRefsIfNeeded(input: {
  catalogLookup: CatalogLookupService;
  dto: UpdateCharacterDto;
  row: PlayerCharacter;
  effective: EffectiveCharacterIdentity;
}): Promise<void> {
  const { catalogLookup, dto, row, effective } = input;
  if (
    dto.classSlug === undefined &&
    dto.speciesSlug === undefined &&
    dto.heritageSlug === undefined &&
    dto.backgroundSlug === undefined &&
    dto.subclassSlug === undefined &&
    dto.alignmentSlug === undefined
  ) {
    return;
  }

  await catalogLookup.validateCharacterCatalogRefs({
    classSlug: effective.classSlug,
    speciesSlug: effective.speciesSlug,
    heritageSlug: effective.heritageSlug,
    backgroundSlug: effective.backgroundSlug,
    subclassSlug: effective.subclassSlug,
    alignmentSlug:
      dto.alignmentSlug !== undefined ? dto.alignmentSlug : row.alignmentSlug,
  });
}
