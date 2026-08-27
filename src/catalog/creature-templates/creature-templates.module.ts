import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbCreatureTemplate } from '@entities/phb-creature-template.entity';
import { VPhbCreatureTemplateBundle } from '@entities/views/v-phb-creature-template-bundle.entity';
import { CreatureTemplatesController } from './creature-templates.controller';
import { CreatureTemplateMapper } from './creature-template.mapper';
import {
  FindCreatureTemplateBySlugQuery,
  FindCreatureTemplatesQuery,
} from './queries/find-creature-templates.query';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PhbCreatureTemplate,
      VPhbCreatureTemplateBundle,
    ]),
  ],
  controllers: [CreatureTemplatesController],
  providers: [
    CreatureTemplateMapper,
    FindCreatureTemplatesQuery,
    FindCreatureTemplateBySlugQuery,
  ],
})
export class CreatureTemplatesModule {}
