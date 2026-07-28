import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../entities/phb-weapon-mastery.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { VPhbHpBonusSource } from '../../entities/views/v-phb-hp-bonus-source.entity';
import { VPhbUnarmoredDefense } from '../../entities/views/v-phb-unarmored-defense.entity';
import { PlayerCharacterItem } from '../inventory/infrastructure/player-character-item.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { CombatCatalogService } from './infrastructure/combat-catalog.service';
import { EquippedArmorClassService } from './infrastructure/equipped-armor-class.service';
import { EquippedEquipmentComplianceService } from './infrastructure/equipped-equipment-compliance.service';
import { EquippedWeaponAttacksService } from './infrastructure/equipped-weapon-attacks.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacterItem,
      VPhbArmor,
      PhbWeapon,
      PhbWeaponMastery,
      VPhbHpBonusSource,
      VPhbUnarmoredDefense,
    ]),
    GameSharedModule,
  ],
  providers: [
    CombatCatalogService,
    EquippedArmorClassService,
    EquippedWeaponAttacksService,
    EquippedEquipmentComplianceService,
  ],
  exports: [
    CombatCatalogService,
    EquippedArmorClassService,
    EquippedWeaponAttacksService,
    EquippedEquipmentComplianceService,
  ],
})
export class CombatModule {}
