import { BadRequestException } from '@nestjs/common';
import type { CharacterRollsService } from '@game/dice/application/character-rolls.service';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { DUEL_MAX_MEMBERS } from '../../domain/duel-status';
import { appendCombatLog } from '../../domain/combat-log';
import { snapshotMemberVitalsFromCharacter } from '../../domain/duel-member-vitals';
import type { DuelRepository } from '../../infrastructure/duel.repository';
import type { Duel } from '../../infrastructure/duel.entity';
import type { DuelMember } from '../../infrastructure/duel-member.entity';
import { hitPointsOf } from '../to-dto';
import type { DuelCombatSnapshot } from '../duel-combat-snapshot';

export type LifecycleDeps = {
  repo: DuelRepository;
  rolls: CharacterRollsService;
  state: CharacterStateRepository;
  snapshot: DuelCombatSnapshot;
};

export async function setReady(
  deps: LifecycleDeps,
  userId: string,
  duelId: string,
  ready: boolean,
): Promise<{ duel: Duel; members: DuelMember[] }> {
  const { duel, members } = await deps.repo.getForMember(userId, duelId);
  deps.repo.assertStatus(duel, ['open', 'ready']);

  const mine = members.find((m) => m.userId === userId);
  if (!mine) {
    throw new BadRequestException('Not a duel member');
  }

  mine.ready = ready;
  await deps.repo.saveMember(mine);

  const refreshed = await deps.repo.getForMember(userId, duelId);
  const bothReady =
    refreshed.members.length === DUEL_MAX_MEMBERS &&
    refreshed.members.every((m) => m.ready);

  if (!bothReady) {
    refreshed.duel.status = 'open';
    await deps.repo.saveDuel(refreshed.duel);
    return refreshed;
  }

  return startCombat(deps, refreshed.duel, refreshed.members);
}

export async function startCombat(
  deps: LifecycleDeps,
  duel: Duel,
  members: DuelMember[],
): Promise<{ duel: Duel; members: DuelMember[] }> {
  const characters = await deps.repo.findCharactersByIds(
    members.map((m) => m.characterId),
  );
  const byId = new Map(characters.map((c) => [c.id, c]));

  for (const member of members) {
    const character = byId.get(member.characterId);
    const hp = hitPointsOf(character);
    if (hp.current <= 0) {
      throw new BadRequestException(
        `${character?.name ?? 'Personagem'} está a 0 PV — cure antes do duelo`,
      );
    }
  }

  const initiativeRows: Array<{ member: DuelMember; total: number }> = [];
  for (const member of members) {
    const character = byId.get(member.characterId)!;
    const state = await deps.state.buildResponse(character);
    snapshotMemberVitalsFromCharacter(
      member,
      character,
      state.tempHp ?? 0,
      state.conditions ?? [],
    );
    const roll = await deps.rolls.rollInitiative(
      member.userId,
      member.characterId,
      {},
    );
    member.initiative = roll.total;
    initiativeRows.push({ member, total: roll.total });
  }
  await deps.repo.saveMembers(members);

  initiativeRows.sort((a, b) => b.total - a.total);
  const first = initiativeRows[0]!;
  const second = initiativeRows[1]!;
  const firstPc = byId.get(first.member.characterId);
  const firstName = firstPc?.name ?? 'A';
  const secondName = byId.get(second.member.characterId)?.name ?? 'B';

  duel.status = 'active';
  duel.round = 1;
  duel.turnCharacterId = first.member.characterId;
  duel.turnAttacksRemaining = await deps.snapshot.resolveTurnAttackBudget(
    firstPc,
  );
  duel.winnerUserId = null;
  duel.winnerCharacterId = null;
  duel.endReason = null;
  duel.arenaEffects = [];
  duel.arenaEffectSourceCharacterId = null;
  duel.combatLog = appendCombatLog(
    [],
    `Combate iniciado. Iniciativa: ${firstName} ${first.total}, ${secondName} ${second.total}. Turno de ${firstName}.`,
  );

  const saved = await deps.repo.saveDuel(duel);
  return { duel: saved, members };
}

export async function forfeit(
  deps: LifecycleDeps,
  userId: string,
  duelId: string,
): Promise<{ duel: Duel; members: DuelMember[] }> {
  const { duel, members } = await deps.repo.getForMember(userId, duelId);
  deps.repo.assertStatus(duel, ['open', 'ready', 'active']);

  const mine = members.find((m) => m.userId === userId);
  const opponent = members.find((m) => m.userId !== userId);
  if (!mine) {
    throw new BadRequestException('Not a duel member');
  }

  if (!opponent) {
    duel.status = 'cancelled';
    duel.endReason = 'cancel';
    duel.turnCharacterId = null;
    duel.arenaEffects = [];
    duel.arenaEffectSourceCharacterId = null;
    duel.combatLog = appendCombatLog(duel.combatLog, 'Duelo cancelado.');
    const saved = await deps.repo.saveDuel(duel);
    return { duel: saved, members };
  }

  const characters = await deps.repo.findCharactersByIds([
    mine.characterId,
    opponent.characterId,
  ]);
  const byId = new Map(characters.map((c) => [c.id, c]));
  const log = appendCombatLog(
    duel.combatLog,
    `${byId.get(mine.characterId)?.name ?? 'Jogador'} desistiu. Vitória de ${byId.get(opponent.characterId)?.name ?? 'oponente'}.`,
  );

  const finished = await deps.repo.finishDuel({
    duel,
    winnerUserId: opponent.userId,
    winnerCharacterId: opponent.characterId,
    endReason: 'forfeit',
    combatLog: log,
  });
  return { duel: finished, members };
}
