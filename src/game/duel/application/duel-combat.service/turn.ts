import {
  BLOOD_CONDITION_EXILE,
  BLOOD_STRIKE_RESOURCE_SLUG,
  canBloodSymphonyRefund,
} from '@game/combat/domain/fighter';
import {
  hasPendingEffect,
  removePendingEffect,
} from '@game/combat/domain/pending-combat-effect';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { appendCombatLog } from '../../domain/combat-log';
import { asArenaEffects } from '../../domain/arena-effects';
import { mergeConditions } from '../../domain/duel-spell-resolve';
import type { DuelRepository } from '../../infrastructure/duel.repository';
import type { Duel } from '../../infrastructure/duel.entity';
import type { DuelMember } from '../../infrastructure/duel-member.entity';
import type { DuelCombatSnapshot } from '../duel-combat-snapshot';
import { loadConditions, type ConditionsDeps } from './conditions';

export type TurnDeps = {
  repo: DuelRepository;
  state: CharacterStateRepository;
  snapshot: DuelCombatSnapshot;
};

function conditionsDeps(deps: TurnDeps): ConditionsDeps {
  return { repo: deps.repo, state: deps.state };
}

export async function afterDamage(
  deps: TurnDeps,
  input: {
    duel: Duel;
    members: DuelMember[];
    log: Duel['combatLog'];
    attacker: DuelMember;
    attackerName: string;
    defenderName: string;
    hitPointsAfter: number;
    bloodStrikeDamaged?: boolean;
    attackerPc?: PlayerCharacter;
    /** false = ação completa (magia); default true = gasta 1 ataque */
    spendAttack?: boolean;
  },
): Promise<{ duel: Duel; members: DuelMember[] }> {
  let { log } = input;
  await deps.repo.saveMembers(input.members);

  if (input.hitPointsAfter <= 0) {
    if (
      input.bloodStrikeDamaged &&
      input.attackerPc &&
      canBloodSymphonyRefund(input.attackerPc.level)
    ) {
      try {
        await deps.state.recoverClassResource(
          input.attackerPc,
          BLOOD_STRIKE_RESOURCE_SLUG,
          1,
        );
        log = appendCombatLog(
          log,
          `${input.attackerName}: Sinfonia de Sangue — recupera 1 Golpe de Sangue.`,
        );
      } catch {
        // pool já cheia — ignora
      }
    }
    log = appendCombatLog(
      log,
      `${input.defenderName} caiu. Vitória de ${input.attackerName}!`,
    );
    const finished = await deps.repo.finishDuel({
      duel: input.duel,
      winnerUserId: input.attacker.userId,
      winnerCharacterId: input.attacker.characterId,
      endReason: 'hp',
      combatLog: log,
    });
    return { duel: finished, members: input.members };
  }

  if (input.spendAttack === false) {
    await advanceTurnFully(
      deps,
      input.duel,
      input.members,
      input.attacker.characterId,
    );
  } else {
    await consumeAttackOrAdvance(
      deps,
      input.duel,
      input.members,
      input.attackerPc,
    );
  }
  await maybeSkipPendingExileTurn(deps, input.duel, input.members);
  input.duel.combatLog = log;
  const saved = await deps.repo.saveDuel(input.duel);
  return { duel: saved, members: input.members };
}

export async function afterAttackAction(
  deps: TurnDeps,
  input: {
    duel: Duel;
    members: DuelMember[];
    log: Duel['combatLog'];
    attackerPc: PlayerCharacter;
  },
): Promise<{ duel: Duel; members: DuelMember[] }> {
  await deps.repo.saveMembers(input.members);
  await consumeAttackOrAdvance(
    deps,
    input.duel,
    input.members,
    input.attackerPc,
  );
  await maybeSkipPendingExileTurn(deps, input.duel, input.members);
  input.duel.combatLog = input.log;
  const saved = await deps.repo.saveDuel(input.duel);
  return { duel: saved, members: input.members };
}

export async function consumeAttackOrAdvance(
  deps: TurnDeps,
  duel: Duel,
  members: DuelMember[],
  attackerPc: PlayerCharacter | undefined,
): Promise<void> {
  const remaining = (duel.turnAttacksRemaining ?? 1) - 1;
  duel.turnAttacksRemaining = Math.max(0, remaining);
  if (duel.turnAttacksRemaining <= 0) {
    await advanceTurnFully(
      deps,
      duel,
      members,
      attackerPc?.id ?? duel.turnCharacterId!,
    );
  }
}

export async function advanceTurnFully(
  deps: TurnDeps,
  duel: Duel,
  members: DuelMember[],
  currentCharacterId: string,
): Promise<void> {
  advanceTurn(duel, members, currentCharacterId);
  const nextId = duel.turnCharacterId;
  if (!nextId) return;
  const nextPc = await deps.repo.findCharacterById(nextId);
  duel.turnAttacksRemaining = await deps.snapshot.resolveTurnAttackBudget(
    nextPc ?? undefined,
  );
}

export function advanceTurn(
  duel: Duel,
  members: DuelMember[],
  currentCharacterId: string,
): void {
  const other = members.find((m) => m.characterId !== currentCharacterId);
  if (!other) return;

  const sorted = [...members].sort(
    (a, b) => (b.initiative ?? 0) - (a.initiative ?? 0),
  );
  const firstId = sorted[0]?.characterId;
  if (other.characterId === firstId && currentCharacterId !== firstId) {
    duel.round += 1;
  }
  duel.turnCharacterId = other.characterId;
}

/**
 * Pending `blood-exile` + incapacitado: perde o turno e limpa a condição.
 * Kind vem do catálogo (`on_fail_pending_kind`); o skip ainda é produto Sabujo.
 */
export async function maybeSkipPendingExileTurn(
  deps: TurnDeps,
  duel: Duel,
  members: DuelMember[],
): Promise<void> {
  const turnId = duel.turnCharacterId;
  if (!turnId || duel.status !== 'active') return;
  if (!hasPendingEffect(duel.arenaEffects, BLOOD_CONDITION_EXILE, turnId)) {
    return;
  }
  const conditions = await loadConditions(
    conditionsDeps(deps),
    turnId,
    members,
  );
  if (!conditions.includes('incapacitated')) {
    duel.arenaEffects = asArenaEffects(
      removePendingEffect(
        duel.arenaEffects,
        BLOOD_CONDITION_EXILE,
        turnId,
      ),
    );
    return;
  }

  const pc = await deps.repo.findCharacterById(turnId);
  const member = members.find((m) => m.characterId === turnId);
  const next = mergeConditions({
    current: conditions,
    action: 'remove',
    condition: 'incapacitated',
  });
  if (member != null && member.hitPointsCurrent != null) {
    member.conditions = next;
    await deps.repo.saveMember(member);
  } else if (pc) {
    await deps.state.patch(pc, { conditions: next });
  }
  duel.arenaEffects = asArenaEffects(
    removePendingEffect(duel.arenaEffects, BLOOD_CONDITION_EXILE, turnId),
  );
  duel.combatLog = appendCombatLog(
    duel.combatLog,
    `${pc?.name ?? 'Alvo'} perde o turno (Exílio) e deixa de estar incapacitado.`,
  );
  await advanceTurnFully(deps, duel, members, turnId);
}
