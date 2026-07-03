import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhbItem } from '../../entities/phb-item.entity';
import { GameSharedModule } from '../shared/game-shared.module';
import { PlayerCharacterItem } from './infrastructure/player-character-item.entity';
import { CharacterInventoryRepository } from './infrastructure/character-inventory.repository';
import { CharacterInventoryController } from './character-inventory.controller';
import { GetCharacterInventoryQuery } from './application/get-character-inventory.query';
import { AddInventoryItemHandler } from './application/add-inventory-item.handler';
import { PatchInventoryItemHandler } from './application/patch-inventory-item.handler';
import { RemoveInventoryItemHandler } from './application/remove-inventory-item.handler';

@Module({
  imports: [
    TypeOrmModule.forFeature([PlayerCharacterItem, PhbItem]),
    GameSharedModule,
  ],
  controllers: [CharacterInventoryController],
  providers: [
    CharacterInventoryRepository,
    GetCharacterInventoryQuery,
    AddInventoryItemHandler,
    PatchInventoryItemHandler,
    RemoveInventoryItemHandler,
  ],
})
export class CharacterInventoryModule {}
