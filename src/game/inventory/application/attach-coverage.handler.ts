import {
  BadRequestException,
  Injectable,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbItem } from '@entities/phb-item.entity';
import { PhbWeapon } from '@entities/phb-weapon.entity';
import { VPhbArmor } from '@entities/views/v-phb-armor.entity';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  itemRequiresAttunement,
  MAX_ATTUNED_ITEMS,
} from '../domain/attunement';
import {
  coverageMatchesBase,
  coverageRequiresTierBonus,
  parseItemCoverage,
  type CoverageBaseContext,
} from '../domain/coverage/item-coverage';
import {
  AttachCoverageDto,
  DetachCoverageDto,
  InventoryItemResponseDto,
} from '../dto/inventory.dto';
import {
  findInventoryItemOrFail,
  inventoryItemToDto,
} from '../infrastructure/inventory/inventory-item-ops';
import { PlayerCharacterItem } from '../infrastructure/player-character-item.entity';

@Injectable()
export class AttachCoverageHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    @InjectRepository(PlayerCharacterItem)
    private readonly items: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
    @InjectRepository(PhbWeapon)
    private readonly weapons: Repository<PhbWeapon>,
    @InjectRepository(VPhbArmor)
    private readonly armorCatalog: Repository<VPhbArmor>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async attach(
    userId: string,
    characterId: string,
    dto: AttachCoverageDto,
  ): Promise<InventoryItemResponseDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    return this.attachCoverage(
      characterId,
      dto.baseItemSlug,
      dto.coverageSlug,
      dto.bonus,
    );
  }

  async detach(
    userId: string,
    characterId: string,
    dto: DetachCoverageDto,
  ): Promise<InventoryItemResponseDto> {
    await this.access.findAccessibleOrFail(userId, characterId, 'write');
    return this.detachCoverage(characterId, dto.baseItemSlug);
  }

  private async attachCoverage(
    characterId: string,
    baseItemSlug: string,
    coverageSlug: string,
    bonus: 1 | 2 | 3 | undefined,
  ): Promise<InventoryItemResponseDto> {
    const baseRow = await findInventoryItemOrFail(
      this.items,
      characterId,
      baseItemSlug,
    );

    const coverageCatalog =
      await this.catalogLookup.assertItemInCatalog(coverageSlug);
    const coverageProps = (coverageCatalog.properties ?? null) as Record<
      string,
      unknown
    > | null;
    const coverage = parseItemCoverage(coverageProps);
    if (!coverage) {
      throw new BadRequestException(
        `Item '${coverageSlug}' is not a coverage (kind=coverage)`,
      );
    }

    const needsTier = coverageRequiresTierBonus(coverageSlug);
    if (needsTier && (bonus !== 1 && bonus !== 2 && bonus !== 3)) {
      throw new BadRequestException(
        `Coverage '${coverageSlug}' requires bonus 1, 2 or 3`,
      );
    }
    if (!needsTier && bonus != null) {
      throw new BadRequestException(
        `Coverage '${coverageSlug}' does not take a bonus tier`,
      );
    }

    const baseCtx = await this.resolveBaseContext(baseItemSlug);
    if (!coverageMatchesBase(coverage, baseCtx)) {
      throw new BadRequestException(
        `Coverage '${coverageSlug}' does not apply to '${baseItemSlug}' (${coverage.appliesFilter})`,
      );
    }

    const coverageRow = await this.items.findOne({
      where: { characterId, itemSlug: coverageSlug },
    });
    if (
      !coverageRow ||
      coverageRow.location !== 'backpack' ||
      coverageRow.quantity < 1
    ) {
      throw new BadRequestException(
        `Coverage '${coverageSlug}' must be in the backpack`,
      );
    }

    if (
      baseRow.attachedCoverageSlug === coverageSlug &&
      (baseRow.attachedCoverageBonus ?? null) === (bonus ?? null)
    ) {
      return inventoryItemToDto(this.catalogItems, baseRow);
    }

    if (baseRow.attachedCoverageSlug) {
      await this.returnCoverageToBackpack(
        characterId,
        baseRow.attachedCoverageSlug,
      );
      baseRow.attachedCoverageAttuned = false;
    }

    const requiresAttunement = itemRequiresAttunement(coverageProps);
    if (requiresAttunement) {
      await this.assertAttunementSlot(characterId);
    }

    await this.consumeFromBackpack(coverageRow);
    baseRow.attachedCoverageSlug = coverageSlug;
    baseRow.attachedCoverageBonus = needsTier ? (bonus ?? null) : null;
    baseRow.attachedCoverageAttuned = requiresAttunement;
    await this.items.save(baseRow);
    return inventoryItemToDto(this.catalogItems, baseRow);
  }

  private async detachCoverage(
    characterId: string,
    baseItemSlug: string,
  ): Promise<InventoryItemResponseDto> {
    const baseRow = await findInventoryItemOrFail(
      this.items,
      characterId,
      baseItemSlug,
    );
    if (!baseRow.attachedCoverageSlug) {
      throw new BadRequestException(
        `Item '${baseItemSlug}' has no attached coverage`,
      );
    }

    await this.returnCoverageToBackpack(
      characterId,
      baseRow.attachedCoverageSlug,
    );
    baseRow.attachedCoverageSlug = null;
    baseRow.attachedCoverageBonus = null;
    baseRow.attachedCoverageAttuned = false;
    await this.items.save(baseRow);
    return inventoryItemToDto(this.catalogItems, baseRow);
  }

  private async resolveBaseContext(
    itemSlug: string,
  ): Promise<CoverageBaseContext> {
    const catalog = await this.catalogLookup.assertItemInCatalog(itemSlug);
    const props = (catalog.properties ?? null) as Record<string, unknown> | null;
    const subtypeLabel =
      (typeof props?.weaponSubtype === 'string' && props.weaponSubtype) ||
      (typeof props?.armorSubtype === 'string' && props.armorSubtype) ||
      (typeof props?.category === 'string' && props.category) ||
      null;

    const weapon = await this.weapons.findOne({
      where: { item: { slug: itemSlug } },
      relations: ['item'],
    });
    const armor = await this.armorCatalog.findOne({
      where: { itemSlug },
    });

    return {
      itemSlug,
      itemName: catalog.name,
      itemType: catalog.itemType,
      weaponCategory: weapon?.category ?? null,
      armorCategorySlug: armor?.categorySlug ?? null,
      subtypeLabel,
    };
  }

  private async assertAttunementSlot(characterId: string): Promise<void> {
    const attunedCount = await this.items.count({
      where: { characterId, attuned: true },
    });
    const coverageAttunedCount = await this.items.count({
      where: { characterId, attachedCoverageAttuned: true },
    });
    if (attunedCount + coverageAttunedCount >= MAX_ATTUNED_ITEMS) {
      throw new BadRequestException(
        `Maximum of ${MAX_ATTUNED_ITEMS} attuned items reached`,
      );
    }
  }

  private async consumeFromBackpack(row: PlayerCharacterItem): Promise<void> {
    if (row.quantity <= 1) {
      await this.items.remove(row);
      return;
    }
    row.quantity -= 1;
    await this.items.save(row);
  }

  private async returnCoverageToBackpack(
    characterId: string,
    coverageSlug: string,
  ): Promise<void> {
    const existing = await this.items.findOne({
      where: { characterId, itemSlug: coverageSlug },
    });
    if (existing) {
      if (existing.location === 'equipped') {
        throw new BadRequestException(
          `Cannot return coverage '${coverageSlug}': another copy is equipped`,
        );
      }
      existing.quantity += 1;
      await this.items.save(existing);
      return;
    }

    await this.catalogLookup.assertItemInCatalog(coverageSlug);
    await this.items.save(
      this.items.create({
        characterId,
        itemSlug: coverageSlug,
        quantity: 1,
        location: 'backpack',
        equipmentSlot: null,
        attuned: false,
        attachedCharmSlug: null,
        attachedCoverageSlug: null,
        attachedCoverageBonus: null,
        attachedCoverageAttuned: false,
      }),
    );
  }
}
