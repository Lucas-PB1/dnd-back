import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import {
  computeWeaponAttacks,
  type EquippedWeaponPiece,
} from '../weapon-attack';
import type { WeaponAttack, WeaponAttackContext } from '../weapon-attack.types';
import { testScores } from './fixtures';

export type AttackPick = {
  itemSlug?: string;
  mode?: WeaponAttack['mode'];
  role?: WeaponAttack['role'];
};

export function pickAttack(
  attacks: WeaponAttack[],
  pick: AttackPick,
): WeaponAttack {
  const attack = attacks.find(
    (row) =>
      (pick.itemSlug == null || row.itemSlug === pick.itemSlug) &&
      (pick.mode == null || row.mode === pick.mode) &&
      (pick.role == null || row.role === pick.role),
  );
  if (!attack) {
    throw new Error(`Attack not found: ${JSON.stringify(pick)}`);
  }
  return attack;
}

export function runAttacks(
  pieces: readonly EquippedWeaponPiece[],
  ctx: WeaponAttackContext,
  scores: Partial<AbilityScores> = {},
): WeaponAttack[] {
  return computeWeaponAttacks(testScores(scores), [...pieces], ctx);
}

export function oneAttack(
  pieces: readonly EquippedWeaponPiece[],
  ctx: WeaponAttackContext,
  pick?: AttackPick,
  scores: Partial<AbilityScores> = {},
): WeaponAttack {
  const attacks = runAttacks(pieces, ctx, scores);
  return pick ? pickAttack(attacks, pick) : attacks[0];
}

export type AttackExpectation = {
  attackBonus?: number;
  damageBonus?: number;
  damageDice?: string;
  abilitySlug?: WeaponAttack['abilitySlug'];
  mode?: WeaponAttack['mode'];
  proficient?: boolean;
  role?: WeaponAttack['role'];
  omitsAbilityDamage?: boolean;
  greatWeaponFighting?: boolean;
  grazeOnMissDamage?: number;
  martialArtsDie?: string | null;
  attackDisadvantage?: boolean;
  attackNoteContains?: string;
  damageNoteContains?: string;
  nickUsesAttackAction?: boolean;
  matchObject?: Partial<WeaponAttack>;
};

export type WeaponAttackCase = {
  label: string;
  pieces: EquippedWeaponPiece[];
  ctx: WeaponAttackContext;
  scores?: Partial<AbilityScores>;
  pick?: AttackPick;
  expect: AttackExpectation;
};

export function expectWeaponAttack(
  pieces: readonly EquippedWeaponPiece[],
  ctx: WeaponAttackContext,
  pick: AttackPick | undefined,
  scores: Partial<AbilityScores>,
  expected: AttackExpectation,
): WeaponAttack {
  const attack = oneAttack(pieces, ctx, pick, scores);
  if (expected.matchObject) {
    expect(attack).toMatchObject(expected.matchObject);
  }
  if (expected.attackBonus !== undefined) {
    expect(attack.attackBonus).toBe(expected.attackBonus);
  }
  if (expected.damageBonus !== undefined) {
    expect(attack.damageBonus).toBe(expected.damageBonus);
  }
  if (expected.damageDice !== undefined) {
    expect(attack.damageDice).toBe(expected.damageDice);
  }
  if (expected.abilitySlug !== undefined) {
    expect(attack.abilitySlug).toBe(expected.abilitySlug);
  }
  if (expected.mode !== undefined) {
    expect(attack.mode).toBe(expected.mode);
  }
  if (expected.proficient !== undefined) {
    expect(attack.proficient).toBe(expected.proficient);
  }
  if (expected.role !== undefined) {
    expect(attack.role).toBe(expected.role);
  }
  if (expected.omitsAbilityDamage !== undefined) {
    expect(attack.omitsAbilityDamage).toBe(expected.omitsAbilityDamage);
  }
  if (expected.greatWeaponFighting !== undefined) {
    expect(attack.greatWeaponFighting).toBe(expected.greatWeaponFighting);
  }
  if (expected.grazeOnMissDamage !== undefined) {
    expect(attack.grazeOnMissDamage).toBe(expected.grazeOnMissDamage);
  }
  if (expected.martialArtsDie !== undefined) {
    expect(attack.martialArtsDie).toBe(expected.martialArtsDie);
  }
  if (expected.attackDisadvantage !== undefined) {
    expect(attack.attackDisadvantage).toBe(expected.attackDisadvantage);
  }
  if (expected.attackNoteContains) {
    expect(attack.attackNote).toContain(expected.attackNoteContains);
  }
  if (expected.damageNoteContains) {
    expect(attack.damageNote).toContain(expected.damageNoteContains);
  }
  if (expected.nickUsesAttackAction !== undefined) {
    expect(attack.nickUsesAttackAction).toBe(expected.nickUsesAttackAction);
  }
  return attack;
}

export function runWeaponAttackCase({
  label: _label,
  pieces,
  ctx,
  scores = {},
  pick,
  expect: expected,
}: WeaponAttackCase): void {
  expectWeaponAttack(pieces, ctx, pick, scores, expected);
}

export function assertSoulknifePsychicBlades(attacks: WeaponAttack[]): void {
  const mainMelee = pickAttack(attacks, {
    itemSlug: 'psychic-blade',
    mode: 'melee',
  });
  const mainRanged = pickAttack(attacks, {
    itemSlug: 'psychic-blade',
    mode: 'ranged',
  });
  const bonus = pickAttack(attacks, {
    itemSlug: 'psychic-blade-bonus',
    mode: 'melee',
  });

  expect(mainMelee).toMatchObject({
    proficient: true,
    abilitySlug: 'destreza',
    damageDice: '1d6',
    damageType: 'Psíquico',
    sneakAttackEligible: true,
    masterySlug: 'vex',
    masteryActive: true,
  });
  expect(mainMelee.attackBonus).toBe(7);
  expect(mainRanged.sneakAttackEligible).toBe(true);
  expect(bonus).toMatchObject({
    damageDice: '1d4',
    role: 'light_bonus',
    sneakAttackEligible: true,
    omitsAbilityDamage: true,
  });
  expect(bonus.attackNote).toContain('segunda lâmina');
}
