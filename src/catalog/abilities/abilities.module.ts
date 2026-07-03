import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbAbility } from '../../entities/phb-ability.entity';
import { AbilitiesController } from './abilities.controller';
import { AbilitiesService } from './abilities.service';

@Module({
  imports: [TypeOrmModule.forFeature([PhbAbility])],
  controllers: [AbilitiesController],
  providers: [AbilitiesService],
})
export class AbilitiesModule {}
