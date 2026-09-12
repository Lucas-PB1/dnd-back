import { BadRequestException } from '@nestjs/common';

export type SpiritSelectionInput = {
  variantKey: string;
  count: number;
};

export type SpiritVariantBudget = {
  variantKey: string;
  templateSlug: string;
  label: string;
  budgetCost: number;
};

export type ResolvedSpiritSpawn = SpiritVariantBudget & {
  count: number;
};

/** Normaliza variantKey+count ou lista de selections. */
export function resolveSpiritSelections(input: {
  variantKey?: string;
  spiritCount?: number;
  selections?: SpiritSelectionInput[];
}): SpiritSelectionInput[] {
  if (input.selections != null && input.selections.length > 0) {
    return input.selections.map((s) => ({
      variantKey: s.variantKey,
      count: s.count,
    }));
  }
  if (input.variantKey) {
    return [
      {
        variantKey: input.variantKey,
        count: input.spiritCount ?? 1,
      },
    ];
  }
  return [];
}

/**
 * Valida variantes e orçamento.
 * Magias com algum budget_cost > 1 (Animar Objetos): total ≤ castingAbilityMod.
 * Demais: no máximo 1 actor no total.
 */
export function planSpiritSpawns(input: {
  spellSlug: string;
  selections: SpiritSelectionInput[];
  variants: SpiritVariantBudget[];
  castingAbilityMod?: number | null;
}): ResolvedSpiritSpawn[] {
  if (input.selections.length === 0) {
    const keys = input.variants.map((v) => v.variantKey).join(', ');
    throw new BadRequestException(
      `spiritVariantKey é obrigatório para '${input.spellSlug}' (opções: ${keys})`,
    );
  }

  const byKey = new Map(input.variants.map((v) => [v.variantKey, v]));
  const planned: ResolvedSpiritSpawn[] = [];
  let totalUnits = 0;
  let totalCost = 0;
  const usesBudget = input.variants.some((v) => v.budgetCost > 1);

  for (const sel of input.selections) {
    if (!Number.isInteger(sel.count) || sel.count < 1) {
      throw new BadRequestException(
        `Quantidade inválida para variante '${sel.variantKey}'`,
      );
    }
    const variant = byKey.get(sel.variantKey);
    if (!variant) {
      const keys = input.variants.map((v) => v.variantKey).join(', ');
      throw new BadRequestException(
        `Variante '${sel.variantKey}' inválida para '${input.spellSlug}' (opções: ${keys})`,
      );
    }
    planned.push({ ...variant, count: sel.count });
    totalUnits += sel.count;
    totalCost += sel.count * variant.budgetCost;
  }

  if (usesBudget) {
    const mod = input.castingAbilityMod;
    if (mod == null || !Number.isFinite(mod)) {
      throw new BadRequestException(
        `Orçamento de '${input.spellSlug}' exige modificador de conjuração`,
      );
    }
    const budget = Math.max(0, Math.floor(mod));
    if (totalCost < 1 || totalCost > budget) {
      throw new BadRequestException(
        `Orçamento de '${input.spellSlug}': custo ${totalCost} (máx. ${budget} = mod. conjuração). Médio−=1, Grande=2, Enorme=3.`,
      );
    }
  } else if (totalUnits > 1) {
    throw new BadRequestException(
      `Magia '${input.spellSlug}' spawna no máximo 1 espírito`,
    );
  }

  return planned;
}
