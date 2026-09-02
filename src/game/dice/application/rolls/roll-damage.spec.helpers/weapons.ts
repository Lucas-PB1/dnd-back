import type { AttackInput } from './mocks';

export const WEAPONS = {
  greataxe: (): AttackInput => ({
    itemName: 'Greataxe',
    damageDice: '1d12',
    damageBonus: 3,
    abilitySlug: 'forca',
  }),
  greataxeGwf: (): AttackInput => ({
    itemName: 'Greataxe',
    damageDice: '1d12',
    damageBonus: 4,
    greatWeaponFighting: true,
    brutalStrikeDice: '1d10',
    abilitySlug: 'forca',
  }),
  greataxeGraze: (): AttackInput => ({
    itemName: 'Greataxe',
    grazeOnMissDamage: 3,
    damageDice: '1d12',
    damageBonus: 3,
    abilitySlug: 'forca',
  }),
  longsword: (): AttackInput => ({
    itemName: 'Longsword',
    damageDice: '1d8',
    damageBonus: 3,
    abilitySlug: 'forca',
  }),
  longswordIneligibleSneak: (): AttackInput => ({
    itemName: 'Longsword',
    sneakAttackEligible: false,
    abilitySlug: 'forca',
  }),
  longswordNoGraze: (): AttackInput => ({
    itemName: 'Longsword',
    grazeOnMissDamage: null,
    rageDamageBonus: 0,
  }),
  rapierSneak: (): AttackInput => ({
    itemName: 'Rapier',
    damageDice: '1d8',
    damageBonus: 4,
    abilitySlug: 'destreza',
    sneakAttackEligible: true,
  }),
  rapierAssassin: (): AttackInput => ({
    itemName: 'Rapier',
    damageDice: '1d8',
    damageBonus: 5,
    abilitySlug: 'destreza',
    sneakAttackEligible: true,
  }),
  rapierQuickStrike: (): AttackInput => ({
    itemName: 'Rapier',
    damageDice: '1d8',
    damageBonus: 3,
    abilitySlug: 'destreza',
    quickStrikeDice: '2d4',
  }),
  rapierNoQuickStrike: (): AttackInput => ({
    itemName: 'Rapier',
    damageBonus: 3,
    quickStrikeDice: null,
  }),
  longbow: (): AttackInput => ({
    itemName: 'Longbow',
    damageDice: '1d8',
    damageBonus: 3,
    abilitySlug: 'destreza',
  }),
  mace: (): AttackInput => ({
    itemName: 'Mace',
    damageDice: '1d6',
    damageBonus: 3,
    abilitySlug: 'forca',
  }),
};
