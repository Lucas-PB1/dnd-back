import { Injectable } from '@nestjs/common';
import { DuelRepository } from '../infrastructure/duel.repository';
import {
  CreateDuelDto,
  DuelAttackDto,
  DuelCastSpellDto,
  DuelConditionDto,
  DuelDetailDto,
  DuelSummaryDto,
  JoinDuelDto,
  SetDuelReadyDto,
} from '../dto/duel.dto';
import { toDetailDto, toSummaryDto } from './to-dto';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { Duel } from '../infrastructure/duel.entity';
import type { DuelMember } from '../infrastructure/duel-member.entity';
import { DuelCombatService } from './duel-combat.service';
import { DuelCombatSnapshot } from './duel-combat-snapshot';

@Injectable()
export class DuelService {
  constructor(
    private readonly repo: DuelRepository,
    private readonly combat: DuelCombatService,
    private readonly snapshot: DuelCombatSnapshot,
  ) {}

  private async charactersMap(
    members: DuelMember[],
  ): Promise<Map<string, PlayerCharacter>> {
    const characters = await this.repo.findCharactersByIds(
      members.map((m) => m.characterId),
    );
    return new Map(characters.map((c) => [c.id, c]));
  }

  private async toSummary(
    duel: Duel,
    members: DuelMember[],
    userId: string,
  ): Promise<DuelSummaryDto> {
    const map = await this.charactersMap(members);
    return toSummaryDto(duel, members, map, userId);
  }

  private async toDetail(
    duel: Duel,
    members: DuelMember[],
    userId: string,
  ): Promise<DuelDetailDto> {
    const map = await this.charactersMap(members);
    const {
      armorByCharacterId,
      vitalsByCharacterId,
      myWeapons,
      mySpells,
      seesInMagicalDarkness,
    } = await this.snapshot.buildMaps({
      members,
      charactersById: map,
      viewerUserId: userId,
    });
    return toDetailDto({
      duel,
      members,
      charactersById: map,
      viewerUserId: userId,
      armorByCharacterId,
      vitalsByCharacterId,
      myWeapons,
      mySpells,
      seesInMagicalDarkness,
    });
  }

  async create(userId: string, dto: CreateDuelDto): Promise<DuelDetailDto> {
    const { duel, members } = await this.repo.createDuel({
      userId,
      characterId: dto.characterId,
    });
    return this.toDetail(duel, members, userId);
  }

  async join(userId: string, dto: JoinDuelDto): Promise<DuelDetailDto> {
    const { duel, members } = await this.repo.joinByInviteCode({
      userId,
      inviteCode: dto.inviteCode,
      characterId: dto.characterId,
    });
    return this.toDetail(duel, members, userId);
  }

  async list(userId: string): Promise<DuelSummaryDto[]> {
    const rows = await this.repo.listForUser(userId);
    return Promise.all(
      rows.map(({ duel, members }) => this.toSummary(duel, members, userId)),
    );
  }

  async getDetail(userId: string, duelId: string): Promise<DuelDetailDto> {
    const { duel, members } = await this.repo.getForMember(userId, duelId);
    return this.toDetail(duel, members, userId);
  }

  async setReady(
    userId: string,
    duelId: string,
    dto: SetDuelReadyDto,
  ): Promise<DuelDetailDto> {
    const { duel, members } = await this.combat.setReady(
      userId,
      duelId,
      dto.ready,
    );
    return this.toDetail(duel, members, userId);
  }

  async attack(
    userId: string,
    duelId: string,
    dto: DuelAttackDto,
  ): Promise<DuelDetailDto> {
    const { duel, members } = await this.combat.attack(userId, duelId, dto);
    return this.toDetail(duel, members, userId);
  }

  async castSpell(
    userId: string,
    duelId: string,
    dto: DuelCastSpellDto,
  ): Promise<DuelDetailDto> {
    const { duel, members } = await this.combat.castSpell(userId, duelId, dto);
    return this.toDetail(duel, members, userId);
  }

  async changeCondition(
    userId: string,
    duelId: string,
    dto: DuelConditionDto,
  ): Promise<DuelDetailDto> {
    const { duel, members } = await this.combat.changeCondition(
      userId,
      duelId,
      dto,
    );
    return this.toDetail(duel, members, userId);
  }

  async forfeit(userId: string, duelId: string): Promise<DuelDetailDto> {
    const { duel, members } = await this.combat.forfeit(userId, duelId);
    return this.toDetail(duel, members, userId);
  }
}
