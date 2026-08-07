import { Module } from '@nestjs/common';
import { CombatModule } from '../../game/combat/combat.module';
import { CombatMechanicalController } from './combat-mechanical.controller';
import { FindCombatMechanicalCatalogQuery } from './queries/find-combat-mechanical-catalog.query';

@Module({
  imports: [CombatModule],
  controllers: [CombatMechanicalController],
  providers: [FindCombatMechanicalCatalogQuery],
})
export class CombatMechanicalModule {}
