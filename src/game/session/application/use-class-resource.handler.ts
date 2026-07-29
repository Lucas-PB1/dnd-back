import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import {
  UseClassResourceDto,
  UseClassResourceResponseDto,
} from '../dto/character-state.dto';

@Injectable()
export class UseClassResourceHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: UseClassResourceDto,
  ): Promise<UseClassResourceResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.useClassResource(
      character,
      dto.resourceSlug,
      dto.amount ?? 1,
    );
  }
}
