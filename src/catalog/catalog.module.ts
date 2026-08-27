import { Module } from '@nestjs/common';
import { CatalogLookupModule } from './catalog-lookup.module';
import { ClassesModule } from './classes/classes.module';
import { SubclassesModule } from './subclasses/subclasses.module';
import { SpeciesModule } from './species/species.module';
import { BackgroundsModule } from './backgrounds/backgrounds.module';
import { SpellsModule } from './spells/spells.module';
import { FeatsModule } from './feats/feats.module';
import { SkillsModule } from './skills/skills.module';
import { FightingStylesModule } from './fighting-styles/fighting-styles.module';
import { AbilitiesModule } from './abilities/abilities.module';
import { EquipmentModule } from './equipment/equipment.module';
import { ItemsModule } from './items/items.module';
import { ReferenceModule } from './reference/reference.module';
import { CombatMechanicalModule } from './combat-mechanical/combat-mechanical.module';
import { EldritchInvocationsModule } from './eldritch-invocations/eldritch-invocations.module';
import { MetamagicsModule } from './metamagics/metamagics.module';
import { CreatureTemplatesModule } from './creature-templates/creature-templates.module';
import { VehicleTemplatesModule } from './vehicle-templates/vehicle-templates.module';
import { CharacterThreadsModule } from './character-threads/character-threads.module';

@Module({
  imports: [
    CatalogLookupModule,
    ClassesModule,
    SubclassesModule,
    SpeciesModule,
    BackgroundsModule,
    SpellsModule,
    FeatsModule,
    SkillsModule,
    FightingStylesModule,
    AbilitiesModule,
    EquipmentModule,
    ItemsModule,
    ReferenceModule,
    CombatMechanicalModule,
    EldritchInvocationsModule,
    MetamagicsModule,
    CreatureTemplatesModule,
    VehicleTemplatesModule,
    CharacterThreadsModule,
  ],
  exports: [CatalogLookupModule, ItemsModule, CharacterThreadsModule],
})
export class CatalogModule {}
