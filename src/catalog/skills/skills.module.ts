import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogLookupModule } from '@catalog/catalog-lookup.module';
import { PhbSkill } from '@entities/reference/phb-skill.entity';
import { SkillsController } from './skills.controller';
import { SkillsMapper } from './skills.mapper';
import { FindSkillsQuery } from './queries/find-skills.query';
import { FindSkillBySlugQuery } from './queries/find-skill-by-slug.query';

@Module({
  imports: [CatalogLookupModule, TypeOrmModule.forFeature([PhbSkill])],
  controllers: [SkillsController],
  providers: [SkillsMapper, FindSkillsQuery, FindSkillBySlugQuery],
})
export class SkillsModule {}
