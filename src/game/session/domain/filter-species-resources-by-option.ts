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

/** option_key do catálogo → choiceKind na ficha (espelha front class-action-economy). */
const OPTION_KEY_TO_CHOICE_KIND: Record<string, string> = {
  giantAncestryId: 'giant_ancestry',
  constructionId: 'geppettin_construction',
  dragonAncestryId: 'dragon_ancestry',
  lineageId: 'elf_lineage',
  gnomeLineageId: 'gnome_lineage',
  infernalLegacyId: 'infernal_legacy',
  serviceModelId: 'manikin_service_model',
  armorPresetId: 'manikin_armor',
  monstrousLineageId: 'scourgeborne_lineage',
  madnessId: 'scourgeborne_madness',
  bearfolkLineageId: 'bearfolk_lineage',
  naturalAdaptationId: 'beastkin_adaptation',
  giantkinAncestryId: 'giantkin_ancestry',
  trollkinAncestryId: 'trollkin_ancestry',
  seasonId: 'mandrake_season',
};

export function choiceKindForOptionKey(optionKey: string): string {
  return OPTION_KEY_TO_CHOICE_KIND[optionKey] ?? optionKey;
}

function gateMatchesChoices(
  gate: SpeciesResourceOptionGate,
  choices: readonly SpeciesChoiceRef[],
): boolean {
  const key = gate.requiresOptionKey;
  const value = gate.requiresOptionValue;
  if (!key || !value) return true;
  const choiceKind = choiceKindForOptionKey(key);
  return choices.some(
    (c) => c.choiceKind === choiceKind && c.choiceSlug === value,
  );
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
