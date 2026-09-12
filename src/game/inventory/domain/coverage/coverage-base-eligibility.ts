import { BadRequestException } from '@nestjs/common';

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

export function masterworkTierBonusApplies(
  coverageProperties: Record<string, unknown> | null | undefined,
  baseIsMagic: boolean,
): boolean {
  if (!isMasterworkCoverage(coverageProperties)) return true;
  return !baseIsMagic;
}

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
