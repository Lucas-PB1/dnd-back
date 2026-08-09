import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { appliesRageDamageBonus } from '../barbarian/rage';
import { applyOverkillDamageBonus } from '../gunslinger/firearm';
import {
  abilityShortLabel,
  hasProperty,
  hasStyleOrFeat,
  isThrownWeapon,
  qualifiesForDueling,
} from './weapon-attack-predicates';
import type {
  EquippedWeaponPiece,
  WeaponAttackContext,
  WeaponAttackRole,
} from './weapon-attack.types';

/** PHB: Arquearia / Duelismo / Arremesso concedem +2. */
export const STYLE_FLAT_BONUS = 2;

export type AbilityPick = { slug: 'forca' | 'destreza'; mod: number };

export type AttackBonusResult = {
  attackBonus: number;
  attackParts: string[];
};

export type DamageBonusResult = {
  damageBonus: number;
  damageParts: string[];
  omitAbilityDamage: boolean;
  overkillExtraDice: string | null;
  overkillAbilityDamageBonus: number;
  rageBonus: number;
};

export function resolveAttackBonuses(input: {
  ability: AbilityPick;
  proficient: boolean;
  mode: 'melee' | 'ranged';
  context: WeaponAttackContext;
}): AttackBonusResult {
  const attackParts: string[] = [abilityShortLabel(input.ability.slug)];
  let attackBonus = input.ability.mod;

  if (input.proficient) {
    attackBonus += input.context.proficiencyBonus;
    attackParts.push('PB');
  }
  if (input.mode === 'ranged' && hasStyleOrFeat(input.context, 'archery')) {
    attackBonus += STYLE_FLAT_BONUS;
    attackParts.push('Arquearia');
  }

  const itemAttackBonus = input.context.itemAttackBonus ?? 0;
  if (itemAttackBonus !== 0) {
    attackBonus += itemAttackBonus;
    attackParts.push('item');
  }

  return { attackBonus, attackParts };
}

export function resolveDamageBonuses(input: {
  scores: AbilityScores;
  ability: AbilityPick;
  piece: EquippedWeaponPiece;
  mode: 'melee' | 'ranged';
  context: WeaponAttackContext;
  equippedWeapons: EquippedWeaponPiece[];
  role: WeaponAttackRole;
}): DamageBonusResult {
  const isBonusAttack =
    input.role === 'light_bonus' || input.role === 'dual_bonus';
  const hasTwf = hasStyleOrFeat(input.context, 'two-weapon-fighting');
  const omitAbilityDamage =
    isBonusAttack && !hasTwf && input.ability.mod >= 0;
  const isFirearm = hasProperty(input.piece, 'firearm');
  const overkill =
    input.mode === 'ranged'
      ? applyOverkillDamageBonus({
          level: input.context.level ?? 1,
          isFirearm,
          abilityMod: input.ability.mod,
        })
      : {
          abilityDamageBonus: input.ability.mod,
          extraDamageDice: null as string | null,
        };

  let damageBonus = 0;
  const damageParts: string[] = [];

  if (omitAbilityDamage) {
    if (input.ability.mod < 0) {
      damageBonus = input.ability.mod;
      damageParts.push(abilityShortLabel(input.ability.slug));
    }
  } else if (isFirearm && input.mode === 'ranged') {
    damageBonus = overkill.abilityDamageBonus;
    if (damageBonus !== 0) {
      damageParts.push(abilityShortLabel(input.ability.slug));
      if ((input.context.level ?? 1) >= 11) damageParts.push('Exagero');
    } else {
      damageParts.push('arma de fogo');
    }
  } else {
    damageBonus = overkill.abilityDamageBonus;
    damageParts.push(abilityShortLabel(input.ability.slug));
    if (overkill.extraDamageDice) damageParts.push('Exagero');
  }

  if (
    hasStyleOrFeat(input.context, 'dueling') &&
    qualifiesForDueling(input.piece, input.mode, input.equippedWeapons)
  ) {
    damageBonus += STYLE_FLAT_BONUS;
    damageParts.push('Duelismo');
  }
  if (
    input.mode === 'ranged' &&
    isThrownWeapon(input.piece) &&
    hasStyleOrFeat(input.context, 'thrown-weapon-fighting')
  ) {
    damageBonus += STYLE_FLAT_BONUS;
    damageParts.push('Arremesso');
  }
  if (
    hasProperty(input.piece, 'heavy') &&
    hasStyleOrFeat(input.context, 'great-weapon-master')
  ) {
    damageBonus += input.context.proficiencyBonus;
    damageParts.push('Mestre em Armas Grandes');
  }

  const rageBonus = appliesRageDamageBonus({
    classSlug: input.context.classSlug,
    level: input.context.level,
    rageActive: input.context.rageActive,
    mode: input.mode,
    abilitySlug: input.ability.slug,
  });
  if (rageBonus > 0) {
    damageBonus += rageBonus;
    damageParts.push(`Fúria +${rageBonus}`);
  }

  const itemDamageBonus = input.context.itemDamageBonus ?? 0;
  if (itemDamageBonus !== 0) {
    damageBonus += itemDamageBonus;
    damageParts.push('item');
  }

  const overkillExtraDice =
    input.mode === 'ranged' && !isFirearm && !omitAbilityDamage
      ? overkill.extraDamageDice
      : null;

  return {
    damageBonus,
    damageParts,
    omitAbilityDamage,
    overkillExtraDice,
    overkillAbilityDamageBonus: overkill.abilityDamageBonus,
    rageBonus,
  };
}
