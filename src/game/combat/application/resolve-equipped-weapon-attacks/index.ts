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
import {
  grantedWeaponPropertySlugsFromEffects,
  hasVersatileOneHandFullDamage,
  overrideWeaponRangeFtFromEffects,
} from '@game/effects';

export type { WeaponAttackResolveContext } from './types';

function applyFeatWeaponMerges(
  pieces: EquippedWeaponPiece[],
  context: WeaponAttackResolveContext,
): EquippedWeaponPiece[] {
  const effects = context.featEffects ?? [];
  const featSlugs = context.featSlugs ?? [];
  if (effects.length === 0 || featSlugs.length === 0) return pieces;

  const granted = grantedWeaponPropertySlugsFromEffects(effects, featSlugs);
  const rangeOverride = overrideWeaponRangeFtFromEffects(effects, featSlugs);
  const versatileFull = hasVersatileOneHandFullDamage(effects, featSlugs);

  return pieces.map((piece) => {
    const propertySlugs = [...piece.propertySlugs];
    for (const prop of granted) {
      if (
        prop === 'returning' &&
        propertySlugs.includes('thrown') &&
        !propertySlugs.includes('returning')
      ) {
        propertySlugs.push('returning');
      }
      if (
        prop === 'light' &&
        propertySlugs.includes('versatile') &&
        !propertySlugs.includes('light')
      ) {
        propertySlugs.push('light');
      }
    }
    let versatileDamage = piece.versatileDamage;
    if (versatileFull && piece.versatileDamage) {
      // Empunhadura Expandida: 1H usa dano entre parênteses — sinaliza via property
      if (!propertySlugs.includes('versatile-full-1h')) {
        propertySlugs.push('versatile-full-1h');
      }
      versatileDamage = piece.versatileDamage;
    }
    return {
      ...piece,
      propertySlugs,
      versatileDamage,
      ...(rangeOverride && propertySlugs.includes('thrown')
        ? {
            /* alcance tipado fica na note de combate; peças não têm rangeFt hoje */
          }
        : {}),
    };
  });
}

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

    const mergedPieces = applyFeatWeaponMerges(pieces, context);

    const weaponProficiencySlugs = [
      ...(await this.loadWeaponProficiencySlugs(context.classSlug)),
      ...extraWeaponProficiencyFromClassOrder(
        context.classSlug,
        context.classOptions,
      ),
    ];
    return computeWeaponAttacks(scores, mergedPieces, {
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
      unarmedDamageDie: context.unarmedDamageDie,
      featEffects: context.featEffects,
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
