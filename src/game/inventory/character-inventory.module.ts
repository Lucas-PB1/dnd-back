import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { PhbItem } from '../../entities/phb-item.entity';
import { PhbWeapon } from '../../entities/phb-weapon.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { CombatModule } from '../combat/combat.module';
import { GameSharedModule } from '../shared/game-shared.module';
import {
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
} from '../sheet/infrastructure/player-sheet.entities';
import { PlayerCharacterItem } from './infrastructure/player-character-item.entity';
import { CharacterInventoryRepository } from './infrastructure/character-inventory.repository';
import { EquipmentSlotResolver } from './infrastructure/equipment-slot-resolver';
import { CharacterInventoryController } from './character-inventory.controller';
import { AssertCanEquipItemService } from './application/assert-can-equip-item.service';
import { GetCharacterInventoryQuery } from './application/get-character-inventory.query';
import { AddInventoryItemHandler } from './application/add-inventory-item.handler';
import { PatchInventoryItemHandler } from './application/patch-inventory-item.handler';
import { RemoveInventoryItemHandler } from './application/remove-inventory-item.handler';
import { SeedStartingInventoryHandler } from './application/seed-starting-inventory.handler';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacterItem,
      PlayerCharacterEquipment,
      PlayerCharacterFeat,
      PhbItem,
      PhbWeapon,
      VPhbArmor,
    ]),
    GameSharedModule,
    CatalogModule,
    CombatModule,
  ],
  controllers: [CharacterInventoryController],
  providers: [
    CharacterInventoryRepository,
    EquipmentSlotResolver,
    AssertCanEquipItemService,
    GetCharacterInventoryQuery,
    AddInventoryItemHandler,
    PatchInventoryItemHandler,
    RemoveInventoryItemHandler,
    SeedStartingInventoryHandler,
  ],
  exports: [SeedStartingInventoryHandler],
})
export class CharacterInventoryModule {}
