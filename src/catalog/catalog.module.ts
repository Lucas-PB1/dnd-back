import { Module } from '@nestjs/common';
import { ClassesModule } from './classes/classes.module';
import { SpeciesModule } from './species/species.module';
import { BackgroundsModule } from './backgrounds/backgrounds.module';
import { SpellsModule } from './spells/spells.module';

@Module({
  imports: [ClassesModule, SpeciesModule, BackgroundsModule, SpellsModule],
})
export class CatalogModule {}
