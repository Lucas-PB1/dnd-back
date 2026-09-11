import { BadRequestException } from '@nestjs/common';
import type { ClassEconomyActionRecord } from '@game/combat/domain/class-action-ui-catalog';
import type { SpendPlan, DeclaredEconomyTableActionOptions } from './types';

export function resolveSpendPlan(
  action: ClassEconomyActionRecord,
  options: DeclaredEconomyTableActionOptions,
): SpendPlan {
  if (options.amount != null && action.resourceSlug) {
    return { resourceSlug: action.resourceSlug, amount: options.amount };
  }
  const amount = action.spendAmount ?? 1;
  if (action.alwaysSpendsResource && action.resourceSlug) {
    return { resourceSlug: action.resourceSlug, amount };
  }
  if (action.freeResourceSlug) {
    if (options.usePsiDie) {
      if (!action.resourceSlug) {
        throw new BadRequestException(
          `${action.name}: pool pago indisponível`,
        );
      }
      return { resourceSlug: action.resourceSlug, amount };
    }
    return { resourceSlug: action.freeResourceSlug, amount: 1 };
  }
  return { resourceSlug: null, amount: 0 };
}

export function requireItemSlug(itemSlug: string | undefined): string {
  if (!itemSlug?.trim()) {
    throw new BadRequestException('itemSlug é obrigatório');
  }
  return itemSlug.trim();
}
