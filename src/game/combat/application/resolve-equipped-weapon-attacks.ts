import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { PhbWeapon } from '../../../entities/phb-weapon.entity';
import { PhbWeaponMastery } from '../../../entities/phb-weapon-mastery.entity';
import { PlayerCharacterItem } from '../../inventory/infrastructure/player-character-item.entity';
import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import {
  loadWeaponMasteryBySlug,
  weaponPropsOf,
} from '../../../catalog/equipment/weapon-props';
import {
  computeWeaponAttacks,
  type EquippedWeaponPiece,
  type WeaponAttack,
} from '../domain/weapon-attack';

export type WeaponAttackResolveContext = {
  classSlug: string;
  proficiencyBonus: number;
  featSlugs?: readonly string[];
  fightingStyleSlugs?: readonly string[];
  sizeCategory?: import('../domain/creature-size').SizeCategory;
  hasShield?: boolean;
  masteredWeaponSlugs?: readonly string[];
  itemAttackBonus?: number;
  itemDamageBonus?: number;
  level?: number;
};

@Injectable()
export class ResolveEquippedWeaponAttacks {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbWeapon)
    private readonly weapons: Repository<PhbWeapon>,
    @InjectRepository(PhbWeaponMastery)
    private readonly masteryRepo: Repository<PhbWeaponMastery>,
    private readonly dataSource: DataSource,
  ) {}

  async resolve(
    characterId: string,
    scores: AbilityScores,
    context: WeaponAttackResolveContext,
  ): Promise<WeaponAttack[]> {
    const equipped = await this.inventoryItems.find({
      where: {
        characterId,
        location: 'equipped',
        equipmentSlot: In(['main_hand', 'off_hand']),
      },
    });
    if (equipped.length === 0) return [];

    const rows = await this.weapons.find({
      where: { item: { slug: In(equipped.map((row) => row.itemSlug)) } },
      relations: ['item'],
    });
    const bySlug = new Map(rows.map((row) => [row.item.slug, row]));
    const masteryBySlug = await loadWeaponMasteryBySlug(rows, this.masteryRepo);
    const pieces: EquippedWeaponPiece[] = [];

    for (const item of equipped) {
      const weapon = bySlug.get(item.itemSlug);
      if (!weapon) continue;
      const props = weaponPropsOf(weapon);
      const masterySlug = props.masteryId ?? null;
      const mastery = masterySlug
        ? (masteryBySlug.get(masterySlug) ?? null)
        : null;
      pieces.push({
        itemSlug: weapon.item.slug,
        itemName: weapon.item.name,
        category: weapon.category,
        damage: weapon.damage,
        damageType: weapon.damageType,
        versatileDamage: props.versatileDamage ?? null,
        propertySlugs: props.propertyIds ?? [],
        equipmentSlot: item.equipmentSlot ?? 'main_hand',
        masterySlug,
        masteryName: mastery?.name ?? null,
        reloadCapacity:
          typeof props.reload === 'number' ? props.reload : null,
      });
    }

    if (pieces.length === 0) return [];

    const weaponProficiencySlugs = await this.loadWeaponProficiencySlugs(
      context.classSlug,
    );
    return computeWeaponAttacks(scores, pieces, {
      proficiencyBonus: context.proficiencyBonus,
      weaponProficiencySlugs,
      featSlugs: context.featSlugs,
      fightingStyleSlugs: context.fightingStyleSlugs,
      sizeCategory: context.sizeCategory,
      hasShield: context.hasShield,
      masteredWeaponSlugs: context.masteredWeaponSlugs,
      itemAttackBonus: context.itemAttackBonus,
      itemDamageBonus: context.itemDamageBonus,
      classSlug: context.classSlug,
      level: context.level,
    });
  }

  private async loadWeaponProficiencySlugs(classSlug: string): Promise<string[]> {
    const rows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT wp.slug
       FROM rpg.phb_class c
       JOIN rpg.phb_class_weapon_proficiency cwp ON cwp.class_id = c.id
       JOIN rpg.phb_weapon_proficiency wp ON wp.id = cwp.proficiency_id
       WHERE c.slug = $1
       ORDER BY wp.id`,
      [classSlug],
    );
    return rows.map((row) => row.slug);
  }
}
