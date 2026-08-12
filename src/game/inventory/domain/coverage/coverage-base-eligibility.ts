import { BadRequestException } from '@nestjs/common';

/** Peça mágica do catálogo (`properties.magic`). */
export function isMagicCatalogItem(
  properties: Record<string, unknown> | null | undefined,
): boolean {
  return properties?.magic === true;
}

export function isMasterworkCoverage(
  properties: Record<string, unknown> | null | undefined,
): boolean {
  return properties?.masterwork === true;
}

/** +1 de obra-prima só em peça mundana; em mágica a qualidade já conta, sem stack. */
export function masterworkTierBonusApplies(
  coverageProperties: Record<string, unknown> | null | undefined,
  baseIsMagic: boolean,
): boolean {
  if (!isMasterworkCoverage(coverageProperties)) return true;
  return !baseIsMagic;
}

/**
 * Coberturas DMG (+1/+2/+3, adamantina…) só em peças mundanas.
 * Obra-prima (Northlands): arma mágica já é qualidade obra-prima — pode anexar;
 * o +1 não se soma (ver `masterworkTierBonusApplies`).
 */
export function assertBaseEligibleForCoverage(
  baseSlug: string,
  properties: Record<string, unknown> | null | undefined,
  coverageProperties?: Record<string, unknown> | null,
): void {
  if (properties?.kind === 'coverage') {
    throw new BadRequestException(
      `Item '${baseSlug}' is a coverage overlay — pick a mundane base piece instead`,
    );
  }
  if (
    isMagicCatalogItem(properties) &&
    !isMasterworkCoverage(coverageProperties)
  ) {
    throw new BadRequestException(
      `Item '${baseSlug}' is already magical — coverage cannot stack on magic items (+1, adamantina, etc.)`,
    );
  }
}
