import { Injectable } from '@nestjs/common';
import { CharacterRepository } from '../../shared/infrastructure/character.repository';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { CharacterResponseDto } from '../dto/character-response.dto';
import { CampaignService } from '../../campaign/application/campaign.service';

@Injectable()
export class GetCharacterQuery {
  constructor(
    private readonly repository: CharacterRepository,
    private readonly mapper: CharacterMapper,
    private readonly campaigns: CampaignService,
  ) {}

  async execute(userId: string, id: string): Promise<CharacterResponseDto> {
    const row = await this.repository.findAccessibleOrFail(userId, id, 'read');
    const dto = await this.mapper.toDto(row);
    const refs = await this.campaigns.listCampaignRefsByCharacterIds([dto.id]);
    dto.campaigns = refs.get(dto.id) ?? [];
    return dto;
  }
}
