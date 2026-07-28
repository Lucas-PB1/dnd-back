import { Module } from '@nestjs/common';
import { GameSharedModule } from '../shared/game-shared.module';
import { CombatModule } from '../combat/combat.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { CharacterDiceController } from './character-dice.controller';
import { CharacterRollsService } from './application/character-rolls.service';

/**
 * Combat (ataques equipados) vem de CombatModule.
 * Sheet permanece para CharacterDomainService + CharacterSheetRepository (perícias/ST/etc.).
 */
@Module({
  imports: [GameSharedModule, CombatModule, CharacterSheetModule],
  controllers: [CharacterDiceController],
  providers: [CharacterRollsService],
})
export class CharacterDiceModule {}
