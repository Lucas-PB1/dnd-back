import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbMetamagic } from '@entities/phb-metamagic.entity';
import { MetamagicsController } from './metamagics.controller';
import { FindMetamagicsQuery } from './queries/find-metamagics.query';

@Module({
  imports: [TypeOrmModule.forFeature([PhbMetamagic])],
  controllers: [MetamagicsController],
  providers: [FindMetamagicsQuery],
  exports: [FindMetamagicsQuery],
})
export class MetamagicsModule {}
