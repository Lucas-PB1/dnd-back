import { Injectable } from '@nestjs/common';
import { CharacterRepository } from '../infrastructure/character.repository';
import { LevelUpService } from '../domain/level-up.service';
import { LevelUpPreviewDto } from '../dto/level-up.dto';

@Injectable()
export class LevelUpPreviewQuery {
  constructor(
    private readonly repository: CharacterRepository,
    private readonly levelUp: LevelUpService,
  ) {}

  async execute(userId: string, characterId: string): Promise<LevelUpPreviewDto> {
    const character = await this.repository.findOwnedOrFail(userId, characterId);
    return this.levelUp.buildPreview(character);
  }
}
