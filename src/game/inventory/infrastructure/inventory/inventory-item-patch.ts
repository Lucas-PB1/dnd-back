import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/phb-item.entity';
import { BadRequestException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import {
  InventoryItemResponseDto,
  PatchInventoryItemDto,
} from '@game/inventory/dto/inventory.dto';
import { EquipmentSlotResolver } from '../equipment-slot-resolver';
import { PlayerCharacterItem } from '../player-character-item.entity';
import type { DmgArtifactRandomProperty } from '../dmg-artifact-random-property.entity';
import {
  applyAttachedCoverageAttunement,
  applyBoundSpellSlug,
  applyInventoryAttunement,
  applyPactWeaponFlag,
  clearEquippedSlotIfOccupied,
  findInventoryItemOrFail,
  inventoryItemToDto,
  type AttunementCharacterContext,
} from './inventory-item-ops';
import { assertInventoryAddFits } from './inventory-encumbrance';
import {
  loadArtifactRandomRows,
  loadSpellPicker,
} from './load-artifact-attunement-deps';

export async function patchInventoryItem(input: {
  items: Repository<PlayerCharacterItem>;
  catalogItems: Repository<PhbItem>;
  catalogLookup: CatalogLookupService;
  slotResolver: EquipmentSlotResolver;
  artifactRandomProperties: Repository<DmgArtifactRandomProperty>;
  dataSource: DataSource;
  characterId: string;
  itemSlug: string;
  dto: PatchInventoryItemDto;
  strengthScore: number;
  character: AttunementCharacterContext;
}): Promise<InventoryItemResponseDto> {
  const {
    items,
    catalogItems,
    catalogLookup,
    slotResolver,
    artifactRandomProperties,
    dataSource,
    characterId,
    itemSlug,
    dto,
    strengthScore,
    character,
  } = input;

  const row = await findInventoryItemOrFail(items, characterId, itemSlug);

  if (dto.quantity !== undefined && dto.quantity > row.quantity) {
    const catalog = await catalogLookup.assertItemInCatalog(itemSlug);
    await assertInventoryAddFits({
      items,
      catalogItems,
      characterId,
      strengthScore,
      weight: catalog.weight,
      deltaQuantity: dto.quantity - row.quantity,
      itemSlug,
    });
  }

  if (dto.quantity !== undefined) {
    row.quantity = dto.quantity;
  }

  const touchesLocation =
    dto.location !== undefined || dto.equipmentSlot !== undefined;

  if (touchesLocation) {
    const targetLocation = dto.location ?? row.location;
    let targetSlot = dto.equipmentSlot ?? row.equipmentSlot;

    if (targetLocation === 'backpack') {
      row.location = 'backpack';
      row.equipmentSlot = null;
    } else {
      targetSlot = await slotResolver.resolve(characterId, itemSlug, targetSlot);
      await clearEquippedSlotIfOccupied(
        items,
        characterId,
        targetSlot,
        itemSlug,
      );
      row.location = 'equipped';
      row.equipmentSlot = targetSlot;
    }
  }

  if (dto.attuned !== undefined) {
    const pickSpellByLevel = await loadSpellPicker(dataSource);
    await applyInventoryAttunement({
      items,
      catalogLookup,
      characterId,
      character,
      row,
      attuned: dto.attuned,
      artifactRoll: {
        loadArtifactRandomRows: () =>
          loadArtifactRandomRows(artifactRandomProperties),
        pickSpellByLevel,
      },
    });
  }

  if (dto.attachedCoverageAttuned !== undefined) {
    await applyAttachedCoverageAttunement({
      items,
      catalogLookup,
      characterId,
      character,
      row,
      attuned: dto.attachedCoverageAttuned,
    });
  }

  if (dto.pactWeapon !== undefined) {
    await applyPactWeaponFlag({
      items,
      characterId,
      row,
      pactWeapon: dto.pactWeapon,
    });
  }

  if (dto.boundSpellSlug !== undefined) {
    await applyBoundSpellSlug({
      catalogLookup,
      row,
      boundSpellSlug: dto.boundSpellSlug,
    });
  }

  if (dto.containedInItemSlug !== undefined) {
    if (dto.containedInItemSlug === null) {
      row.containedInItemSlug = null;
    } else if (dto.containedInItemSlug === itemSlug) {
      throw new BadRequestException('Item cannot contain itself');
    } else {
      await findInventoryItemOrFail(
        items,
        characterId,
        dto.containedInItemSlug,
      );
      row.containedInItemSlug = dto.containedInItemSlug;
    }
  }

  await items.save(row);
  return inventoryItemToDto(catalogItems, row);
}
