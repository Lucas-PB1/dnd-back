import { BadRequestException } from '@nestjs/common';
import { coverageRequiresTierBonus } from '../../../domain/coverage/item-coverage';
import {
  assertEnspelledBoundSpell,
  isEnspelledCoverageSlug,
} from '../../../domain/coverage/enspelled-weapon';

export function assertCoverageBonusAllowed(
  coverageSlug: string,
  coverageProps: Record<string, unknown> | null,
  bonus: 1 | 2 | 3 | undefined,
): { needsTier: boolean } {
  const needsTier = coverageRequiresTierBonus(coverageProps);
  const isMasterwork = coverageProps?.masterwork === true;
  if (needsTier && bonus !== 1 && bonus !== 2 && bonus !== 3) {
    throw new BadRequestException(
      `Coverage '${coverageSlug}' requires bonus 1, 2 or 3`,
    );
  }
  if (isMasterwork && bonus !== 1) {
    throw new BadRequestException(
      `Obra-Prima ('${coverageSlug}') exige bônus +1`,
    );
  }
  if (!needsTier && bonus != null) {
    throw new BadRequestException(
      `Coverage '${coverageSlug}' does not take a bonus tier`,
    );
  }
  return { needsTier };
}

export function assertCoverageSpellSlugParam(
  coverageSlug: string,
  spellSlug: string | undefined,
): { isEnspelled: boolean } {
  const isEnspelled = isEnspelledCoverageSlug(coverageSlug);
  if (isEnspelled) {
    if (!spellSlug?.trim()) {
      throw new BadRequestException(
        `Coverage '${coverageSlug}' requires spellSlug`,
      );
    }
  } else if (spellSlug != null) {
    throw new BadRequestException(
      `Coverage '${coverageSlug}' does not take a bound spell`,
    );
  }
  return { isEnspelled };
}

export function assertEnspelledSpellOrThrow(
  coverageSlug: string,
  spell: { slug: string; level: number; schoolSlug: string },
): void {
  try {
    assertEnspelledBoundSpell({
      itemSlug: coverageSlug,
      spellSlug: spell.slug,
      spellLevel: Number(spell.level),
      schoolSlug: spell.schoolSlug,
    });
  } catch (error) {
    throw new BadRequestException(
      error instanceof Error ? error.message : 'Invalid enspelled spell',
    );
  }
}

export function isSameCoverageAttachment(
  baseRow: {
    attachedCoverageSlug: string | null;
    attachedCoverageBonus: number | null;
    attachedCoverageSpellSlug: string | null;
  },
  coverageSlug: string,
  bonus: 1 | 2 | 3 | undefined,
  spellSlug: string | undefined,
): boolean {
  return (
    baseRow.attachedCoverageSlug === coverageSlug &&
    (baseRow.attachedCoverageBonus ?? null) === (bonus ?? null) &&
    (baseRow.attachedCoverageSpellSlug ?? null) === (spellSlug ?? null)
  );
}
