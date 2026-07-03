import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { PlayerCharacter } from './player-character.entity';
import { CharactersController } from './characters.controller';
import { CharactersService } from './characters.service';

@Module({
  imports: [TypeOrmModule.forFeature([PlayerCharacter]), CatalogModule],
  controllers: [CharactersController],
  providers: [CharactersService],
})
export class CharactersModule {}
