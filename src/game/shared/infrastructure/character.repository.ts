import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacter } from './player-character.entity';
import {
  CampaignCharacterAccessService,
  CharacterAccessMode,
} from '@game/campaign/infrastructure/campaign-character-access.service';

@Injectable()
export class CharacterRepository {
  constructor(
    @InjectRepository(PlayerCharacter)
    private readonly repo: Repository<PlayerCharacter>,
    private readonly campaignAccess: CampaignCharacterAccessService,
  ) {}

  findAllByUser(userId: string): Promise<PlayerCharacter[]> {
    return this.repo.find({
      where: { userId },
      order: { updatedAt: 'DESC' },
      select: {
        id: true,
        name: true,
        level: true,
        classSlug: true,
        speciesSlug: true,
        backgroundSlug: true,
        subclassSlug: true,
        createdAt: true,
        updatedAt: true,
      },
    });
  }

  async findOwnedOrFail(userId: string, id: string): Promise<PlayerCharacter> {
    return this.findAccessibleOrFail(userId, id, 'own');
  }

  async findAccessibleOrFail(
    userId: string,
    id: string,
    mode: CharacterAccessMode,
  ): Promise<PlayerCharacter> {
    const row = await this.repo.findOne({ where: { id } });
    if (!row) {
      throw new NotFoundException(`Character '${id}' not found`);
    }

    if (row.userId === userId) {
      return row;
    }

    if (mode === 'own') {
      throw new ForbiddenException('You do not have access to this character');
    }

    const viaCampaign = await this.campaignAccess.hasAccess(userId, id, mode);
    if (!viaCampaign) {
      throw new ForbiddenException('You do not have access to this character');
    }

    return row;
  }

  create(data: Partial<PlayerCharacter>): PlayerCharacter {
    return this.repo.create(data);
  }

  save(entity: PlayerCharacter): Promise<PlayerCharacter> {
    return this.repo.save(entity);
  }

  async remove(entity: PlayerCharacter): Promise<void> {
    await this.repo.remove(entity);
  }
}
