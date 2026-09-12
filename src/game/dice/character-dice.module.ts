import { Module } from '@nestjs/common';
import { GameSharedModule } from '../shared/game-shared.module';
import { CombatModule } from '../combat/combat.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { CharacterSessionModule } from '../session/character-session.module';
import { EffectsModule } from '../effects/effects.module';
import { CharacterDiceController } from './character-dice.controller';
import { CharacterRollsService } from './application/character-rolls.service';

@Module({
  imports: [
    GameSharedModule,
    CombatModule,
    CharacterSheetModule,
    CharacterSessionModule,
    EffectsModule,
  ],
  controllers: [CharacterDiceController],
  providers: [CharacterRollsService],
  exports: [CharacterRollsService],
})
export class CharacterDiceModule {}
