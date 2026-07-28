import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../entities/phb-weapon-mastery.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { VPhbHpBonusSource } from '../../entities/views/v-phb-hp-bonus-source.entity';
import { VPhbUnarmoredDefense } from '../../entities/views/v-phb-unarmored-defense.entity';
import { PlayerCharacterItem } from '../inventory/infrastructure/player-character-item.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { ResolveEquippedArmorClass } from './application/resolve-equipped-armor-class';
import { ResolveEquippedWeaponAttacks } from './application/resolve-equipped-weapon-attacks';
import { ResolveEquipmentCompliance } from './application/resolve-equipment-compliance';
import { CombatCatalogService } from './infrastructure/combat-catalog.service';

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
    ResolveEquippedArmorClass,
    ResolveEquippedWeaponAttacks,
    ResolveEquipmentCompliance,
  ],
  exports: [
    CombatCatalogService,
    ResolveEquippedArmorClass,
    ResolveEquippedWeaponAttacks,
    ResolveEquipmentCompliance,
  ],
})
export class CombatModule {}
