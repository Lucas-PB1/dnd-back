import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { VPhbSpell } from '../../entities/views/v-phb-spell.entity';
import { SpellsController } from './spells.controller';
import { SpellsService } from './spells.service';

@Module({
  imports: [TypeOrmModule.forFeature([VPhbSpell])],
  controllers: [SpellsController],
  providers: [SpellsService],
})
export class SpellsModule {}
