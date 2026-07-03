import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbClass } from '../../entities/views/v-phb-class.entity';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';
import { VSpellByClass } from '../../entities/views/v-spell-by-class.entity';
import { VClassSpellSlots } from '../../entities/views/v-class-spell-slots.entity';
import { VPhbClassEquipment } from '../../entities/views/v-phb-class-equipment.entity';
import { ClassesController } from './classes.controller';
import { ClassesService } from './classes.service';

@Module({
  imports: [TypeOrmModule.forFeature([VPhbClass, VPhbSubclass, VSpellByClass, VClassSpellSlots, VPhbClassEquipment])],
  controllers: [ClassesController],
  providers: [ClassesService],
})
export class ClassesModule {}
