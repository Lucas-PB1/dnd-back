import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbClass } from '../../entities/views/v-phb-class.entity';
import { VPhbSubclass } from '../../entities/views/v-phb-subclass.entity';
import { ClassesController } from './classes.controller';
import { ClassesService } from './classes.service';

@Module({
  imports: [TypeOrmModule.forFeature([VPhbClass, VPhbSubclass])],
  controllers: [ClassesController],
  providers: [ClassesService],
})
export class ClassesModule {}
