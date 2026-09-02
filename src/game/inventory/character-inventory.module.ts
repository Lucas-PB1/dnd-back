import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CatalogModule } from '@catalog/catalog.module';
import { PhbItem } from '@entities/phb-item.entity';
import { PhbWeapon } from '@entities/phb-weapon.entity';
import { VPhbArmor } from '@entities/views/v-phb-armor.entity';
import { CombatModule } from '../combat/combat.module';
import { GameSharedModule } from '../shared/game-shared.module';
import {
  PlayerCharacterEquipment,
  PlayerCharacterFeat,
  PlayerCharacterOption,
} from '../sheet/infrastructure/player-sheet.entities';
import { PlayerCharacterItem } from './infrastructure/player-character-item.entity';
import { DmgArtifactRandomProperty } from './infrastructure/dmg-artifact-random-property.entity';
import { DmgSentientTraitTable } from './infrastructure/dmg-sentient-trait-table.entity';
import { CharacterInventoryRepository } from './infrastructure/character-inventory.repository';
import { EquipmentSlotResolver } from './infrastructure/equipment-slot-resolver';
import { CharacterInventoryController } from './character-inventory.controller';
import { AssertCanBindPactWeaponService } from './application/assert/assert-can-bind-pact-weapon.service';
import { AssertCanEquipItemService } from './application/assert/assert-can-equip-item.service';
import { AttachWeaponCharmHandler } from './application/attach/attach-weapon-charm.handler';
import { AttachCoverageHandler } from './application/attach/attach-coverage.handler';
import { GetCharacterInventoryQuery } from './application/query/get-character-inventory.query';
import { AddInventoryItemHandler } from './application/items/add-inventory-item.handler';
import { PurchaseInventoryHandler } from './application/purchase/purchase-inventory.handler';
import { PatchInventoryItemHandler } from './application/items/patch-inventory-item.handler';
import { RemoveInventoryItemHandler } from './application/items/remove-inventory-item.handler';
import { SeedStartingInventoryHandler } from './application/query/seed-starting-inventory.handler';
import { ApplyArtifactRegenHandler } from './application/artifact/apply-artifact-regen.handler';
import { ArtifactRegenAccessHandler } from './application/artifact/artifact-regen-access.handler';
import { ApplyArtifactPolishHandler } from './application/artifact/apply-artifact-polish.handler';
import { InventoryActionsHandler } from './application/actions/inventory-actions.handler';
import { PlayerCharacter } from '../shared/infrastructure/player-character.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerCharacterItem,
      PlayerCharacterEquipment,
      PlayerCharacterFeat,
      PlayerCharacterOption,
      PlayerCharacter,
      PhbItem,
      PhbWeapon,
      VPhbArmor,
      DmgArtifactRandomProperty,
      DmgSentientTraitTable,
    ]),
    GameSharedModule,
    CatalogModule,
    CombatModule,
  ],
  controllers: [CharacterInventoryController],
  providers: [
    CharacterInventoryRepository,
    EquipmentSlotResolver,
    AssertCanBindPactWeaponService,
    AssertCanEquipItemService,
    AttachWeaponCharmHandler,
    AttachCoverageHandler,
    InventoryActionsHandler,
    GetCharacterInventoryQuery,
    AddInventoryItemHandler,
    PurchaseInventoryHandler,
    PatchInventoryItemHandler,
    RemoveInventoryItemHandler,
    SeedStartingInventoryHandler,
    ApplyArtifactRegenHandler,
    ArtifactRegenAccessHandler,
    ApplyArtifactPolishHandler,
  ],
  exports: [
    SeedStartingInventoryHandler,
    CharacterInventoryRepository,
    AssertCanBindPactWeaponService,
  ],
})
export class CharacterInventoryModule {}
