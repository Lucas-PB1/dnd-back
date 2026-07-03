import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbSkill } from '../../entities/phb-skill.entity';
import { SkillsController } from './skills.controller';
import { SkillsService } from './skills.service';

@Module({
  imports: [TypeOrmModule.forFeature([PhbSkill])],
  controllers: [SkillsController],
  providers: [SkillsService],
})
export class SkillsModule {}
