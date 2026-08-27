import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { GameActor } from './game-actor.entity';
import {
  CampaignCharacterAccessService,
  CharacterAccessMode,
} from '@game/campaign/infrastructure/campaign-character-access.service';
import {
  CampaignMember,
  CampaignRole,
} from '@game/campaign/infrastructure/campaign-member.entity';
import { CampaignRepository } from '@game/campaign/infrastructure/campaign.repository';

export type ActorAccessMode = 'read' | 'write' | 'own';

const WRITE_ROLES: readonly CampaignRole[] = ['dm', 'assistant'];

@Injectable()
export class ActorRepository {
  constructor(
    @InjectRepository(GameActor)
    private readonly repo: Repository<GameActor>,
    private readonly campaigns: CampaignRepository,
    private readonly characterAccess: CampaignCharacterAccessService,
  ) {}

  findAllByOwner(userId: string): Promise<GameActor[]> {
    return this.repo.find({
      where: { ownerUserId: userId },
      order: { updatedAt: 'DESC' },
    });
  }

  async findOwnedOrFail(userId: string, id: string): Promise<GameActor> {
    return this.findAccessibleOrFail(userId, id, 'own');
  }

  async findAccessibleOrFail(
    userId: string,
    id: string,
    mode: ActorAccessMode,
  ): Promise<GameActor> {
    const row = await this.repo.findOne({ where: { id } });
    if (!row) {
      throw new NotFoundException(`Actor '${id}' not found`);
    }

    if (row.ownerUserId === userId) {
      return row;
    }

    if (mode === 'own') {
      throw new ForbiddenException('You do not have access to this actor');
    }

    if (row.campaignId) {
      const access = await this.hasCampaignAccess(
        userId,
        row.campaignId,
        mode,
      );
      if (access) return row;
    }

    if (row.parentCharacterId) {
      const pcMode: CharacterAccessMode = mode === 'read' ? 'read' : 'write';
      const viaPc = await this.characterAccess.hasAccess(
        userId,
        row.parentCharacterId,
        pcMode,
      );
      if (viaPc) return row;
    }

    throw new ForbiddenException('You do not have access to this actor');
  }

  private async hasCampaignAccess(
    userId: string,
    campaignId: string,
    mode: ActorAccessMode,
  ): Promise<boolean> {
    let member: CampaignMember;
    try {
      member = await this.campaigns.requireMember(campaignId, userId);
    } catch {
      return false;
    }
    if (mode === 'read') return true;
    return WRITE_ROLES.includes(member.role);
  }

  create(data: Partial<GameActor>): GameActor {
    return this.repo.create(data);
  }

  save(entity: GameActor): Promise<GameActor> {
    return this.repo.save(entity);
  }

  async remove(entity: GameActor): Promise<void> {
    await this.repo.remove(entity);
  }

  findByIds(ids: string[]): Promise<GameActor[]> {
    if (ids.length === 0) return Promise.resolve([]);
    return this.repo.find({ where: { id: In(ids) } });
  }
}
