import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { VPhbArmor } from '@entities/views/v-phb-armor.entity';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import {
  computeEquipmentCompliance,
  type EquipmentComplianceResult,
  type EquippedArmorCompliancePiece,
} from '../domain/equipment';
import {
  analyzeDualWield,
  heavyWeaponSlugsForSmallSize,
  type EquippedWeaponPiece,
} from '../domain/weapon-attacks';
import type { SizeCategory } from '../domain/equipment';
import { PhbWeapon } from '@entities/phb-weapon.entity';
import { weaponPropsOf } from '@catalog/equipment/weapon-props';
import { extraArmorTrainingFromClassOrder } from '@game/sheet/domain/validation/class-options/class-order-effects';

export type EquipmentComplianceResolveInput = {
  classSlug: string;
  strengthScore: number;
  featSlugs?: readonly string[];
  classOptions?: readonly { optionKey: string; valueId: string }[];
  sizeCategory?: SizeCategory;
  weaponPieces?: EquippedWeaponPiece[];
  hasShield?: boolean;
  /** Snapshot compartilhado — evita novo `find` no combat slice. */
  equippedItems?: PlayerCharacterItem[];
};

@Injectable()
export class ResolveEquipmentCompliance {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
    @InjectRepository(VPhbArmor)
    private readonly armorCatalog: Repository<VPhbArmor>,
    @InjectRepository(PhbWeapon)
    private readonly weapons: Repository<PhbWeapon>,
    private readonly dataSource: DataSource,
  ) {}

  async resolve(
    characterId: string,
    input: EquipmentComplianceResolveInput,
  ): Promise<EquipmentComplianceResult> {
    const equipped =
      input.equippedItems ??
      (await this.inventoryItems.find({
        where: { characterId, location: 'equipped' },
      }));

    const armorSlots = equipped.filter(
      (row) => row.equipmentSlot === 'armor' || row.equipmentSlot === 'shield',
    );

    let pieces: EquippedArmorCompliancePiece[] = [];
    if (armorSlots.length > 0) {
      const catalogRows = await this.armorCatalog.find({
        where: { itemSlug: In(armorSlots.map((row) => row.itemSlug)) },
      });
      pieces = catalogRows.map((row) => ({
        itemSlug: row.itemSlug,
        itemName: row.itemName,
        categorySlug: row.categorySlug,
        strengthReq: row.strengthReq,
        stealthDisadvantage: row.stealthDisadvantage,
      }));
    }

    const weaponPieces =
      input.weaponPieces ?? (await this.loadWeaponPieces(equipped));
    const dual = analyzeDualWield(weaponPieces, {
      proficiencyBonus: 0,
      weaponProficiencySlugs: [],
      featSlugs: input.featSlugs,
    });

    const armorTrainingSlugs = [
      ...(await this.loadArmorTrainingSlugs(input.classSlug)),
      ...extraArmorTrainingFromClassOrder(input.classSlug, input.classOptions),
    ];
    const heavySlugs = heavyWeaponSlugsForSmallSize(
      weaponPieces,
      input.sizeCategory,
    );

    return computeEquipmentCompliance(pieces, {
      strengthScore: input.strengthScore,
      armorTrainingSlugs,
      featSlugs: input.featSlugs,
      dualWieldNeedsFeat: dual.dualWieldNeedsFeat,
      dualWieldTwoHandedOffHand: dual.dualWieldTwoHandedOffHand,
      heavyWeaponSlugsForSmall: heavySlugs,
    });
  }

  async loadArmorTrainingSlugs(classSlug: string): Promise<string[]> {
    const rows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT ac.slug
       FROM rpg.phb_class c
       JOIN rpg.phb_class_proficiency cat
         ON cat.class_id = c.id AND cat.kind = 'armor_training'::rpg.class_proficiency_kind
       JOIN rpg.phb_armor_category ac ON ac.id = cat.ref_id
       WHERE c.slug = $1
       ORDER BY ac.id`,
      [classSlug],
    );
    return rows.map((row) => row.slug);
  }

  private async loadWeaponPieces(
    equipped: PlayerCharacterItem[],
  ): Promise<EquippedWeaponPiece[]> {
    const handItems = equipped.filter(
      (row) =>
        row.equipmentSlot === 'main_hand' || row.equipmentSlot === 'off_hand',
    );
    if (handItems.length === 0) return [];

    const rows = await this.weapons.find({
      where: { item: { slug: In(handItems.map((row) => row.itemSlug)) } },
      relations: ['item'],
    });
    const bySlug = new Map(rows.map((row) => [row.item.slug, row]));
    const pieces: EquippedWeaponPiece[] = [];
    for (const item of handItems) {
      const weapon = bySlug.get(item.itemSlug);
      if (!weapon) continue;
      const props = weaponPropsOf(weapon);
      pieces.push({
        itemSlug: weapon.item.slug,
        itemName: weapon.item.name,
        category: weapon.category,
        damage: weapon.damage,
        damageType: weapon.damageType,
        versatileDamage: props.versatileDamage ?? null,
        propertySlugs: props.propertyIds ?? [],
        equipmentSlot: item.equipmentSlot ?? 'main_hand',
      });
    }
    return pieces;
  }
}
