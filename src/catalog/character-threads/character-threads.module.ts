import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbCharacterThread } from '@entities/phb-character-thread.entity';
import { VPhbCharacterThreadBundle } from '@entities/views/v-phb-character-thread-bundle.entity';
import { CharacterThreadsController } from './character-threads.controller';
import { CharacterThreadMapper } from './character-thread.mapper';
import {
  FindCharacterThreadBySlugQuery,
  FindCharacterThreadsQuery,
} from './queries/find-character-threads.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([PhbCharacterThread, VPhbCharacterThreadBundle]),
  ],
  controllers: [CharacterThreadsController],
  providers: [
    CharacterThreadMapper,
    FindCharacterThreadsQuery,
    FindCharacterThreadBySlugQuery,
  ],
  exports: [TypeOrmModule, CharacterThreadMapper, FindCharacterThreadBySlugQuery],
})
export class CharacterThreadsModule {}
