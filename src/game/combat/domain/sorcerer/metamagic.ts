/** Opções de Metamagia — regras de picks (catálogo vive em `rpg.phb_metamagic`). */

export const METAMAGIC_OPTION_KEY = 'metamagic';

export type MetamagicCatalogRow = {
  slug: string;
  name: string;
  cost: number;
  description: string;
  stacksWithOther: boolean;
};

/** L2: 2 · L10: 4 · L17: 6 */
export function sorcererMetamagicLimit(level: number): number {
  if (level >= 17) return 6;
  if (level >= 10) return 4;
  if (level >= 2) return 2;
  return 0;
}

export type ClassOptionLike = {
  optionKey: string;
  valueId: string;
  instanceIndex?: number;
};

export function readMetamagicPicks(
  classOptions: readonly ClassOptionLike[] | null | undefined,
): { slug: string; instanceIndex: number }[] {
  const picks: { slug: string; instanceIndex: number }[] = [];
  for (const option of classOptions ?? []) {
    if (option.optionKey !== METAMAGIC_OPTION_KEY) continue;
    picks.push({
      slug: option.valueId,
      instanceIndex: option.instanceIndex ?? 0,
    });
  }
  return picks.sort((a, b) => a.instanceIndex - b.instanceIndex);
}

export function validateMetamagicPicks(input: {
  level: number;
  picks: readonly { slug: string }[];
  catalog: readonly MetamagicCatalogRow[];
}): string[] {
  const errors: string[] = [];
  const limit = sorcererMetamagicLimit(input.level);
  if (input.picks.length > limit) {
    errors.push(
      `Feiticeiro nível ${input.level} pode ter no máximo ${limit} opção(ões) de Metamagia`,
    );
  }
  const known = new Set(input.catalog.map((row) => row.slug));
  const seen = new Set<string>();
  for (const pick of input.picks) {
    if (!known.has(pick.slug)) {
      errors.push(`Opção de Metamagia desconhecida: '${pick.slug}'`);
      continue;
    }
    if (seen.has(pick.slug)) {
      errors.push(`Metamagia duplicada: '${pick.slug}'`);
    }
    seen.add(pick.slug);
  }
  return errors;
}
