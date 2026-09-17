import type { SkirmishCombatant } from '../infrastructure/skirmish-combatant.entity';

export type ActorAllianceHint = {
  actorId: string;
  parentCharacterId: string | null;
};

/** Aliado do PC se o actor tem `parentCharacterId` = personagem do skirmish. */
export function isAlliedSkirmishActor(
  actor: ActorAllianceHint,
  skirmishCharacterId: string,
): boolean {
  return actor.parentCharacterId === skirmishCharacterId;
}

/**
 * Alvo do turno automático:
 * - aliado (espírito/companion) → inimigo (actor não-aliado)
 * - inimigo → PC
 */
export function pickAutomaticSkirmishTarget(input: {
  attacker: SkirmishCombatant;
  combatants: readonly SkirmishCombatant[];
  skirmishCharacterId: string;
  actorHints: readonly ActorAllianceHint[];
}): SkirmishCombatant | null {
  const hintById = new Map(
    input.actorHints.map((row) => [row.actorId, row] as const),
  );
  if (input.attacker.kind === 'pc') {
    return findFoeSkirmishCombatant({
      combatants: input.combatants,
      skirmishCharacterId: input.skirmishCharacterId,
      actorHints: input.actorHints,
    });
  }
  if (!input.attacker.actorId) return null;
  const hint = hintById.get(input.attacker.actorId);
  const allied =
    hint != null &&
    isAlliedSkirmishActor(hint, input.skirmishCharacterId);
  if (allied) {
    return findFoeSkirmishCombatant({
      combatants: input.combatants,
      skirmishCharacterId: input.skirmishCharacterId,
      actorHints: input.actorHints,
    });
  }
  return input.combatants.find((row) => row.kind === 'pc') ?? null;
}

export function findFoeSkirmishCombatant(input: {
  combatants: readonly SkirmishCombatant[];
  skirmishCharacterId: string;
  actorHints: readonly ActorAllianceHint[];
}): SkirmishCombatant | null {
  const hintById = new Map(
    input.actorHints.map((row) => [row.actorId, row] as const),
  );
  for (const row of input.combatants) {
    if (row.kind !== 'actor' || !row.actorId || !row.isActive) continue;
    const hint = hintById.get(row.actorId);
    if (!hint) return row;
    if (!isAlliedSkirmishActor(hint, input.skirmishCharacterId)) return row;
  }
  return null;
}

/** PHB: espírito age logo após o invocador (mesmo total, mod menor). */
export function spiritInitiativeAfterPc(input: {
  pcInitiativeTotal: number | null;
  pcInitiativeModifier: number | null;
}): { initiativeTotal: number; initiativeModifier: number } {
  const total = input.pcInitiativeTotal ?? 10;
  const mod = input.pcInitiativeModifier ?? 0;
  return { initiativeTotal: total, initiativeModifier: mod - 1 };
}
