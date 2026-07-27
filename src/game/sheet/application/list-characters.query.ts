import { Injectable } from '@nestjs/common';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CampaignService } from '../../campaign/application/campaign.service';

@Injectable()
export class ListCharactersQuery {
  constructor(
    private readonly repository: CharacterRepository,
    private readonly mapper: CharacterMapper,
    private readonly campaigns: CampaignService,
  ) {}

  async execute(userId: string): Promise<CharacterResponseDto[]> {
    const rows = await this.repository.findAllByUser(userId);
    const dtos = await this.mapper.toDtoList(rows);
    const refs = await this.campaigns.listCampaignRefsByCharacterIds(
      dtos.map((d) => d.id),
    );
    for (const dto of dtos) {
      dto.campaigns = refs.get(dto.id) ?? [];
    }
    return dtos;
  }
}
