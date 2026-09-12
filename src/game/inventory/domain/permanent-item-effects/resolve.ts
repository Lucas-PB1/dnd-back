import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { STANDARD_ABILITY_SCORE_CAP } from '@game/sheet/domain/validation/feats/epic-boon-feat-options';
import { itemRequiresAttunement } from '../attunement';
import { itemEffectsActive } from '../item-effects-active';
import { parsePermanentItemEffects } from './parse';
import {
  EMPTY_PERMANENT_ITEM_EFFECTS,
  type AbilityScoreCaps,
  type InventoryItemForEffects,
  type PermanentItemEffects,
  type ResolvedPermanentItemEffects,
} from './types';

function mergeAbilityMaps(
  left: PermanentItemEffects['abilityBonuses'],
  right: PermanentItemEffects['abilityBonuses'],
): PermanentItemEffects['abilityBonuses'] {
  const result: PermanentItemEffects['abilityBonuses'] = { ...left };
  for (const [key, amount] of Object.entries(right) as [
    keyof PermanentItemEffects['abilityBonuses'],
    number,
  ][]) {
    result[key] = (result[key] ?? 0) + amount;
  }
  return result;
}

export function applyItemAbilityBonuses(
  scores: AbilityScores,
  abilityBonuses: PermanentItemEffects['abilityBonuses'],
  abilityScoreCaps: AbilityScoreCaps = {},
): AbilityScores {
  const next: AbilityScores = { ...scores };
  for (const [key, amount] of Object.entries(abilityBonuses) as [
    keyof AbilityScores,
    number | undefined,
  ][]) {
    if (!amount) continue;
    const cap = abilityScoreCaps[key] ?? STANDARD_ABILITY_SCORE_CAP;
    next[key] = Math.min(Math.max(cap, scores[key]), scores[key] + amount);
  }
  return next;
}

export function resolveActivePermanentItemEffects(
  items: readonly InventoryItemForEffects[],
): ResolvedPermanentItemEffects {
  let total: PermanentItemEffects = { ...EMPTY_PERMANENT_ITEM_EFFECTS };
  const abilityScoreCaps: AbilityScoreCaps = {};
  const sourceNames: string[] = [];

  for (const item of items) {
    const requiresAttunement = itemRequiresAttunement(item.properties);
    if (
      !itemEffectsActive({
        location: item.location,
        attuned: item.attuned,
        requiresAttunement,
      })
    ) {
      continue;
    }

    const effects = parsePermanentItemEffects(item.properties);
    const hasEffect =
      effects.acBonus !== 0 ||
      effects.attackBonus !== 0 ||
      effects.damageBonus !== 0 ||
      effects.speedBonusMeters !== 0 ||
      effects.hpBonus !== 0 ||
      Object.keys(effects.abilityBonuses).length > 0 ||
      Object.keys(effects.savingThrowBonuses).length > 0;
    if (!hasEffect) continue;

    total = {
      acBonus: total.acBonus + effects.acBonus,
      attackBonus: total.attackBonus + effects.attackBonus,
      damageBonus: total.damageBonus + effects.damageBonus,
      abilityBonuses: mergeAbilityMaps(
        total.abilityBonuses,
        effects.abilityBonuses,
      ),
      savingThrowBonuses: mergeAbilityMaps(
        total.savingThrowBonuses,
        effects.savingThrowBonuses,
      ),
      speedBonusMeters: total.speedBonusMeters + effects.speedBonusMeters,
      hpBonus: total.hpBonus + effects.hpBonus,
      abilityScoreMax: STANDARD_ABILITY_SCORE_CAP,
    };
    for (const key of Object.keys(effects.abilityBonuses) as (keyof AbilityScores)[]) {
      abilityScoreCaps[key] = Math.max(
        abilityScoreCaps[key] ?? STANDARD_ABILITY_SCORE_CAP,
        effects.abilityScoreMax,
      );
    }
    if (item.itemName) sourceNames.push(item.itemName);
  }

  const { abilityScoreMax: _ignored, ...totals } = total;
  return { ...totals, abilityScoreCaps, sourceNames };
}
