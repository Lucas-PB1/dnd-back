import { choiceKindForOptionKey } from '@catalog/game-port';

/**
 * Filtra grants de recurso de espécie pelas mesmas gates `requires_option_*`
 * das economy actions (ex.: C055) — SSOT do catálogo, sem lista de slugs.
 */

export type SpeciesChoiceRef = {
  choiceKind: string;
  choiceSlug: string;
};

export type SpeciesResourceOptionGate = {
  resourceSlug: string;
  requiresOptionKey: string | null;
  requiresOptionValue: string | null;
};

export { choiceKindForOptionKey };

function choiceSlugForOptionKey(
  optionKey: string,
  choices: readonly SpeciesChoiceRef[],
): string | null {
  const choiceKind = choiceKindForOptionKey(optionKey);
  const found = choices.find((c) => c.choiceKind === choiceKind)?.choiceSlug;
  return found ?? null;
}

function gateMatchesChoices(
  gate: SpeciesResourceOptionGate,
  choices: readonly SpeciesChoiceRef[],
): boolean {
  const key = gate.requiresOptionKey;
  const value = gate.requiresOptionValue;
  if (!key || !value) return true;
  return choiceSlugForOptionKey(key, choices) === value;
}

/**
 * Mantém o recurso se não há gate, se há linha sem option, ou se alguma
 * gate casa com as choices (pool compartilhado + vários botões, ex. Goliath).
 */
export function isSpeciesResourceAllowedByChoices(
  resourceSlug: string,
  gates: readonly SpeciesResourceOptionGate[],
  choices: readonly SpeciesChoiceRef[],
): boolean {
  const forSlug = gates.filter((g) => g.resourceSlug === resourceSlug);
  if (forSlug.length === 0) return true;

  const gated = forSlug.filter(
    (g) => g.requiresOptionKey && g.requiresOptionValue,
  );
  if (gated.length === 0) return true;

  const ungated = forSlug.some(
    (g) => !g.requiresOptionKey || !g.requiresOptionValue,
  );
  if (ungated) return true;

  return gated.some((g) => gateMatchesChoices(g, choices));
}

export function filterSpeciesResourceScheduleByChoices<
  T extends { resourceSlug: string },
>(
  rows: readonly T[],
  gates: readonly SpeciesResourceOptionGate[],
  choices: readonly SpeciesChoiceRef[],
): T[] {
  return rows.filter((row) =>
    isSpeciesResourceAllowedByChoices(row.resourceSlug, gates, choices),
  );
}
