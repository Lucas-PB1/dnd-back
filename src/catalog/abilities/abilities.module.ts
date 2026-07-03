import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbAbility } from '../../entities/phb-ability.entity';
import { AbilitiesController } from './abilities.controller';
import { AbilitiesMapper } from './abilities.mapper';
import { FindAbilitiesQuery } from './queries/find-abilities.query';

@Module({
  imports: [TypeOrmModule.forFeature([PhbAbility])],
  controllers: [AbilitiesController],
  providers: [AbilitiesMapper, FindAbilitiesQuery],
})
export class AbilitiesModule {}
