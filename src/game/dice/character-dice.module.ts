import { Module } from '@nestjs/common';
import { GameSharedModule } from '../shared/game-shared.module';
import { CombatModule } from '../combat/combat.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { CharacterSessionModule } from '../session/character-session.module';
import { EffectsModule } from '../effects/effects.module';
import { CharacterDiceController } from './character-dice.controller';
import { CharacterRollsService } from './application/character-rolls.service';

/**
 * Combat (ataques equipados) vem de CombatModule.
 * Sheet: CharacterDomainService + CharacterSheetRepository.
 * Session: CharacterStateRepository para gasto unificado de recursos/slots.
 * Ciclo Sheet→Campaign→Dice→Session→Sheet quebrado: Sheet usa Shared para refs.
 */
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
