import { BadRequestException } from '@nestjs/common';
import { parseItemCoverage, type ItemCoverage } from './item-coverage';

/** Coberturas não entram soltas na mochila — só presas a uma peça base. */
export function assertNotStandaloneCoverageItem(
  itemSlug: string,
  properties: Record<string, unknown> | null | undefined,
): void {
  if (parseItemCoverage(properties)) {
    throw new BadRequestException(
      `Item '${itemSlug}' is a coverage — attach it to a base piece (existing or bought in the same checkout)`,
    );
  }
}

/** Linha cujo itemSlug é a cobertura — exige destino. */
export function assertCoverageLineHasTarget(
  coverageSlug: string,
  line: {
    attachToBaseSlug?: string;
    attachCoverageSlug?: string;
  },
): void {
  if (line.attachCoverageSlug) {
    throw new BadRequestException(
      `Coverage line '${coverageSlug}' cannot also set attachCoverageSlug — put the coverage slug on the base line instead`,
    );
  }
  if (!line.attachToBaseSlug?.trim()) {
    throw new BadRequestException(
      `Coverage '${coverageSlug}' requires attachToBaseSlug (inventory host) or buy the base with attachCoverageSlug on the same checkout`,
    );
  }
}

export function assertAttachCoverageSlugIsCoverage(
  coverageSlug: string,
  properties: Record<string, unknown> | null | undefined,
): ItemCoverage {
  const coverage = parseItemCoverage(properties);
  if (!coverage) {
    throw new BadRequestException(
      `attachCoverageSlug '${coverageSlug}' is not a coverage item`,
    );
  }
  return coverage;
}
