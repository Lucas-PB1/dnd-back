/**
 * Monta StrikeOption[] a partir de pacotes phb_effect (requires_option_value = slug).
 */

import type { CatalogEffect } from '@game/effects/domain/catalog-effect';
import {
  mapSaveAbilityToSheet,
  type StrikeOption,
} from './strike-option';

/** Chave sintética de agrupamento (não é bloodStrike1..7 da ficha). */
export const STRIKE_OPTION_REQUIRES_KEY = 'strikeOption';

const SECONDARY_LABEL = 'secondary';

function isStrikePackage(effect: CatalogEffect): boolean {
  return (
    effect.requiresOptionKey === STRIKE_OPTION_REQUIRES_KEY &&
    Boolean(effect.requiresOptionValue)
  );
}

function pickDamageType(effects: readonly CatalogEffect[]): string | null {
  const preferred = [
    ...effects.filter(
      (e) =>
        e.kind === 'extra_damage_dice' &&
        e.label?.toLowerCase() !== SECONDARY_LABEL,
    ),
    ...effects.filter(
      (e) =>
        e.kind === 'extra_damage_dice' &&
        e.label?.toLowerCase() === SECONDARY_LABEL,
    ),
    ...effects.filter((e) => e.kind === 'self_damage'),
  ];
  for (const effect of preferred) {
    if (effect.dice?.damageTypeSlug) return effect.dice.damageTypeSlug;
  }
  return null;
}

function mapExtraDice(effect: CatalogEffect | undefined): {
  extraDice: string;
  extraDiceL18: string;
} {
  if (!effect?.dice) return { extraDice: '0', extraDiceL18: '0' };
  const { die, dieAtLevel, atLevel } = effect.dice;
  if (atLevel != null && !dieAtLevel) {
    return { extraDice: '0', extraDiceL18: die };
  }
  return {
    extraDice: die,
    extraDiceL18: dieAtLevel ?? die,
  };
}

function mapSecondaryDice(effect: CatalogEffect | undefined): {
  secondaryDice: string | null;
  secondaryDiceL18: string | null;
} {
  if (!effect?.dice) return { secondaryDice: null, secondaryDiceL18: null };
  const { die, dieAtLevel, atLevel } = effect.dice;
  if (atLevel != null && !dieAtLevel) {
    return { secondaryDice: null, secondaryDiceL18: die };
  }
  return {
    secondaryDice: die,
    secondaryDiceL18: dieAtLevel ?? die,
  };
}

function buildOneStrikeOption(
  slug: string,
  effects: readonly CatalogEffect[],
  optionLabels: ReadonlyMap<string, string> | undefined,
): StrikeOption {
  const selfCost = effects.find(
    (e) => e.kind === 'self_damage' && e.trigger === 'on_option_use',
  );
  const extraEffects = effects.filter((e) => e.kind === 'extra_damage_dice');
  const secondary = extraEffects.find(
    (e) => e.label?.toLowerCase() === SECONDARY_LABEL,
  );
  const primaryExtra = extraEffects.find(
    (e) => e.label?.toLowerCase() !== SECONDARY_LABEL,
  );
  const { extraDice, extraDiceL18 } = mapExtraDice(primaryExtra);
  const { secondaryDice, secondaryDiceL18 } = mapSecondaryDice(secondary);

  const saveEffect = effects.find((e) => e.kind === 'feature_save');
  const onHitCondition = effects.find(
    (e) => e.kind === 'apply_condition' && e.trigger === 'on_hit',
  );
  const onFailCondition = effects.find(
    (e) => e.kind === 'apply_condition' && e.trigger === 'on_save_fail',
  );
  const arena = effects.find((e) => e.kind === 'add_arena_effect');

  const name =
    optionLabels?.get(slug) ??
    selfCost?.label ??
    effects.find((e) => e.label)?.label ??
    slug;

  return {
    slug,
    name,
    subclassSlug: selfCost?.ownerSlug ?? effects[0]?.ownerSlug ?? undefined,
    resourceSlug: selfCost?.resourceSlug ?? null,
    tableAction: selfCost?.actionSlug ?? null,
    costDice: selfCost?.dice?.die ?? null,
    extraDice,
    extraDiceL18,
    damageType: pickDamageType(effects),
    saveAbility: mapSaveAbilityToSheet(saveEffect?.save?.saveAbility),
    onFailCondition: onFailCondition?.condition?.conditionSlug ?? null,
    onFailPendingKind: onFailCondition?.condition?.pendingKind ?? null,
    onHitPendingKind: onHitCondition?.condition?.pendingKind ?? null,
    replacesAttackWithSave: effects.some(
      (e) => e.kind === 'replace_attack_with_save',
    ),
    secondaryDice,
    secondaryDiceL18,
    ignoreTargetArmor: effects.some((e) => e.kind === 'ignore_target_armor'),
    ignoreDamageResistance: effects.some(
      (e) => e.kind === 'ignore_damage_resistance',
    ),
    addsArenaEffect: Boolean(arena),
    arenaEffectSlug: arena?.note?.note ?? null,
    noteOnly: effects.some(
      (e) => e.kind === 'combat_note' || e.kind === 'table_note',
    ),
  };
}

/** Agrupa effects de strike packages em StrikeOption[]. */
export function buildStrikeOptionsFromEffects(input: {
  effects: readonly CatalogEffect[];
  optionLabels?: ReadonlyMap<string, string>;
}): StrikeOption[] {
  const bySlug = new Map<string, CatalogEffect[]>();
  for (const effect of input.effects) {
    if (!isStrikePackage(effect)) continue;
    const slug = effect.requiresOptionValue!;
    const list = bySlug.get(slug) ?? [];
    list.push(effect);
    bySlug.set(slug, list);
  }

  return [...bySlug.entries()]
    .map(([slug, packageEffects]) =>
      buildOneStrikeOption(slug, packageEffects, input.optionLabels),
    )
    .sort((a, b) => a.slug.localeCompare(b.slug));
}
