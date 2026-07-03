import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbClass } from '../entities/views/v-phb-class.entity';
import { PhbSpecies } from '../entities/phb-species.entity';
import { VPhbBackground } from '../entities/views/v-phb-background.entity';
import { VPhbSubclass } from '../entities/views/v-phb-subclass.entity';
import { PhbAlignment } from '../entities/phb-alignment.entity';
import { CatalogLookupService } from './catalog-lookup.service';
import { ClassesModule } from './classes/classes.module';
import { SpeciesModule } from './species/species.module';
import { BackgroundsModule } from './backgrounds/backgrounds.module';
import { SpellsModule } from './spells/spells.module';
import { FeatsModule } from './feats/feats.module';
import { SkillsModule } from './skills/skills.module';
import { AbilitiesModule } from './abilities/abilities.module';
import { EquipmentModule } from './equipment/equipment.module';
import { ReferenceModule } from './reference/reference.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbClass,
      PhbSpecies,
      VPhbBackground,
      VPhbSubclass,
      PhbAlignment,
    ]),
    ClassesModule,
    SpeciesModule,
    BackgroundsModule,
    SpellsModule,
    FeatsModule,
    SkillsModule,
    AbilitiesModule,
    EquipmentModule,
    ReferenceModule,
  ],
  providers: [CatalogLookupService],
  exports: [CatalogLookupService],
})
export class CatalogModule {}
