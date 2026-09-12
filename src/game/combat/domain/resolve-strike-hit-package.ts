

import { rollExpression, type Rng } from '@game/dice/domain/dice';
import {
  strikeExtraDiceExpression,
  strikeSecondaryDiceExpression,
  type StrikeOption,
  type StrikeSaveAbility,
} from './strike-option';

export type StrikeHitPackage = {
  optionSlug: string;
  label: string;
  extraDamage: number;
  extraExpression: string | null;
  damageType: string;
  saveAbility: StrikeSaveAbility | null;
  onFailCondition: string | null;
  onFailPendingKind: string | null;
  onHitPendingKind: string | null;
  addsArenaEffect: boolean;
  arenaEffectSlug: string | null;
  noteOnly: boolean;
  ignoreTargetArmor: boolean;
  ignoreDamageResistance: boolean;
  replacesAttackWithSave: boolean;
};

export function resolveStrikeHitPackage(input: {
  option: StrikeOption;
  level: number;
  rng?: Rng;
}): StrikeHitPackage {
  const { option } = input;
  const rng = input.rng ?? Math.random;
  const extraExpr = strikeExtraDiceExpression(option, input.level);
  let extraDamage = 0;
  let extraExpression: string | null = null;
  if (extraExpr) {
    const rolled = rollExpression(extraExpr, rng);
    extraDamage = rolled.total;
    extraExpression = `${rolled.expression}=${rolled.total}`;
  }

  return {
    optionSlug: option.slug,
    label: option.name,
    extraDamage,
    extraExpression,
    damageType: option.damageType ?? 'bludgeoning',
    saveAbility: option.saveAbility,
    onFailCondition: option.onFailCondition,
    onFailPendingKind: option.onFailPendingKind,
    onHitPendingKind: option.onHitPendingKind,
    addsArenaEffect: option.addsArenaEffect,
    arenaEffectSlug: option.arenaEffectSlug,
    noteOnly: option.noteOnly,
    ignoreTargetArmor: option.ignoreTargetArmor,
    ignoreDamageResistance: option.ignoreDamageResistance,
    replacesAttackWithSave: option.replacesAttackWithSave,
  };
}

export function rollStrikeSecondaryDice(input: {
  option: StrikeOption;
  level: number;
  rng?: Rng;
}): { total: number; expression: string } {
  const expr = strikeSecondaryDiceExpression(input.option, input.level);
  if (!expr) return { total: 0, expression: '0' };
  const rolled = rollExpression(expr, input.rng ?? Math.random);
  return {
    total: rolled.total,
    expression: `${rolled.expression}=${rolled.total}`,
  };
}

export function halfDamage(total: number): number {
  return Math.floor(Math.max(0, total) / 2);
}

export function unarmoredDexArmorClass(dexterityModifier: number): number {
  return 10 + dexterityModifier;
}
