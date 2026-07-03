import { Module } from '@nestjs/common';
import { CharacterSheetModule } from './characters/character-sheet.module';
import { CharacterBuildModule } from './build/character-build.module';
import { CharacterProgressionModule } from './progression/character-progression.module';
import { CharacterInventoryModule } from './inventory/character-inventory.module';
import { GameSharedModule } from './shared/game-shared.module';

@Module({
  imports: [
    GameSharedModule,
    CharacterSheetModule,
    CharacterBuildModule,
    CharacterProgressionModule,
    CharacterInventoryModule,
  ],
})
export class GameModule {}
