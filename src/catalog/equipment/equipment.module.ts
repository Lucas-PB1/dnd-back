import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { PhbItem } from '../../entities/phb-item.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { EquipmentService } from './equipment.service';
import { WeaponsController } from './weapons.controller';
import { ArmorController } from './armor.controller';

@Module({
  imports: [TypeOrmModule.forFeature([PhbWeapon, PhbItem, VPhbArmor])],
  controllers: [WeaponsController, ArmorController],
  providers: [EquipmentService],
})
export class EquipmentModule {}
