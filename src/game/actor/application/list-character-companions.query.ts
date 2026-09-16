import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { loadCompanionTrackers } from '@game/companion/infrastructure/companion-tracker.queries';
import { CompanionTrackerDto } from '../dto/character-companion.dto';

@Injectable()
export class ListCharacterCompanionsQuery {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly dataSource: DataSource,
  ) {}

  async execute(
    userId: string,
    characterId: string,
  ): Promise<CompanionTrackerDto[]> {
    await this.access.findAccessibleOrFail(userId, characterId, 'read');
    return loadCompanionTrackers(this.dataSource, characterId);
  }
}
