import type { Repository } from 'typeorm';
import type { GameActorAction } from '@game/actor/infrastructure/game-actor-action.entity';

/**
 * Espíritos PHB usam bônus de ataque mágico do invocador (seed deixa NULL).
 * Preenche ações com dano e sem bônus.
 */
export async function ensureActorAttackBonusFromCaster(input: {
  actions: Repository<GameActorAction>;
  actorId: string;
  spellAttackBonus: number;
}): Promise<number> {
  const rows = await input.actions.find({ where: { actorId: input.actorId } });
  let patched = 0;
  for (const row of rows) {
    if (row.attackBonus != null) continue;
    if (!row.damageExpression?.trim()) continue;
    row.attackBonus = input.spellAttackBonus;
    await input.actions.save(row);
    patched += 1;
  }
  return patched;
}
