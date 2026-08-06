import {
  BadRequestException,
  Injectable,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '../../../catalog/catalog-lookup.service';
import { PhbItem } from '../../../entities/phb-item.entity';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { parseWeaponCharm } from '../../combat/domain/weapon-charm';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import {
  AttachWeaponCharmDto,
  DetachWeaponCharmDto,
  InventoryItemResponseDto,
} from '../dto/inventory.dto';
import {
  findInventoryItemOrFail,
  inventoryItemToDto,
} from '../infrastructure/inventory/inventory-item-ops';
import { PlayerCharacterItem } from '../infrastructure/player-character-item.entity';

@Injectable()
export class AttachWeaponCharmHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    @InjectRepository(PlayerCharacterItem)
    private readonly items: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
    @InjectRepository(PhbWeapon)
    private readonly weapons: Repository<PhbWeapon>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async attach(
    userId: string,
    characterId: string,
    dto: AttachWeaponCharmDto,
  ): Promise<InventoryItemResponseDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    return this.attachCharm(characterId, dto.weaponSlug, dto.charmSlug);
  }

  async detach(
    userId: string,
    characterId: string,
    dto: DetachWeaponCharmDto,
  ): Promise<InventoryItemResponseDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    return this.detachCharm(characterId, dto.weaponSlug);
  }

  private async attachCharm(
    characterId: string,
    weaponSlug: string,
    charmSlug: string,
  ): Promise<InventoryItemResponseDto> {
    const weaponRow = await findInventoryItemOrFail(
      this.items,
      characterId,
      weaponSlug,
    );
    await this.assertIsWeapon(weaponSlug);

    const charmCatalog = await this.catalogLookup.assertItemInCatalog(charmSlug);
    const charm = parseWeaponCharm(
      (charmCatalog.properties ?? null) as Record<string, unknown> | null,
    );
    if (!charm) {
      throw new BadRequestException(
        `Item '${charmSlug}' is not a weapon charm`,
      );
    }

    const charmRow = await this.items.findOne({
      where: { characterId, itemSlug: charmSlug },
    });
    if (!charmRow || charmRow.location !== 'backpack' || charmRow.quantity < 1) {
      throw new BadRequestException(
        `Charm '${charmSlug}' must be in the backpack`,
      );
    }

    if (weaponRow.attachedCharmSlug === charmSlug) {
      return inventoryItemToDto(this.catalogItems, weaponRow);
    }

    if (weaponRow.attachedCharmSlug) {
      await this.returnCharmToBackpack(
        characterId,
        weaponRow.attachedCharmSlug,
      );
    }

    await this.consumeCharmFromBackpack(charmRow);
    weaponRow.attachedCharmSlug = charmSlug;
    await this.items.save(weaponRow);
    return inventoryItemToDto(this.catalogItems, weaponRow);
  }

  private async detachCharm(
    characterId: string,
    weaponSlug: string,
  ): Promise<InventoryItemResponseDto> {
    const weaponRow = await findInventoryItemOrFail(
      this.items,
      characterId,
      weaponSlug,
    );
    if (!weaponRow.attachedCharmSlug) {
      throw new BadRequestException(
        `Weapon '${weaponSlug}' has no attached charm`,
      );
    }

    await this.returnCharmToBackpack(
      characterId,
      weaponRow.attachedCharmSlug,
    );
    weaponRow.attachedCharmSlug = null;
    await this.items.save(weaponRow);
    return inventoryItemToDto(this.catalogItems, weaponRow);
  }

  private async assertIsWeapon(weaponSlug: string): Promise<void> {
    const weapon = await this.weapons.findOne({
      where: { item: { slug: weaponSlug } },
      relations: ['item'],
    });
    if (!weapon) {
      throw new BadRequestException(`Item '${weaponSlug}' is not a weapon`);
    }
  }

  private async consumeCharmFromBackpack(
    charmRow: PlayerCharacterItem,
  ): Promise<void> {
    if (charmRow.quantity <= 1) {
      await this.items.remove(charmRow);
      return;
    }
    charmRow.quantity -= 1;
    await this.items.save(charmRow);
  }

  private async returnCharmToBackpack(
    characterId: string,
    charmSlug: string,
  ): Promise<void> {
    const existing = await this.items.findOne({
      where: { characterId, itemSlug: charmSlug },
    });
    if (existing) {
      if (existing.location === 'equipped') {
        throw new BadRequestException(
          `Cannot return charm '${charmSlug}': another copy is equipped`,
        );
      }
      existing.quantity += 1;
      await this.items.save(existing);
      return;
    }

    await this.catalogLookup.assertItemInCatalog(charmSlug);
    await this.items.save(
      this.items.create({
        characterId,
        itemSlug: charmSlug,
        quantity: 1,
        location: 'backpack',
        equipmentSlot: null,
        attuned: false,
        attachedCharmSlug: null,
      }),
    );
  }
}
