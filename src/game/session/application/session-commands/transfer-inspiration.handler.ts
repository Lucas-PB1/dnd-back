import {
  BadRequestException,
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { CampaignCharacter } from '@game/campaign/infrastructure/campaign-character.entity';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import { TransferInspirationDto } from '@game/session/dto/core/session-commands.dto/transfer-inspiration.dto';

@Injectable()
export class TransferInspirationHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    @InjectRepository(CampaignCharacter)
    private readonly campaignLinks: Repository<CampaignCharacter>,
  ) {}

  async execute(
    userId: string,
    sourceCharacterId: string,
    dto: TransferInspirationDto,
  ): Promise<{
    sourceState: CharacterStateResponseDto;
    targetState: CharacterStateResponseDto;
    note: string;
  }> {
    if (dto.targetCharacterId === sourceCharacterId) {
      throw new BadRequestException(
        'Não é possível transferir inspiração para o mesmo personagem',
      );
    }

    const source = await this.access.findAccessibleOrFail(
      userId,
      sourceCharacterId,
      'write',
    );
    const target = await this.access.findAccessibleOrFail(
      userId,
      dto.targetCharacterId,
      'write',
    );

    const allowed =
      source.userId === target.userId ||
      (await this.shareCampaign(source.id, target.id));
    if (!allowed) {
      throw new ForbiddenException(
        'Personagens precisam compartilhar dono ou campanha para transferir inspiração',
      );
    }

    const sourceState = await this.state.buildResponse(source);
    if (!sourceState.inspiration) {
      throw new BadRequestException(
        'Personagem de origem não tem Inspiração Heroica',
      );
    }

    const nextSource = await this.state.patch(source, { inspiration: false });
    const nextTarget = await this.state.patch(target, { inspiration: true });
    return {
      sourceState: nextSource,
      targetState: nextTarget,
      note: `Inspiração transferida para ${target.name}.`,
    };
  }

  private async shareCampaign(
    characterA: string,
    characterB: string,
  ): Promise<boolean> {
    const linksA = await this.campaignLinks.find({
      where: { characterId: characterA },
    });
    if (linksA.length === 0) return false;
    const campaignIds = linksA.map((l) => l.campaignId);
    const overlap = await this.campaignLinks.count({
      where: { characterId: characterB, campaignId: In(campaignIds) },
    });
    return overlap > 0;
  }
}
