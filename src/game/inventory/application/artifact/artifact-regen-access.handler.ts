import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  ApplyArtifactRegenHandler,
  type ArtifactRegenResult,
} from './apply-artifact-regen.handler';

@Injectable()
export class ArtifactRegenAccessHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly regen: ApplyArtifactRegenHandler,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    itemSlug: string,
  ): Promise<ArtifactRegenResult> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    return this.regen.execute(characterId, itemSlug);
  }
}
