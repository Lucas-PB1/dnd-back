import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GameSharedModule } from '../shared/game-shared.module';
import { Campaign } from './infrastructure/campaign.entity';
import { CampaignMember } from './infrastructure/campaign-member.entity';
import { CampaignCharacter } from './infrastructure/campaign-character.entity';
import { CampaignRepository } from './infrastructure/campaign.repository';
import { CampaignService } from './application/campaign.service';
import { CampaignsController } from './campaigns.controller';

@Module({
  imports: [
    GameSharedModule,
    TypeOrmModule.forFeature([Campaign, CampaignMember, CampaignCharacter]),
  ],
  controllers: [CampaignsController],
  providers: [CampaignRepository, CampaignService],
  exports: [CampaignRepository, CampaignService],
})
export class CampaignModule {}
