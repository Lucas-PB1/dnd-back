import type { Repository } from 'typeorm';
import type { GameActor } from '@game/actor/infrastructure/game-actor.entity';
import type { GameActorAction } from '@game/actor/infrastructure/game-actor-action.entity';
import type { SkirmishRepository } from '../infrastructure/skirmish.repository';
import type { SkirmishCombatant } from '../infrastructure/skirmish-combatant.entity';
import { spiritInitiativeAfterPc } from '../domain/skirmish-alliance';
import { ensureActorAttackBonusFromCaster } from './ensure-actor-attack-bonus';

/**
 * Adiciona atores aliados (espírito / companion) à iniciativa após o PC.
 * Não remove o monstro inimigo nem outros aliados já presentes.
 */
export async function addAlliedActorsToSkirmish(input: {
  repo: SkirmishRepository;
  actors: Repository<GameActor>;
  actorActions: Repository<GameActorAction>;
  skirmishId: string;
  pcCombatant: SkirmishCombatant;
  allyActorIds: readonly string[];
  spellAttackBonus: number;
}): Promise<SkirmishCombatant[]> {
  const remaining = await input.repo.listCombatants(input.skirmishId);
  const present = new Set(
    remaining.filter((r) => r.actorId).map((r) => r.actorId!),
  );
  const init = spiritInitiativeAfterPc({
    pcInitiativeTotal: input.pcCombatant.initiativeTotal,
    pcInitiativeModifier: input.pcCombatant.initiativeModifier,
  });
  const added: SkirmishCombatant[] = [];
  for (const actorId of input.allyActorIds) {
    if (present.has(actorId)) continue;
    const actor = await input.actors.findOne({ where: { id: actorId } });
    if (!actor) continue;
    await ensureActorAttackBonusFromCaster({
      actions: input.actorActions,
      actorId,
      spellAttackBonus: input.spellAttackBonus,
    });
    added.push(
      input.repo.createCombatant({
        skirmishId: input.skirmishId,
        kind: 'actor',
        characterId: null,
        actorId,
        displayName: actor.name,
        initiativeTotal: init.initiativeTotal,
        initiativeModifier: init.initiativeModifier,
        sortOrder: remaining.length + added.length,
        isActive: true,
      }),
    );
  }
  if (added.length > 0) {
    await input.repo.saveCombatants(added);
  }
  return added;
}

/** Remove combatentes cujo actor sumiu (CASCADE / despawn concentração). */
export async function pruneMissingActorCombatants(input: {
  repo: SkirmishRepository;
  actors: Repository<GameActor>;
  skirmishId: string;
  currentCombatantId: string | null;
}): Promise<{ removed: number; currentCleared: boolean }> {
  const combatants = await input.repo.listCombatants(input.skirmishId);
  let removed = 0;
  let currentCleared = false;
  for (const row of combatants) {
    if (row.kind !== 'actor' || !row.actorId) continue;
    const actor = await input.actors.findOne({ where: { id: row.actorId } });
    if (actor) continue;
    if (input.currentCombatantId === row.id) currentCleared = true;
    await input.repo.deleteCombatant(row.id);
    removed += 1;
  }
  return { removed, currentCleared };
}
