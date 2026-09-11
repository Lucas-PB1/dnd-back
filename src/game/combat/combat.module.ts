import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbBattleMasterManeuver } from '@entities/subclass-feature/phb-battle-master-maneuver.entity';
import { PhbBeastborneAspectBenefit } from '@entities/subclass-feature/phb-beastborne-aspect-benefit.entity';
import { PhbClassPanelAction } from '@entities/class/phb-class-panel-action.entity';
import { PhbCunningStrikeEffect } from '@entities/subclass-feature/phb-cunning-strike-effect.entity';
import { PhbDungeoneerSlayerType } from '@entities/subclass-feature/phb-dungeoneer-slayer-type.entity';
import { PhbGunslingerManeuver } from '@entities/subclass-feature/phb-gunslinger-maneuver.entity';
import { PhbItem } from '@entities/equipment/phb-item.entity';
import { PhbPersonaMask } from '@entities/subclass-feature/phb-persona-mask.entity';
import { PhbSpellRef } from '@entities/spell/phb-spell-ref.entity';
import { PhbOptionValue } from '@entities/reference/phb-option.entity';
import { PhbSpecies } from '@entities/species/phb-species.entity';
import { PhbSpeciesArmorPreset } from '@entities/species/phb-species-armor-preset.entity';
import { PhbSubclassFeatureGate } from '@entities/subclass-feature/phb-subclass-feature-gate.entity';
import { PhbLevelCombatNote } from '@entities/reference/phb-level-combat-note.entity';
import { PhbDamageType } from '@entities/reference/phb-damage-type.entity';
import { PhbClassFeatureSchedule } from '@entities/class/phb-class-feature-schedule.entity';
import { PhbSubclassPrecautionSpell } from '@entities/subclass-feature/phb-subclass-precaution-spell.entity';
import { PhbSubclassRef } from '@entities/subclass-feature/phb-subclass-ref.entity';
import { PhbClassRef } from '@entities/class/phb-class-ref.entity';
import { PhbSubclassTableAction } from '@entities/subclass-feature/phb-subclass-table-action.entity';
import { PhbWeapon } from '@entities/equipment/phb-weapon.entity';
import { PhbWeaponMastery } from '@entities/equipment/phb-weapon-mastery.entity';
import { VPhbArmor } from '@entities/views/v-phb-armor.entity';
import { VPhbClassEconomyAction } from '@entities/views/v-phb-class-economy-action.entity';
import { VPhbHpBonusSource } from '@entities/views/v-phb-hp-bonus-source.entity';
import { VPhbUnarmoredDefense } from '@entities/views/v-phb-unarmored-defense.entity';
import { ResolveActivePermanentItemEffects } from '../inventory/application/effects/resolve-active-permanent-item-effects';
import { PlayerCharacterItem } from '../inventory/infrastructure/player-character-item.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { EffectsModule } from '../effects/effects.module';
import { LoadCombatMechanicalCatalog } from './application/load-combat-mechanical-catalog';
import { ResolveEquippedArmorClass } from './application/resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from './application/resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from './application/resolve-equipment-compliance';
import { CombatCatalogService } from './infrastructure/combat-catalog.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacterItem,
      PhbItem,
      VPhbArmor,
      PhbWeapon,
      PhbWeaponMastery,
      VPhbHpBonusSource,
      VPhbUnarmoredDefense,
      PhbClassRef,
      PhbSubclassRef,
      PhbSpellRef,
      PhbGunslingerManeuver,
      PhbBattleMasterManeuver,
      PhbCunningStrikeEffect,
      PhbSubclassTableAction,
      PhbPersonaMask,
      PhbBeastborneAspectBenefit,
      PhbDungeoneerSlayerType,
      PhbSubclassPrecautionSpell,
      VPhbClassEconomyAction,
      PhbClassPanelAction,
      PhbOptionValue,
      PhbSpecies,
      PhbSpeciesArmorPreset,
      PhbSubclassFeatureGate,
      PhbLevelCombatNote,
      PhbDamageType,
      PhbClassFeatureSchedule,
    ]),
    GameSharedModule,
    EffectsModule,
  ],
  providers: [
    CombatCatalogService,
    LoadCombatMechanicalCatalog,
    ResolveActivePermanentItemEffects,
    ResolveEquippedArmorClass,
    ResolveEquippedWeaponAttacks,
    ResolveEquipmentCompliance,
  ],
  exports: [
    CombatCatalogService,
    LoadCombatMechanicalCatalog,
    ResolveActivePermanentItemEffects,
    ResolveEquippedArmorClass,
    ResolveEquippedWeaponAttacks,
    ResolveEquipmentCompliance,
  ],
})
export class CombatModule {}
