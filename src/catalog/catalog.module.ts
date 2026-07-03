import { Module } from '@nestjs/common';
import { ClassesModule } from './classes/classes.module';
import { SpeciesModule } from './species/species.module';
import { BackgroundsModule } from './backgrounds/backgrounds.module';
import { SpellsModule } from './spells/spells.module';
import { FeatsModule } from './feats/feats.module';
import { SkillsModule } from './skills/skills.module';
import { AbilitiesModule } from './abilities/abilities.module';
import { EquipmentModule } from './equipment/equipment.module';

@Module({
  imports: [
    ClassesModule,
    SpeciesModule,
    BackgroundsModule,
    SpellsModule,
    FeatsModule,
    SkillsModule,
    AbilitiesModule,
    EquipmentModule,
  ],
})
export class CatalogModule {}
