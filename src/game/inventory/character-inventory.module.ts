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
import { AssertCanBindPactWeaponService } from './application/assert-can-bind-pact-weapon.service';
import { AssertCanEquipItemService } from './application/assert-can-equip-item.service';
import { AttachWeaponCharmHandler } from './application/attach-weapon-charm.handler';
import { AttachCoverageHandler } from './application/attach-coverage.handler';
import { GetCharacterInventoryQuery } from './application/get-character-inventory.query';
import { AddInventoryItemHandler } from './application/add-inventory-item.handler';
import { PatchInventoryItemHandler } from './application/patch-inventory-item.handler';
import { RemoveInventoryItemHandler } from './application/remove-inventory-item.handler';
import { SeedStartingInventoryHandler } from './application/seed-starting-inventory.handler';
import { ApplyArtifactRegenHandler } from './application/apply-artifact-regen.handler';
import { ArtifactRegenAccessHandler } from './application/artifact-regen-access.handler';
import { ApplyArtifactPolishHandler } from './application/apply-artifact-polish.handler';
import { InventoryActionsHandler } from './application/inventory-actions.handler';
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
