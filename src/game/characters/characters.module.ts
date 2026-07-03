import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';
import { PlayerCharacter } from './infrastructure/player-character.entity';
import { CharactersController } from './characters.controller';
import { CharacterRepository } from './infrastructure/character.repository';
import { CharacterMapper } from './infrastructure/character.mapper';
import { CharacterDomainService } from './domain/character-domain.service';
import { ListCharactersQuery } from './application/list-characters.query';
import { GetCharacterQuery } from './application/get-character.query';
import { CreateCharacterHandler } from './application/create-character.handler';
import { UpdateCharacterHandler } from './application/update-character.handler';
import { DeleteCharacterHandler } from './application/delete-character.handler';

@Module({
  imports: [
    TypeOrmModule.forFeature([PlayerCharacter, PhbCharacterLevel]),
    CatalogModule,
  ],
  controllers: [CharactersController],
  providers: [
    CharacterDomainService,
    CharacterRepository,
    CharacterMapper,
    ListCharactersQuery,
    GetCharacterQuery,
    CreateCharacterHandler,
    UpdateCharacterHandler,
    DeleteCharacterHandler,
  ],
})
export class CharactersModule {}
