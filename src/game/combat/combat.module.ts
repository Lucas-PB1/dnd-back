import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbItem } from '../../entities/phb-item.entity';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../entities/phb-weapon-mastery.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { VPhbHpBonusSource } from '../../entities/views/v-phb-hp-bonus-source.entity';
import { VPhbUnarmoredDefense } from '../../entities/views/v-phb-unarmored-defense.entity';
import { ResolveActivePermanentItemEffects } from '../inventory/application/resolve-active-permanent-item-effects';
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
      PhbItem,
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
    ResolveActivePermanentItemEffects,
    ResolveEquippedArmorClass,
    ResolveEquippedWeaponAttacks,
    ResolveEquipmentCompliance,
  ],
  exports: [
    CombatCatalogService,
    ResolveActivePermanentItemEffects,
    ResolveEquippedArmorClass,
    ResolveEquippedWeaponAttacks,
    ResolveEquipmentCompliance,
  ],
})
export class CombatModule {}
