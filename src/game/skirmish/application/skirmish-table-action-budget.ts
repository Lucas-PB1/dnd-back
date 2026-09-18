import { applyDeclaredEconomyTableAction } from '@game/session/application/table-actions/apply-declared-economy';
import { resolveSkirmishAttackBudget } from './skirmish-attack-budget';

/**
 * Side-effect skirmish do Surto de Ação após economy tipada.
 * Extraído para spec unitária sem Nest.
 */
export async function applyActionSurgeAttackBudget(input: {
  mechanicalCatalog: Parameters<typeof resolveSkirmishAttackBudget>[0];
  character: Parameters<typeof resolveSkirmishAttackBudget>[1];
  turnAttacksRemaining: number | null;
}): Promise<{ turnAttacksRemaining: number; extra: number }> {
  const extra = await resolveSkirmishAttackBudget(
    input.mechanicalCatalog,
    input.character,
  );
  return {
    extra,
    turnAttacksRemaining: (input.turnAttacksRemaining ?? 0) + extra,
  };
}

export type SkirmishEconomyTableActionDeps = Parameters<
  typeof applyDeclaredEconomyTableAction
>[0];
