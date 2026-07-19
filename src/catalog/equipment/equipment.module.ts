import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../entities/phb-weapon-mastery.entity';
import { PhbWeaponProperty } from '../../entities/phb-weapon-property.entity';
import { PhbItem } from '../../entities/phb-item.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { EquipmentMapper } from './equipment.mapper';
import { FindWeaponsQuery } from './queries/find-weapons.query';
import { FindWeaponBySlugQuery } from './queries/find-weapon-by-slug.query';
import { FindArmorQuery } from './queries/find-armor.query';
import { FindArmorBySlugQuery } from './queries/find-armor-by-slug.query';
import { WeaponsController } from './weapons.controller';
import { ArmorController } from './armor.controller';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PhbWeapon,
      PhbItem,
      VPhbArmor,
      PhbWeaponProperty,
      PhbWeaponMastery,
    ]),
  ],
  controllers: [WeaponsController, ArmorController],
  providers: [
    EquipmentMapper,
    FindWeaponsQuery,
    FindWeaponBySlugQuery,
    FindArmorQuery,
    FindArmorBySlugQuery,
  ],
})
export class EquipmentModule {}
