import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { VPhbArmor } from '@entities/views/v-phb-armor.entity';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import {
  computeArmorClassFromEquipment,
  type EquippedArmorPiece,
  type UnarmoredDefenseRow,
} from '../domain/equipment';
import { CombatCatalogService } from '../infrastructure/combat-catalog.service';

export type ArmorClassResolveInput = {
  classSlug?: string | null;
  subclassSlug?: string | null;
  featSlugs?: string[];
  fightingStyleSlugs?: string[];
  itemAcBonus?: number;
  itemAcBonusNames?: readonly string[];
  /** Snapshot compartilhado — evita novo `find` no combat slice. */
  equippedItems?: PlayerCharacterItem[];
  manikinArmorPresetSlug?: string | null;
  /** Catálogo de armadura já carregado (combat bundle). */
  armorCatalogRows?: Array<{
    itemSlug: string;
    itemName: string;
    categorySlug: string;
    acBase: number;
  }>;
  unarmoredDefenses?: UnarmoredDefenseRow[];
};

@Injectable()
export class ResolveEquippedArmorClass {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
    @InjectRepository(VPhbArmor)
    private readonly armorCatalog: Repository<VPhbArmor>,
    private readonly combatCatalog: CombatCatalogService,
  ) {}

  async resolve(
    characterId: string,
    scores: AbilityScores,
    context: ArmorClassResolveInput = {},
  ): Promise<{ armorClass: number; armorClassNote: string }> {
    const equipped =
      context.equippedItems ??
      (await this.inventoryItems.find({
        where: { characterId, location: 'equipped' },
      }));

    const armorSlots = equipped.filter(
      (row) => row.equipmentSlot === 'armor' || row.equipmentSlot === 'shield',
    );

    let pieces: EquippedArmorPiece[] = [];
    if (armorSlots.length > 0) {
      const slugs = armorSlots.map((row) => row.itemSlug);
      const catalogRows =
        context.armorCatalogRows ??
        (await this.armorCatalog.find({
          where: { itemSlug: In(slugs) },
        }));
      const wanted = new Set(slugs);
      pieces = catalogRows
        .filter((row) => wanted.has(row.itemSlug))
        .map((row) => ({
          itemSlug: row.itemSlug,
          itemName: row.itemName,
          categorySlug: row.categorySlug,
          acBase: row.acBase,
        }));
    }

    const unarmoredDefenses =
      context.unarmoredDefenses ??
      (await this.combatCatalog.loadUnarmoredDefenses({
        classSlug: context.classSlug,
        subclassSlug: context.subclassSlug,
      }));

    return computeArmorClassFromEquipment(scores, pieces, {
      featSlugs: context.featSlugs,
      fightingStyleSlugs: context.fightingStyleSlugs,
      unarmoredDefenses,
      itemAcBonus: context.itemAcBonus,
      itemAcBonusNames: context.itemAcBonusNames,
      manikinArmorPresetSlug: context.manikinArmorPresetSlug,
    });
  }
}
