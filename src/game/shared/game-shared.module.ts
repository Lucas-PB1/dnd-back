import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PlayerCharacter } from './infrastructure/player-character.entity';
import { CharacterRepository } from './infrastructure/character.repository';
import { PlayerCharacterAccessService } from './player-character-access.service';
import { Campaign } from '../campaign/infrastructure/campaign.entity';
import { CampaignMember } from '../campaign/infrastructure/campaign-member.entity';
import { CampaignCharacter } from '../campaign/infrastructure/campaign-character.entity';
import { CampaignCharacterAccessService } from '../campaign/infrastructure/campaign-character-access.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacter,
      Campaign,
      CampaignMember,
      CampaignCharacter,
    ]),
  ],
  providers: [
    CharacterRepository,
    PlayerCharacterAccessService,
    CampaignCharacterAccessService,
  ],
  exports: [
    CharacterRepository,
    PlayerCharacterAccessService,
    CampaignCharacterAccessService,
    TypeOrmModule,
  ],
})
export class GameSharedModule {}
