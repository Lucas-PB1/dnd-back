import { Module } from '@nestjs/common';
import { CharacterBuildController } from './character-build.controller';
import { RollAbilitiesHandler } from './application/roll-abilities.handler';

@Module({
  controllers: [CharacterBuildController],
  providers: [RollAbilitiesHandler],
})
export class CharacterBuildModule {}
