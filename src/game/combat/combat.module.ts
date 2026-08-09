import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbItem } from '@entities/phb-item.entity';
import { PhbWeapon } from '@entities/phb-weapon.entity';
import { PhbWeaponMastery } from '@entities/phb-weapon-mastery.entity';
import { VPhbArmor } from '@entities/views/v-phb-armor.entity';
import { VPhbBattleMasterManeuver } from '@entities/views/v-phb-battle-master-maneuver.entity';
import { VPhbBeastborneAspectBenefit } from '@entities/views/v-phb-beastborne-aspect-benefit.entity';
import { VPhbCunningStrikeEffect } from '@entities/views/v-phb-cunning-strike-effect.entity';
import { VPhbDungeoneerSlayerType } from '@entities/views/v-phb-dungeoneer-slayer-type.entity';
import { VPhbGunslingerManeuver } from '@entities/views/v-phb-gunslinger-maneuver.entity';
import { VPhbHpBonusSource } from '@entities/views/v-phb-hp-bonus-source.entity';
import { VPhbPersonaMask } from '@entities/views/v-phb-persona-mask.entity';
import { VPhbSubclassPrecautionSpell } from '@entities/views/v-phb-subclass-precaution-spell.entity';
import { VPhbSubclassTableAction } from '@entities/views/v-phb-subclass-table-action.entity';
import { VPhbClassEconomyAction } from '@entities/views/v-phb-class-economy-action.entity';
import { VPhbClassPanelAction } from '@entities/views/v-phb-class-panel-action.entity';
import { VPhbUnarmoredDefense } from '@entities/views/v-phb-unarmored-defense.entity';
import { ResolveActivePermanentItemEffects } from '../inventory/application/resolve-active-permanent-item-effects';
import { PlayerCharacterItem } from '../inventory/infrastructure/player-character-item.entity';
import { GameSharedModule } from '../shared/game-shared.module';
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
      VPhbGunslingerManeuver,
      VPhbBattleMasterManeuver,
      VPhbCunningStrikeEffect,
      VPhbSubclassTableAction,
      VPhbPersonaMask,
      VPhbBeastborneAspectBenefit,
      VPhbDungeoneerSlayerType,
      VPhbSubclassPrecautionSpell,
      VPhbClassEconomyAction,
      VPhbClassPanelAction,
    ]),
    GameSharedModule,
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
