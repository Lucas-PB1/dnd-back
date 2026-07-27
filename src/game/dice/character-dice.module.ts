import { Module } from '@nestjs/common';
import { GameSharedModule } from '../shared/game-shared.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { CharacterDiceController } from './character-dice.controller';
import { CharacterRollsService } from './application/character-rolls.service';

@Module({
  imports: [GameSharedModule, CharacterSheetModule],
  controllers: [CharacterDiceController],
  providers: [CharacterRollsService],
})
export class CharacterDiceModule {}
