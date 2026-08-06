import {
  formatDamageNote,
  hasProperty,
} from './weapon-attack-predicates';
import type {
  EquippedWeaponPiece,
  WeaponAttack,
  WeaponAttackRole,
} from './weapon-attack.types';
import { applyWeaponCharmToAttack } from '../equipment/weapon-charm';
import type { AbilityPick } from './attack-bonuses';

export function assembleWeaponAttack(input: {
  piece: EquippedWeaponPiece;
  mode: 'melee' | 'ranged';
  ability: AbilityPick;
  proficient: boolean;
  attackBonus: number;
  attackParts: string[];
  damageBonus: number;
  damageParts: string[];
  omitAbilityDamage: boolean;
  overkillExtraDice: string | null;
  overkillAbilityDamageBonus: number;
  rageBonus: number;
  damageDice: string;
  monkMartialArtsDie: string | null;
  role: WeaponAttackRole;
  isFirearm: boolean;
  greatWeaponFighting: boolean;
  masteryActive: boolean;
  masterySlug: string | null;
  masteryName: string | null;
  nickUsesAttackAction: boolean;
  grazeOnMissDamage: number | null;
  attackDisadvantage: boolean;
  critThreshold: number;
  brutalDice: string | null;
  noteExtras: string[];
}): WeaponAttack {
  const modeLabel =
    input.mode === 'ranged' ? 'à distância' : 'corpo a corpo';
  const attackNoteBase = `${modeLabel}: ${input.attackParts.join(' + ')}`;
  const attackNote =
    input.noteExtras.length > 0
      ? `${attackNoteBase} · ${input.noteExtras.join(' · ')}`
      : attackNoteBase;
  const damageNoteParts = input.greatWeaponFighting
    ? [...input.damageParts, 'GWF']
    : input.damageParts;
  const damageNoteDice = input.overkillExtraDice
    ? `${input.damageDice}+${input.overkillExtraDice}`
    : input.damageDice;

  const baseAttack: WeaponAttack = {
    itemSlug: input.piece.itemSlug,
    itemName: input.piece.itemName,
    mode: input.mode,
    attackBonus: input.attackBonus,
    abilitySlug: input.ability.slug,
    proficient: input.proficient,
    damageDice: input.damageDice,
    damageBonus: input.damageBonus,
    damageType: input.piece.damageType,
    attackNote,
    damageNote: formatDamageNote(
      damageNoteDice,
      input.damageBonus,
      damageNoteParts,
    ),
    role: input.role,
    attackDisadvantage: input.attackDisadvantage,
    omitsAbilityDamage:
      input.omitAbilityDamage ||
      (input.isFirearm &&
        input.mode === 'ranged' &&
        input.overkillAbilityDamageBonus === 0),
    greatWeaponFighting: input.greatWeaponFighting,
    masteryActive: input.masteryActive,
    masterySlug: input.masteryActive ? input.masterySlug : null,
    masteryName: input.masteryActive ? input.masteryName : null,
    nickUsesAttackAction: input.nickUsesAttackAction,
    grazeOnMissDamage: input.grazeOnMissDamage,
    isFirearm: input.isFirearm,
    critThreshold: input.critThreshold,
    overkillExtraDice: input.overkillExtraDice,
    reloadCapacity: hasProperty(input.piece, 'reload')
      ? (input.piece.reloadCapacity ?? null)
      : null,
    hasRecoil: hasProperty(input.piece, 'recoil'),
    rageDamageBonus: input.rageBonus,
    brutalStrikeDice: input.brutalDice,
    sneakAttackEligible:
      input.mode === 'ranged' || hasProperty(input.piece, 'finesse'),
    martialArtsDie: input.monkMartialArtsDie,
    attachedCharmSlug: input.piece.attachedCharmSlug ?? null,
    attachedCharmName: input.piece.attachedCharmName ?? null,
  };
  return applyWeaponCharmToAttack(input.piece, baseAttack);
}
