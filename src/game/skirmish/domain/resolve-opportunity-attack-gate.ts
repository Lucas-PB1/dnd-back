const ACTION_BLOCKING = new Set([
  'incapacitated',
  'stunned',
  'paralyzed',
  'unconscious',
  'petrified',
]);

export const OPPORTUNITY_ATTACK_REACTION_SLUG = 'opportunity_attack' as const;

export type OpportunityAttackGateResult =
  | { ok: true }
  | { ok: false; reason: string };

/**
 * Sem mapa: 1 OA por turno da criatura se o PC tem reação e não está incapacitado.
 */
export function resolveOpportunityAttackGate(input: {
  currentTurnIsActor: boolean;
  reactionAvailable: boolean;
  opportunityAvailable: boolean;
  conditions: readonly string[];
}): OpportunityAttackGateResult {
  if (!input.currentTurnIsActor) {
    return { ok: false, reason: 'OA só no turno da criatura' };
  }
  if (!input.reactionAvailable) {
    return { ok: false, reason: 'Reação indisponível' };
  }
  if (!input.opportunityAvailable) {
    return { ok: false, reason: 'OA já usada neste turno' };
  }
  const blocked = input.conditions.find((c) => ACTION_BLOCKING.has(c));
  if (blocked) {
    return { ok: false, reason: `Cannot act while ${blocked}` };
  }
  return { ok: true };
}
