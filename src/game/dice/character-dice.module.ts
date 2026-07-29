import { Module, forwardRef } from '@nestjs/common';
import { GameSharedModule } from '../shared/game-shared.module';
import { CombatModule } from '../combat/combat.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { CharacterSessionModule } from '../session/character-session.module';
import { CharacterDiceController } from './character-dice.controller';
import { CharacterRollsService } from './application/character-rolls.service';

/**
 * Combat (ataques equipados) vem de CombatModule.
 * Sheet permanece para CharacterDomainService + CharacterSheetRepository (perícias/ST/etc.).
 * Session exporta CharacterStateRepository para gasto unificado de recursos/slots nas rolls.
 */
@Module({
  imports: [
    GameSharedModule,
    CombatModule,
    forwardRef(() => CharacterSheetModule),
    CharacterSessionModule,
  ],
  controllers: [CharacterDiceController],
  providers: [CharacterRollsService],
  exports: [CharacterRollsService],
})
export class CharacterDiceModule {}
