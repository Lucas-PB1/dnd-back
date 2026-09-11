import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GameSharedModule } from '../shared/game-shared.module';
import { CombatModule } from '../combat/combat.module';
import { CharacterDiceModule } from '../dice/character-dice.module';
import { CharacterSessionModule } from '../session/character-session.module';
import { CharacterSheetModule } from '../sheet/character-sheet.module';
import { EffectsModule } from '../effects/effects.module';
import { PlayerCharacter } from '../shared/infrastructure/player-character.entity';
import { Duel } from './infrastructure/duel.entity';
import { DuelMember } from './infrastructure/duel-member.entity';
import { DuelRepository } from './infrastructure/duel.repository';
import { DuelService } from './application/duel.service';
import { DuelCombatService } from './application/duel-combat.service';
import { DuelCombatSnapshot } from './application/duel-combat-snapshot';
import { DuelsController } from './duels.controller';

@Module({
  imports: [
    GameSharedModule,
    CombatModule,
    EffectsModule,
    CharacterDiceModule,
    CharacterSessionModule,
    CharacterSheetModule,
    TypeOrmModule.forFeature([Duel, DuelMember, PlayerCharacter]),
  ],
  controllers: [DuelsController],
  providers: [
    DuelRepository,
    DuelService,
    DuelCombatService,
    DuelCombatSnapshot,
  ],
  exports: [DuelRepository, DuelService],
})
export class DuelModule {}
