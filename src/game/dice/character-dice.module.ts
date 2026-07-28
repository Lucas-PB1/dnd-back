import { Module } from '@nestjs/common';
import { GameSharedModule } from '../shared/game-shared.module';
import { CombatModule } from '../combat/combat.module';
import { CharacterDiceController } from './character-dice.controller';
import { CharacterRollsService } from './application/character-rolls.service';

@Module({
  imports: [GameSharedModule, CombatModule],
  controllers: [CharacterDiceController],
  providers: [CharacterRollsService],
})
export class CharacterDiceModule {}
