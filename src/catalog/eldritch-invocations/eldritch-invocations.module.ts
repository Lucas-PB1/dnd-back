import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbEldritchInvocation } from '../../entities/phb-eldritch-invocation.entity';
import { EldritchInvocationsController } from './eldritch-invocations.controller';
import { FindEldritchInvocationsQuery } from './queries/find-eldritch-invocations.query';

@Module({
  imports: [TypeOrmModule.forFeature([PhbEldritchInvocation])],
  controllers: [EldritchInvocationsController],
  providers: [FindEldritchInvocationsQuery],
  exports: [FindEldritchInvocationsQuery],
})
export class EldritchInvocationsModule {}
