import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbBackground } from '../../entities/views/v-phb-background.entity';
import { VPhbBackgroundEquipment } from '../../entities/views/v-phb-background-equipment.entity';
import { BackgroundsController } from './backgrounds.controller';
import { BackgroundsService } from './backgrounds.service';

@Module({
  imports: [TypeOrmModule.forFeature([VPhbBackground, VPhbBackgroundEquipment])],
  controllers: [BackgroundsController],
  providers: [BackgroundsService],
})
export class BackgroundsModule {}
