import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, In, Repository } from 'typeorm';
import { PhbItem } from '@entities/phb-item.entity';
import { PhbWeapon } from '@entities/phb-weapon.entity';
import { PhbWeaponMastery } from '@entities/phb-weapon-mastery.entity';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import {
  computeWeaponAttacks,
  type EquippedWeaponPiece,
  type WeaponAttack,
} from '../../domain/weapon-attacks';
import {
  hasPsychicBlades,
  PSYCHIC_BLADE_ITEM_SLUGS,
} from '../../domain/rogue/psychic-blades';
import { extraWeaponProficiencyFromClassOrder } from '@game/sheet/domain/validation/class-options/class-order-effects';
import {
  piecesFromCatalogSlugs,
  piecesFromInventory,
} from './build-pieces';
import type { WeaponAttackResolveContext } from './types';

export type { WeaponAttackResolveContext } from './types';

@Injectable()
export class ResolveEquippedWeaponAttacks {
  constructor(
    @InjectRepository(PlayerCharacterItem)
    private readonly inventoryItems: Repository<PlayerCharacterItem>,
    @InjectRepository(PhbWeapon)
    private readonly weapons: Repository<PhbWeapon>,
    @InjectRepository(PhbWeaponMastery)
    private readonly masteryRepo: Repository<PhbWeaponMastery>,
    @InjectRepository(PhbItem)
    private readonly catalogItems: Repository<PhbItem>,
    private readonly dataSource: DataSource,
  ) {}

  async resolve(
    characterId: string,
    scores: AbilityScores,
    context: WeaponAttackResolveContext,
  ): Promise<WeaponAttack[]> {
    const isMonk = context.classSlug === 'monk';
    const soulknifeBlades = hasPsychicBlades({
      classSlug: context.classSlug,
      subclassSlug: context.subclassSlug,
      level: context.level,
    });
    const equipped = context.equippedItems
      ? context.equippedItems.filter(
          (row) =>
            row.location === 'equipped' &&
            (row.equipmentSlot === 'main_hand' ||
              row.equipmentSlot === 'off_hand'),
        )
      : await this.inventoryItems.find({
          where: {
            characterId,
            location: 'equipped',
            equipmentSlot: In(['main_hand', 'off_hand']),
          },
        });

    const pieces: EquippedWeaponPiece[] = [];
    if (equipped.length > 0) {
      pieces.push(
        ...(await piecesFromInventory(
          this.weapons,
          this.masteryRepo,
          this.catalogItems,
          equipped,
        )),
      );
    }
    if (soulknifeBlades) {
      pieces.push(
        ...(await piecesFromCatalogSlugs(
          this.weapons,
          this.masteryRepo,
          [...PSYCHIC_BLADE_ITEM_SLUGS],
        )),
      );
    }

    if (pieces.length === 0 && !isMonk) {
      return [];
    }

    const weaponProficiencySlugs = [
      ...(await this.loadWeaponProficiencySlugs(context.classSlug)),
      ...extraWeaponProficiencyFromClassOrder(
        context.classSlug,
        context.classOptions,
      ),
    ];
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
      subclassSlug: context.subclassSlug,
      rageActive: context.rageActive,
      recklessActive: context.recklessActive,
    });
  }

  private async loadWeaponProficiencySlugs(
    classSlug: string,
  ): Promise<string[]> {
    const rows = await this.dataSource.query<{ slug: string }[]>(
      `SELECT cwp.ref_slug AS slug
       FROM rpg.phb_class c
       JOIN rpg.phb_class_proficiency cwp
         ON cwp.class_id = c.id AND cwp.kind = 'weapon'::rpg.class_proficiency_kind
       WHERE c.slug = $1
       ORDER BY cwp.ref_slug`,
      [classSlug],
    );
    return rows.map((row) => row.slug);
  }
}
