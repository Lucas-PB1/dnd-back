import { Module } from '@nestjs/common';
import { SpellcastingModule } from '../spellcasting/spellcasting.module';
import { CharacterBuildController } from './character-build.controller';
import { RollAbilitiesHandler } from './application/roll-abilities.handler';
import { PreviewGrantedSpellsHandler } from './application/preview-granted-spells.handler';

@Module({
  imports: [SpellcastingModule],
  controllers: [CharacterBuildController],
  providers: [RollAbilitiesHandler, PreviewGrantedSpellsHandler],
})
export class CharacterBuildModule {}
