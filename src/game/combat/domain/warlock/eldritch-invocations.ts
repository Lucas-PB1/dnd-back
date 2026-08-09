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

/** Linha com efeitos de combate / free cast (catálogo completo). */
export type EldritchInvocationEffectRow = EldritchInvocationCatalogRow & {
  kind: string;
  grantedSpellSlug: string | null;
};

export type ClassOptionLike = {
  optionKey: string;
  valueId: string;
  instanceIndex?: number;
};

/** Presente das Profundezas: free cast 1×/Descanso Longo (demais free_cast = à vontade). */
export const GIFT_OF_THE_DEPTHS_SLUG = 'gift-of-the-depths';

export type EldritchFreeCastResolution = {
  invocationSlug: string;
  invocationName: string;
  economy: 'at_will' | 'once_per_long_rest';
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

export function collectEldritchFreeCastSpellSlugs(
  pickedSlugs: readonly string[],
  catalog: readonly Pick<
    EldritchInvocationEffectRow,
    'slug' | 'kind' | 'grantedSpellSlug'
  >[],
): Set<string> {
  const picked = new Set(pickedSlugs);
  const spells = new Set<string>();
  for (const row of catalog) {
    if (!picked.has(row.slug)) continue;
    if (row.kind !== 'free_cast') continue;
    if (!row.grantedSpellSlug) continue;
    spells.add(row.grantedSpellSlug);
  }
  return spells;
}

/**
 * Resolve free cast de Invocação Mística para a magia (se o personagem a conhece via pick).
 */
export function resolveEldritchInvocationFreeCast(input: {
  spellSlug: string;
  pickedSlugs: readonly string[];
  catalog: readonly Pick<
    EldritchInvocationEffectRow,
    'slug' | 'name' | 'kind' | 'grantedSpellSlug'
  >[];
}): EldritchFreeCastResolution | null {
  const picked = new Set(input.pickedSlugs);
  for (const row of input.catalog) {
    if (!picked.has(row.slug)) continue;
    if (row.kind !== 'free_cast') continue;
    if (row.grantedSpellSlug !== input.spellSlug) continue;
    return {
      invocationSlug: row.slug,
      invocationName: row.name,
      economy:
        row.slug === GIFT_OF_THE_DEPTHS_SLUG
          ? 'once_per_long_rest'
          : 'at_will',
    };
  }
  return null;
}

/** Notas de combate ao conjurar truque com Explosão Agonizante / Repulsiva / Lança. */
export function buildEldritchCantripCastNote(input: {
  spellLevel: number;
  pickedSlugs: readonly string[];
  charismaModifier: number;
  warlockLevel: number;
}): string | null {
  if (input.spellLevel !== 0) return null;
  const picked = new Set(input.pickedSlugs);
  const parts: string[] = [];
  if (picked.has('agonizing-blast')) {
    const bonus = Math.max(0, input.charismaModifier);
    parts.push(`Explosão Agonizante: +${bonus} de Carisma no dano`);
  }
  if (picked.has('repelling-blast')) {
    parts.push('Explosão Repulsiva: empurre até 3 m (Grande ou menor)');
  }
  if (picked.has('eldritch-spear')) {
    const rangeBonus = 9 * Math.max(1, input.warlockLevel);
    parts.push(`Lança Mística: alcance +${rangeBonus} m`);
  }
  return parts.length > 0 ? parts.join(' · ') : null;
}

/**
 * Escolhe até `limit` invocações válidas aleatoriamente (greedy + shuffle).
 * Útil para seeds / fichas de review.
 */
export function pickRandomValidEldritchInvocations(input: {
  level: number;
  catalog: readonly EldritchInvocationCatalogRow[];
  limit?: number;
  random?: () => number;
}): { slug: string; instanceIndex: number }[] {
  const limit = input.limit ?? warlockInvocationLimit(input.level);
  const random = input.random ?? Math.random;
  const eligible = input.catalog.filter((row) => row.minLevel <= input.level);
  const picks: { slug: string; instanceIndex: number }[] = [];

  while (picks.length < limit) {
    const candidates = shuffle(
      eligible.filter((row) => {
        const trial = [
          ...picks,
          { slug: row.slug, instanceIndex: picks.length },
        ];
        return (
          validateEldritchInvocationPicks({
            level: input.level,
            picks: trial,
            catalog: input.catalog,
          }).length === 0
        );
      }),
      random,
    );
    if (candidates.length === 0) break;
    picks.push({ slug: candidates[0].slug, instanceIndex: picks.length });
  }

  return picks;
}

function shuffle<T>(items: readonly T[], random: () => number): T[] {
  const next = [...items];
  for (let i = next.length - 1; i > 0; i -= 1) {
    const j = Math.floor(random() * (i + 1));
    [next[i], next[j]] = [next[j], next[i]];
  }
  return next;
}
