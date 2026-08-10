import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterInventoryRepository } from '../infrastructure/character-inventory.repository';
import {
  InventoryItemResponseDto,
  PatchInventoryItemDto,
} from '../dto/inventory.dto';
import { AssertCanBindPactWeaponService } from './assert-can-bind-pact-weapon.service';
import { AssertCanEquipItemService } from './assert-can-equip-item.service';

function isEquipping(dto: PatchInventoryItemDto): boolean {
  if (dto.location === 'equipped') return true;
  if (dto.location === 'backpack') return false;
  return dto.equipmentSlot !== undefined;
}

@Injectable()
export class PatchInventoryItemHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly inventory: CharacterInventoryRepository,
    private readonly assertCanEquip: AssertCanEquipItemService,
    private readonly assertCanBindPact: AssertCanBindPactWeaponService,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    itemSlug: string,
    dto: PatchInventoryItemDto,
  ): Promise<InventoryItemResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (isEquipping(dto)) {
      await this.assertCanEquip.assert(character, itemSlug);
    }
    if (dto.pactWeapon === true) {
      await this.assertCanBindPact.assert(character, itemSlug);
    }
    return this.inventory.patch(
      characterId,
      itemSlug,
      dto,
      character.abilityScores?.forca ?? 10,
      {
        classSlug: character.classSlug,
        speciesSlug: character.speciesSlug ?? null,
      },
    );
  }
}
