import { Injectable } from '@nestjs/common';
import { sheetProfile } from '@common/perf/sheet-profile';
import { CharacterRepository } from '@game/shared/infrastructure/character.repository';
import { CampaignCharacterAccessService } from '@game/campaign/infrastructure/campaign-character-access.service';
import { CharacterMapper } from '../infrastructure/character.mapper';
import { CharacterResponseDto } from '../dto/character-response.dto';

@Injectable()
export class GetCharacterQuery {
  constructor(
    private readonly repository: CharacterRepository,
    private readonly mapper: CharacterMapper,
    private readonly campaignAccess: CampaignCharacterAccessService,
  ) {}

  async execute(userId: string, id: string): Promise<CharacterResponseDto> {
    const row = await sheetProfile('access', () =>
      this.repository.findAccessibleOrFail(userId, id, 'read'),
    );
    const [dto, refs] = await Promise.all([
      sheetProfile('mapper', () => this.mapper.toDto(row)),
      sheetProfile('campaigns', () =>
        this.campaignAccess.listCampaignRefsByCharacterIds([row.id], userId),
      ),
    ]);
    dto.campaigns = refs.get(dto.id) ?? [];
    return dto;
  }
}
