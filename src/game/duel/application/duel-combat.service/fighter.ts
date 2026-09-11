import { BadRequestException } from '@nestjs/common';
import { rollExpression } from '@game/dice/domain/dice';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  hasTacticalShift,
  isFighterClass,
  secondWindHealDice,
} from '@game/combat/domain/fighter';
import { assertCanTakeDuelAction } from '../../domain/duel-combat-gates';
import { appendCombatLog } from '../../domain/combat-log';
import { healMemberVitals } from '../../domain/duel-member-vitals';
import type { DuelRepository } from '../../infrastructure/duel.repository';
import type { Duel } from '../../infrastructure/duel.entity';
import type { DuelMember } from '../../infrastructure/duel-member.entity';
import type { DuelCombatSnapshot } from '../duel-combat-snapshot';
import { loadConditions, type ConditionsDeps } from './conditions';

export type FighterDeps = {
  repo: DuelRepository;
  state: CharacterStateRepository;
  access: PlayerCharacterAccessService;
  snapshot: DuelCombatSnapshot;
};

function conditionsDeps(deps: FighterDeps): ConditionsDeps {
  return { repo: deps.repo, state: deps.state };
}

export async function useSecondWind(
  deps: FighterDeps,
  userId: string,
  duelId: string,
): Promise<{ duel: Duel; members: DuelMember[] }> {
  const { duel, members } = await deps.repo.getForMember(userId, duelId);
  deps.repo.assertStatus(duel, ['active']);
  const actor = members.find((m) => m.userId === userId);
  if (!actor) throw new BadRequestException('Not a duel member');
  if (duel.turnCharacterId !== actor.characterId) {
    throw new BadRequestException('Not your turn');
  }
  assertCanTakeDuelAction(
    await loadConditions(conditionsDeps(deps), actor.characterId, members),
  );

  const character = await deps.access.findOwnedOrFail(
    userId,
    actor.characterId,
  );
  if (!isFighterClass(character.classSlug)) {
    throw new BadRequestException('Recuperar Fôlego exige Guerreiro');
  }

  await deps.state.useClassResource(character, 'secondWind', 1);
  const healRoll = rollExpression(secondWindHealDice(character.level));
  const healed = healMemberVitals(actor, healRoll.total);
  await deps.repo.saveMember(actor);

  let note = `${character.name}: Recuperar Fôlego (${healRoll.expression}) — ${healed.before} → ${healed.after} PV.`;
  if (hasTacticalShift(character.level)) {
    note += ' Ajuste Tático: mova-se até metade do Deslocamento sem provocar AO.';
  }
  duel.combatLog = appendCombatLog(duel.combatLog, note);
  const saved = await deps.repo.saveDuel(duel);
  return { duel: saved, members };
}

export async function useActionSurge(
  deps: FighterDeps,
  userId: string,
  duelId: string,
): Promise<{ duel: Duel; members: DuelMember[] }> {
  const { duel, members } = await deps.repo.getForMember(userId, duelId);
  deps.repo.assertStatus(duel, ['active']);
  const actor = members.find((m) => m.userId === userId);
  if (!actor) throw new BadRequestException('Not a duel member');
  if (duel.turnCharacterId !== actor.characterId) {
    throw new BadRequestException('Not your turn');
  }
  assertCanTakeDuelAction(
    await loadConditions(conditionsDeps(deps), actor.characterId, members),
  );

  const character = await deps.access.findOwnedOrFail(
    userId,
    actor.characterId,
  );
  if (!isFighterClass(character.classSlug) || character.level < 2) {
    throw new BadRequestException('Surto de Ação exige Guerreiro nível 2+');
  }

  await deps.state.useClassResource(character, 'actionSurge', 1);
  const extra = await deps.snapshot.resolveTurnAttackBudget(character);
  duel.turnAttacksRemaining = (duel.turnAttacksRemaining ?? 0) + extra;
  duel.combatLog = appendCombatLog(
    duel.combatLog,
    `${character.name}: Surto de Ação — +${extra} ataque(s) neste turno (restantes: ${duel.turnAttacksRemaining}).`,
  );
  const saved = await deps.repo.saveDuel(duel);
  return { duel: saved, members };
}
