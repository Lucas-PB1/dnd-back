import { BadRequestException } from '@nestjs/common';

/** Coberturas só aplicam em peças mundanas (sem `properties.magic`). */
export function isMagicCatalogItem(
  properties: Record<string, unknown> | null | undefined,
): boolean {
  return properties?.magic === true;
}

export function assertBaseEligibleForCoverage(
  baseSlug: string,
  properties: Record<string, unknown> | null | undefined,
): void {
  if (properties?.kind === 'coverage') {
    throw new BadRequestException(
      `Item '${baseSlug}' is a coverage overlay — pick a mundane base piece instead`,
    );
  }
  if (isMagicCatalogItem(properties)) {
    throw new BadRequestException(
      `Item '${baseSlug}' is already magical — coverage cannot stack on magic items (+1, adamantina, etc.)`,
    );
  }
}
