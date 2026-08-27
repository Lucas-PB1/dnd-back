import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbVehicleTemplate } from '@entities/phb-vehicle-template.entity';
import { VPhbVehicleTemplateBundle } from '@entities/views/v-phb-vehicle-template-bundle.entity';
import { VehicleTemplatesController } from './vehicle-templates.controller';
import { VehicleTemplateMapper } from './vehicle-template.mapper';
import {
  FindVehicleTemplateBySlugQuery,
  FindVehicleTemplatesQuery,
} from './queries/find-vehicle-templates.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([PhbVehicleTemplate, VPhbVehicleTemplateBundle]),
  ],
  controllers: [VehicleTemplatesController],
  providers: [
    VehicleTemplateMapper,
    FindVehicleTemplatesQuery,
    FindVehicleTemplateBySlugQuery,
  ],
})
export class VehicleTemplatesModule {}
