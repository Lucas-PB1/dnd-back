import {
  ELDRITCH_INVOCATION_OPTION_KEY,
  warlockInvocationLimit,
} from './features';

export type EldritchInvocationCatalogRow = {
  slug: string;
  name: string;
  minLevel: number;
  requiresPactSlug: string | null;
  requiresInvocationSlug: string | null;
  repeatable: boolean;
};

export type ClassOptionLike = {
  optionKey: string;
  valueId: string;
  instanceIndex?: number;
};

export function readEldritchInvocationPicks(
  classOptions: readonly ClassOptionLike[] | null | undefined,
): { slug: string; instanceIndex: number }[] {
  const picks: { slug: string; instanceIndex: number }[] = [];
  for (const option of classOptions ?? []) {
    if (option.optionKey !== ELDRITCH_INVOCATION_OPTION_KEY) continue;
    picks.push({
      slug: option.valueId,
      instanceIndex: option.instanceIndex ?? 0,
    });
  }
  return picks.sort((a, b) => a.instanceIndex - b.instanceIndex);
}

export function knownPactSlugsFromPicks(
  picks: readonly { slug: string }[],
): Set<string> {
  const set = new Set<string>();
  for (const pick of picks) {
    if (
      pick.slug === 'pact-of-the-tome' ||
      pick.slug === 'pact-of-the-blade' ||
      pick.slug === 'pact-of-the-chain'
    ) {
      set.add(pick.slug);
    }
  }
  return set;
}

/**
 * Valida picks contra catálogo e limite de nível.
 * Retorna mensagens de erro (vazio = ok).
 */
export function validateEldritchInvocationPicks(input: {
  level: number;
  picks: readonly { slug: string; instanceIndex: number }[];
  catalog: readonly EldritchInvocationCatalogRow[];
}): string[] {
  const errors: string[] = [];
  const limit = warlockInvocationLimit(input.level);
  if (input.picks.length > limit) {
    errors.push(
      `Bruxo nível ${input.level} permite até ${limit} invocação(ões); recebeu ${input.picks.length}`,
    );
  }

  const bySlug = new Map(input.catalog.map((row) => [row.slug, row]));
  const pickedSlugs = input.picks.map((p) => p.slug);
  const counts = new Map<string, number>();
  for (const slug of pickedSlugs) {
    counts.set(slug, (counts.get(slug) ?? 0) + 1);
  }

  const pactKnown = knownPactSlugsFromPicks(input.picks);
  const invocationKnown = new Set(pickedSlugs);

  for (const pick of input.picks) {
    const row = bySlug.get(pick.slug);
    if (!row) {
      errors.push(`Invocação desconhecida: '${pick.slug}'`);
      continue;
    }
    if (input.level < row.minLevel) {
      errors.push(
        `Invocação '${row.name}' requer Bruxo nível ${row.minLevel}`,
      );
    }
    if (row.requiresPactSlug && !pactKnown.has(row.requiresPactSlug)) {
      errors.push(
        `Invocação '${row.name}' requer ${row.requiresPactSlug}`,
      );
    }
    if (
      row.requiresInvocationSlug &&
      !invocationKnown.has(row.requiresInvocationSlug)
    ) {
      errors.push(
        `Invocação '${row.name}' requer ${row.requiresInvocationSlug}`,
      );
    }
    const count = counts.get(pick.slug) ?? 0;
    if (!row.repeatable && count > 1) {
      errors.push(`Invocação '${row.name}' não é repetível`);
    }
  }

  return errors;
}
