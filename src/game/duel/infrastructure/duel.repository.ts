import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { DUEL_MAX_MEMBERS } from '../domain/duel-status';
import { generateDuelInviteCode } from '../domain/invite-code';
import { Duel, type DuelCombatLogEntry } from './duel.entity';
import { DuelMember } from './duel-member.entity';
import type { DuelEndReason, DuelStatus } from '../domain/duel-status';

@Injectable()
export class DuelRepository {
  constructor(
    @InjectRepository(Duel)
    private readonly duels: Repository<Duel>,
    @InjectRepository(DuelMember)
    private readonly members: Repository<DuelMember>,
    @InjectRepository(PlayerCharacter)
    private readonly characters: Repository<PlayerCharacter>,
    private readonly access: PlayerCharacterAccessService,
  ) {}

  private async allocateUniqueInviteCode(): Promise<string> {
    let inviteCode = generateDuelInviteCode();
    for (let attempt = 0; attempt < 5; attempt += 1) {
      const exists = await this.duels.exist({ where: { inviteCode } });
      if (!exists) break;
      inviteCode = generateDuelInviteCode();
    }
    return inviteCode;
  }

  async createDuel(input: {
    userId: string;
    characterId: string;
  }): Promise<{ duel: Duel; members: DuelMember[] }> {
    await this.access.findOwnedOrFail(input.userId, input.characterId);

    const inviteCode = await this.allocateUniqueInviteCode();
    const duel = await this.duels.save(
      this.duels.create({
        status: 'open',
        inviteCode,
        createdBy: input.userId,
        round: 1,
        combatLog: [],
        arenaEffects: [],
      }),
    );

    const member = await this.members.save(
      this.members.create({
        duelId: duel.id,
        userId: input.userId,
        characterId: input.characterId,
        ready: false,
      }),
    );

    return { duel, members: [member] };
  }

  async joinByInviteCode(input: {
    userId: string;
    inviteCode: string;
    characterId: string;
  }): Promise<{ duel: Duel; members: DuelMember[] }> {
    await this.access.findOwnedOrFail(input.userId, input.characterId);

    const code = input.inviteCode.trim().toUpperCase();
    const duel = await this.duels.findOne({ where: { inviteCode: code } });
    if (!duel) {
      throw new NotFoundException('Invalid invite code');
    }
    if (duel.status !== 'open') {
      throw new BadRequestException('Duel is not open for joining');
    }

    const existingMembers = await this.members.find({
      where: { duelId: duel.id },
    });

    const alreadyIn = existingMembers.find((m) => m.userId === input.userId);
    if (alreadyIn) {
      return { duel, members: existingMembers };
    }

    if (existingMembers.length >= DUEL_MAX_MEMBERS) {
      throw new BadRequestException('Duel already has two participants');
    }

    if (existingMembers.some((m) => m.characterId === input.characterId)) {
      throw new BadRequestException('Character is already in this duel');
    }

    const member = await this.members.save(
      this.members.create({
        duelId: duel.id,
        userId: input.userId,
        characterId: input.characterId,
        ready: false,
      }),
    );

    duel.updatedAt = new Date();
    const refreshed = await this.duels.save(duel);

    return { duel: refreshed, members: [...existingMembers, member] };
  }

  async listForUser(
    userId: string,
  ): Promise<Array<{ duel: Duel; members: DuelMember[] }>> {
    const myMemberships = await this.members.find({ where: { userId } });
    if (myMemberships.length === 0) return [];

    const duelIds = myMemberships.map((m) => m.duelId);
    const duels = await this.duels.find({
      where: { id: In(duelIds) },
      order: { updatedAt: 'DESC' },
    });
    const allMembers = await this.members.find({
      where: { duelId: In(duelIds) },
    });

    const membersByDuel = new Map<string, DuelMember[]>();
    for (const member of allMembers) {
      const list = membersByDuel.get(member.duelId) ?? [];
      list.push(member);
      membersByDuel.set(member.duelId, list);
    }

    return duels.map((duel) => ({
      duel,
      members: membersByDuel.get(duel.id) ?? [],
    }));
  }

  async getForMember(
    userId: string,
    duelId: string,
  ): Promise<{ duel: Duel; members: DuelMember[] }> {
    const membership = await this.members.findOne({
      where: { duelId, userId },
    });
    if (!membership) {
      throw new ForbiddenException('You are not a member of this duel');
    }

    const duel = await this.duels.findOne({ where: { id: duelId } });
    if (!duel) {
      throw new NotFoundException(`Duel '${duelId}' not found`);
    }

    const members = await this.members.find({
      where: { duelId },
      order: { joinedAt: 'ASC' },
    });

    return { duel, members };
  }

  async findCharactersByIds(ids: string[]): Promise<PlayerCharacter[]> {
    if (ids.length === 0) return [];
    return this.characters.find({ where: { id: In([...new Set(ids)]) } });
  }

  async findCharacterById(id: string): Promise<PlayerCharacter | null> {
    return this.characters.findOne({ where: { id } });
  }

  async saveMember(member: DuelMember): Promise<DuelMember> {
    return this.members.save(member);
  }

  async saveMembers(members: DuelMember[]): Promise<DuelMember[]> {
    return this.members.save(members);
  }

  async saveDuel(duel: Duel): Promise<Duel> {
    duel.updatedAt = new Date();
    return this.duels.save(duel);
  }

  async finishDuel(input: {
    duel: Duel;
    winnerUserId: string;
    winnerCharacterId: string;
    endReason: DuelEndReason;
    combatLog: DuelCombatLogEntry[];
  }): Promise<Duel> {
    input.duel.status = 'finished';
    input.duel.winnerUserId = input.winnerUserId;
    input.duel.winnerCharacterId = input.winnerCharacterId;
    input.duel.endReason = input.endReason;
    input.duel.turnCharacterId = null;
    input.duel.arenaEffects = [];
    input.duel.arenaEffectSourceCharacterId = null;
    input.duel.combatLog = input.combatLog;
    return this.saveDuel(input.duel);
  }

  assertStatus(duel: Duel, allowed: readonly DuelStatus[]): void {
    if (!allowed.includes(duel.status)) {
      throw new BadRequestException(
        `Duel status must be ${allowed.join(' or ')} (got ${duel.status})`,
      );
    }
  }
}
