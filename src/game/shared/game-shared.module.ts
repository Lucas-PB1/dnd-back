import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PlayerCharacter } from './infrastructure/player-character.entity';
import { CharacterRepository } from './infrastructure/character.repository';
import { PlayerCharacterAccessService } from './player-character-access.service';

@Module({
  imports: [TypeOrmModule.forFeature([PlayerCharacter])],
  providers: [CharacterRepository, PlayerCharacterAccessService],
  exports: [CharacterRepository, PlayerCharacterAccessService],
})
export class GameSharedModule {}
