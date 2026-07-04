import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbItem } from '../../../entities/phb-item.entity';
import { VPhbArmor } from '../../../entities/views/v-phb-armor.entity';
import type { EquipmentSlot } from './player-character-item.entity';
import { PlayerCharacterItem } from './player-character-item.entity';

@Injectable()
export class EquipmentSlotResolver {
  constructor(
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
    @InjectRepository(VPhbArmor)
    private readonly armorCatalog: Repository<VPhbArmor>,
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
  ) {}

  async resolve(
    characterId: string,
    itemSlug: string,
    provided?: EquipmentSlot | null,
  ): Promise<EquipmentSlot> {
    if (provided) return provided;

    const armor = await this.armorCatalog.findOne({ where: { itemSlug } });
    if (armor) {
      return armor.categorySlug === 'shield' ? 'shield' : 'armor';
    }

    const item = await this.catalogItems.findOne({ where: { slug: itemSlug } });
    if (item?.itemType === 'weapon') {
      const mainHand = await this.inventoryItems.findOne({
        where: { characterId, location: 'equipped', equipmentSlot: 'main_hand' },
      });
      if (!mainHand || mainHand.itemSlug === itemSlug) {
        return 'main_hand';
      }
      return 'off_hand';
    }

    throw new BadRequestException(
      'equipmentSlot is required when equipping this item',
    );
  }
}
