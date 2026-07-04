import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbBackground } from '../../entities/views/v-phb-background.entity';
import { VPhbBackgroundEquipment } from '../../entities/views/v-phb-background-equipment.entity';
import { VPhbBackgroundSkill } from '../../entities/views/v-phb-background-skill.entity';
import { CatalogLookupModule } from '../catalog-lookup.module';
import { BackgroundsController } from './backgrounds.controller';
import { BackgroundsMapper } from './backgrounds.mapper';
import { FindBackgroundsQuery } from './queries/find-backgrounds.query';
import { FindBackgroundBySlugQuery } from './queries/find-background-by-slug.query';
import { FindBackgroundEquipmentQuery } from './queries/find-background-equipment.query';
import { FindBackgroundSkillsQuery } from './queries/find-background-skills.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      VPhbBackground,
      VPhbBackgroundEquipment,
      VPhbBackgroundSkill,
    ]),
    CatalogLookupModule,
  ],
  controllers: [BackgroundsController],
  providers: [
    BackgroundsMapper,
    FindBackgroundsQuery,
    FindBackgroundBySlugQuery,
    FindBackgroundEquipmentQuery,
    FindBackgroundSkillsQuery,
  ],
})
export class BackgroundsModule {}
