import { Module } from '@nestjs/common';
import { CharacterSheetModule } from './sheet/character-sheet.module';
import { CharacterBuildModule } from './build/character-build.module';
import { CharacterProgressionModule } from './progression/character-progression.module';
import { CharacterInventoryModule } from './inventory/character-inventory.module';
import { CharacterSessionModule } from './session/character-session.module';
import { CharacterDiceModule } from './dice/character-dice.module';
import { GameSharedModule } from './shared/game-shared.module';
import { CampaignModule } from './campaign/campaign.module';
import { ActorModule } from './actor/actor.module';

@Module({
  imports: [
    GameSharedModule,
    CharacterSheetModule,
    CharacterBuildModule,
    CharacterProgressionModule,
    CharacterInventoryModule,
    CharacterSessionModule,
    CharacterDiceModule,
    CampaignModule,
    ActorModule,
  ],
})
export class GameModule {}
