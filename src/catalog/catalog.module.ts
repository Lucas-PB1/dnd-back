import { Module } from '@nestjs/common';
import { CatalogLookupModule } from './catalog-lookup.module';
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
    CatalogLookupModule,
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
  exports: [CatalogLookupModule],
})
export class CatalogModule {}
