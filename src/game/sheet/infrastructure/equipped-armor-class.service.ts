import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { VPhbArmor } from '../../../entities/views/v-phb-armor.entity';
import { PlayerCharacterItem } from '../../inventory/infrastructure/player-character-item.entity';
import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import {
  computeArmorClassFromEquipment,
  computeUnarmoredArmorClass,
  type EquippedArmorPiece,
} from '../domain/armor-class';

@Injectable()
export class EquippedArmorClassService {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
    @InjectRepository(VPhbArmor)
    private readonly armorCatalog: Repository<VPhbArmor>,
  ) {}

  async resolve(
    characterId: string,
    scores: AbilityScores,
  ): Promise<{ armorClass: number; armorClassNote: string }> {
    const equipped = await this.inventoryItems.find({
      where: { characterId, location: 'equipped' },
    });

    const armorSlots = equipped.filter(
      (row) => row.equipmentSlot === 'armor' || row.equipmentSlot === 'shield',
    );

    if (armorSlots.length === 0) {
      return {
        armorClass: computeUnarmoredArmorClass(scores),
        armorClassNote: 'Sem armadura',
      };
    }

    const slugs = armorSlots.map((row) => row.itemSlug);
    const catalogRows = await this.armorCatalog.find({
      where: { itemSlug: In(slugs) },
    });

    const pieces: EquippedArmorPiece[] = catalogRows.map((row) => ({
      itemSlug: row.itemSlug,
      itemName: row.itemName,
      categorySlug: row.categorySlug,
      acBase: row.acBase,
    }));

    if (pieces.length === 0) {
      return {
        armorClass: computeUnarmoredArmorClass(scores),
        armorClassNote: 'Sem armadura',
      };
    }

    return computeArmorClassFromEquipment(scores, pieces);
  }
}
