import {
  BLAST_INVOCATION_SLUGS,
  ELDRITCH_INVOCATION_CANTRIP_OPTION_KEY,
  ELDRITCH_INVOCATION_OPTION_KEY,
  isBlastInvocationSlug,
  warlockInvocationLimit,
  type BlastInvocationSlug,
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

export type EldritchBlastCantripBinding = {
  instanceIndex: number;
  invocationSlug: BlastInvocationSlug;
  cantripSlug: string;
};

/** Metadados mínimos do truque para elegibilidade PHB 2024. */
export type EldritchCantripEligibility = {
  slug: string;
  /** Truque (nível 0) conhecido como magia de Bruxo. */
  isWarlockCantrip: boolean;
  requiresAttackRoll: boolean;
  /** Alcance em metros (heurística a partir do texto do catálogo). */
  rangeMeters: number | null;
  /**
   * Causa dano: ataque, salvaguarda típica de dano, ou descrição com dado de dano.
   * Sem coluna dedicada na view — heurística documentada.
   */
  dealsDamage: boolean;
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

export function readEldritchInvocationCantripBindings(
  classOptions: readonly ClassOptionLike[] | null | undefined,
): EldritchBlastCantripBinding[] {
  const picksByIndex = new Map(
    readEldritchInvocationPicks(classOptions).map((pick) => [
      pick.instanceIndex,
      pick.slug,
    ]),
  );
  const bindings: EldritchBlastCantripBinding[] = [];
  for (const option of classOptions ?? []) {
    if (option.optionKey !== ELDRITCH_INVOCATION_CANTRIP_OPTION_KEY) continue;
    const instanceIndex = option.instanceIndex ?? 0;
    const invocationSlug = picksByIndex.get(instanceIndex);
    if (!invocationSlug || !isBlastInvocationSlug(invocationSlug)) continue;
    bindings.push({
      instanceIndex,
      invocationSlug,
      cantripSlug: option.valueId,
    });
  }
  return bindings.sort((a, b) => a.instanceIndex - b.instanceIndex);
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
 * Extrai alcance em metros a partir do texto do catálogo (ex.: "36 metros", "120 feet").
 */
export function parseSpellRangeMeters(
  rangeText: string | null | undefined,
): number | null {
  if (!rangeText) return null;
  const meters = rangeText.match(/(\d+(?:[.,]\d+)?)\s*m(?:etro)?/i);
  if (meters) {
    return Number(meters[1].replace(',', '.'));
  }
  const feet = rangeText.match(/(\d+(?:[.,]\d+)?)\s*(?:ft|feet|pés|pes)/i);
  if (feet) {
    return Number(feet[1].replace(',', '.')) * 0.3;
  }
  return null;
}

export function inferSpellDealsDamage(input: {
  requiresAttackRoll: boolean;
  saveAbilitySlug?: string | null;
  description?: string | null;
}): boolean {
  if (input.requiresAttackRoll) return true;
  if (input.saveAbilitySlug) return true;
  const text = input.description ?? '';
  return /\d+\s*d\s*\d+/i.test(text) && /dano|damage/i.test(text);
}

export function cantripEligibleForBlastInvocation(
  invocationSlug: BlastInvocationSlug,
  cantrip: EldritchCantripEligibility,
): boolean {
  if (!cantrip.isWarlockCantrip) return false;
  if (invocationSlug === 'repelling-blast') {
    return cantrip.requiresAttackRoll;
  }
  if (invocationSlug === 'eldritch-spear') {
    return (
      cantrip.dealsDamage &&
      cantrip.rangeMeters != null &&
      cantrip.rangeMeters >= 3
    );
  }
  return cantrip.dealsDamage;
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

/**
 * Valida siblings eldritch-invocation-cantrip para picks de blast.
 */
export function validateEldritchBlastCantripBindings(input: {
  picks: readonly { slug: string; instanceIndex: number }[];
  bindings: readonly EldritchBlastCantripBinding[];
  cantripsBySlug: ReadonlyMap<string, EldritchCantripEligibility>;
}): string[] {
  const errors: string[] = [];
  const bindingByIndex = new Map(
    input.bindings.map((binding) => [binding.instanceIndex, binding]),
  );
  const usedCantripByInvocation = new Map<string, Set<string>>();

  for (const pick of input.picks) {
    if (!isBlastInvocationSlug(pick.slug)) continue;
    const binding = bindingByIndex.get(pick.instanceIndex);
    if (!binding) {
      errors.push(
        `Invocação '${pick.slug}' (slot ${pick.instanceIndex}) requer um truque vinculado`,
      );
      continue;
    }
    if (binding.invocationSlug !== pick.slug) {
      errors.push(
        `Truque vinculado no slot ${pick.instanceIndex} não corresponde a '${pick.slug}'`,
      );
      continue;
    }
    const cantrip = input.cantripsBySlug.get(binding.cantripSlug);
    if (!cantrip || !cantrip.isWarlockCantrip) {
      errors.push(
        `Truque '${binding.cantripSlug}' não é um truque de Bruxo conhecido`,
      );
      continue;
    }
    if (!cantripEligibleForBlastInvocation(pick.slug, cantrip)) {
      errors.push(
        `Truque '${binding.cantripSlug}' não é elegível para '${pick.slug}'`,
      );
      continue;
    }
    const used = usedCantripByInvocation.get(pick.slug) ?? new Set<string>();
    if (used.has(binding.cantripSlug)) {
      errors.push(
        `Truque '${binding.cantripSlug}' já está vinculado a outra '${pick.slug}'`,
      );
    }
    used.add(binding.cantripSlug);
    usedCantripByInvocation.set(pick.slug, used);
  }

  for (const binding of input.bindings) {
    const pick = input.picks.find(
      (row) => row.instanceIndex === binding.instanceIndex,
    );
    if (!pick || !isBlastInvocationSlug(pick.slug)) {
      errors.push(
        `Vínculo de truque órfão no slot ${binding.instanceIndex} ('${binding.cantripSlug}')`,
      );
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

/** Notas de combate ao conjurar o truque vinculado a Explosão Agonizante / Repulsiva / Lança. */
export function buildEldritchCantripCastNote(input: {
  spellLevel: number;
  spellSlug: string;
  bindings: readonly EldritchBlastCantripBinding[];
  charismaModifier: number;
  warlockLevel: number;
}): string | null {
  if (input.spellLevel !== 0) return null;
  const matching = input.bindings.filter(
    (binding) => binding.cantripSlug === input.spellSlug,
  );
  if (matching.length === 0) return null;

  const parts: string[] = [];
  const kinds = new Set(matching.map((binding) => binding.invocationSlug));
  if (kinds.has('agonizing-blast')) {
    const bonus = Math.max(0, input.charismaModifier);
    parts.push(`Explosão Agonizante: +${bonus} de Carisma no dano`);
  }
  if (kinds.has('repelling-blast')) {
    parts.push('Explosão Repulsiva: empurre até 3 m (Grande ou menor)');
  }
  if (kinds.has('eldritch-spear')) {
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

export { BLAST_INVOCATION_SLUGS, isBlastInvocationSlug };
