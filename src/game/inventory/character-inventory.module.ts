import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '../../catalog/catalog.module';
import { PhbItem } from '../../entities/phb-item.entity';
import { VPhbArmor } from '../../entities/views/v-phb-armor.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { PlayerCharacterItem } from './infrastructure/player-character-item.entity';
import { CharacterInventoryRepository } from './infrastructure/character-inventory.repository';
import { EquipmentSlotResolver } from './infrastructure/equipment-slot-resolver';
import { CharacterInventoryController } from './character-inventory.controller';
import { GetCharacterInventoryQuery } from './application/get-character-inventory.query';
import { AddInventoryItemHandler } from './application/add-inventory-item.handler';
import { PatchInventoryItemHandler } from './application/patch-inventory-item.handler';
import { RemoveInventoryItemHandler } from './application/remove-inventory-item.handler';

@Module({
  imports: [
    TypeOrmModule.forFeature([PlayerCharacterItem, PhbItem, VPhbArmor]),
    GameSharedModule,
    CatalogModule,
  ],
  controllers: [CharacterInventoryController],
  providers: [
    CharacterInventoryRepository,
    EquipmentSlotResolver,
    GetCharacterInventoryQuery,
    AddInventoryItemHandler,
    PatchInventoryItemHandler,
    RemoveInventoryItemHandler,
  ],
})
export class CharacterInventoryModule {}
