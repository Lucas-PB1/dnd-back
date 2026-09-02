import { BadRequestException } from '@nestjs/common';

type CatalogBenefit = {
  benefitKey: string;
  choiceGroup: string | null;
};

export function resolveChosenBenefitKeys(
  benefits: CatalogBenefit[],
  requestedKeys: string[],
): string[] {
  if (benefits.length === 0) {
    throw new BadRequestException('Milestone sem benefícios no catálogo');
  }

  const requested = new Set(requestedKeys.map((key) => key.trim()).filter(Boolean));
  const autoKeys = benefits
    .filter((benefit) => benefit.choiceGroup == null)
    .map((benefit) => benefit.benefitKey);

  const groups = new Map<string, string[]>();
  for (const benefit of benefits) {
    if (benefit.choiceGroup == null) continue;
    const list = groups.get(benefit.choiceGroup) ?? [];
    list.push(benefit.benefitKey);
    groups.set(benefit.choiceGroup, list);
  }

  const chosen: string[] = [...autoKeys];
  for (const [group, keys] of groups) {
    const picks = keys.filter((key) => requested.has(key));
    if (picks.length !== 1) {
      throw new BadRequestException(
        `Escolha exatamente um benefício do grupo '${group}' (opções: ${keys.join(', ')})`,
      );
    }
    chosen.push(picks[0]!);
  }

  for (const key of requested) {
    if (!benefits.some((benefit) => benefit.benefitKey === key)) {
      throw new BadRequestException(`Benefício '${key}' inválido para este milestone`);
    }
  }

  return chosen;
}
