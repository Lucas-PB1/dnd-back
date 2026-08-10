/** Validação de cast de magia via carga de item (fase 6). */

import { BadRequestException } from '@nestjs/common';
import { isEnspelledEconomyItemSlug } from '@game/inventory/domain/coverage/enspelled-weapon';

export type ItemCastEconomyMatch = {
  actionId: string;
  itemSlug: string;
  spellSlug: string | null;
  resourceSlug: string | null;
  spendAmount: number | null;
};

export type ItemCastBoundSpellRow = {
  attachedCoverageSpellSlug: string;
};

/** Confirma que a row de economy autoriza o cast pedido. */
export function assertItemCastEconomyAllows(input: {
  matches: readonly ItemCastEconomyMatch[];
  spellSlug: string;
  resourceSlug: string;
  spendAmount: number;
  boundSpellSlug: string | null;
}): ItemCastEconomyMatch {
  const { matches, spellSlug, resourceSlug, spendAmount, boundSpellSlug } =
    input;

  const fixed = matches.find(
    (row) =>
      row.resourceSlug === resourceSlug &&
      row.spendAmount === spendAmount &&
      row.spellSlug === spellSlug,
  );
  if (fixed) return fixed;

  const bound = matches.find(
    (row) =>
      row.resourceSlug === resourceSlug &&
      row.spendAmount === spendAmount &&
      row.spellSlug == null &&
      isEnspelledEconomyItemSlug(row.itemSlug),
  );
  if (bound && boundSpellSlug === spellSlug) return bound;

  throw new BadRequestException(
    `Item cast not allowed for spell '${spellSlug}' with resource '${resourceSlug}' ×${spendAmount}`,
  );
}

/** Cast gratuito de item (sem resource / spend) — ex. Magi custo 0. */
export function assertItemFreeSpellCastAllows(input: {
  matches: readonly ItemCastEconomyMatch[];
  spellSlug: string;
  itemSlug: string;
}): ItemCastEconomyMatch {
  const { matches, spellSlug, itemSlug } = input;
  const free = matches.find(
    (row) =>
      row.itemSlug === itemSlug &&
      row.spellSlug === spellSlug &&
      (row.resourceSlug == null || row.resourceSlug === '') &&
      (row.spendAmount == null || row.spendAmount === 0),
  );
  if (free) return free;

  throw new BadRequestException(
    `Item free cast not allowed for spell '${spellSlug}' on item '${itemSlug}'`,
  );
}
