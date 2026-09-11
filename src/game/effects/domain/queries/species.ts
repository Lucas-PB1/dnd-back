import type { CatalogEffect, EffectCastEconomySatellite } from '../catalog-effect';
import { choiceKindForOptionKey } from '@catalog/game-port';
import type { EffectChoiceRef } from './option-gates';

/** Feat slugs granted by `grant_feat` (ex.: Humano Versátil). */
export function featSlugsFromEffects(
  effects: readonly CatalogEffect[],
  choices: readonly EffectChoiceRef[],
): string[] {
  const slugs: string[] = [];
  for (const effect of effects) {
    if (effect.kind !== 'grant_feat' || !effect.feat) continue;
    const choice = choices.find(
      (row) => row.choiceKind === effect.feat!.optionKey,
    );
    const slug = choice?.choiceSlug?.trim();
    if (slug) slugs.push(slug);
  }
  return [...new Set(slugs)];
}

/** Idiomas escolha concedidos por `grant_language` com option_key. */
export function languageChoiceCountFromEffects(
  effects: readonly CatalogEffect[],
): number {
  let total = 0;
  for (const effect of effects) {
    if (effect.kind !== 'grant_language' || !effect.language) continue;
    if (!effect.language.optionKey) continue;
    total += effect.language.choiceCount;
  }
  return total;
}

export function hasRerollD20OnNat1(effects: readonly CatalogEffect[]): boolean {
  return effects.some((effect) => effect.kind === 'reroll_d20_on_nat1');
}

export function reachBonusFtFromEffects(
  effects: readonly CatalogEffect[],
): { bonusFt: number; excludePropertySlugs: string[] } | null {
  let best: { bonusFt: number; excludePropertySlugs: string[] } | null = null;
  for (const effect of effects) {
    if (effect.kind !== 'reach_bonus' || !effect.reach) continue;
    const row = {
      bonusFt: effect.reach.bonusFt,
      excludePropertySlugs: effect.reach.excludePropertySlugs ?? [],
    };
    if (!best || row.bonusFt > best.bonusFt) best = row;
  }
  return best;
}

export function restQuirkFromEffects(
  effects: readonly CatalogEffect[],
): NonNullable<CatalogEffect['restQuirk']> | null {
  for (const effect of effects) {
    if (effect.kind === 'rest_quirk' && effect.restQuirk) {
      return effect.restQuirk;
    }
  }
  return null;
}

export function sensesFromEffects(
  effects: readonly CatalogEffect[],
): NonNullable<CatalogEffect['sense']>[] {
  return effects
    .filter((effect) => effect.kind === 'grant_sense' && effect.sense)
    .map((effect) => effect.sense!);
}

export function damageResistancesFromEffects(
  effects: readonly CatalogEffect[],
  choices: readonly EffectChoiceRef[],
): string[] {
  const types: string[] = [];
  for (const effect of effects) {
    if (effect.kind !== 'damage_resistance' || !effect.damageType) continue;
    if (effect.damageType.damageTypeSlug) {
      types.push(effect.damageType.damageTypeSlug);
      continue;
    }
    // option_key → type resolved by caller map if needed; skip unresolved
    if (effect.damageType.optionKey) {
      const choice = choices.find(
        (row) =>
          row.choiceKind === effect.damageType!.optionKey ||
          row.choiceKind.includes('ancestry') ||
          row.choiceKind.includes('legacy'),
      );
      if (choice?.choiceSlug) {
        types.push(`option:${effect.damageType.optionKey}:${choice.choiceSlug}`);
      }
    }
  }
  return [...new Set(types)];
}

export function speedSetFeetFromEffects(
  effects: readonly CatalogEffect[],
): number | null {
  for (const effect of effects) {
    if (effect.kind !== 'speed_set' || !effect.numeric) continue;
    if (effect.numeric.amountFormula === 'fixed' && effect.numeric.flat != null) {
      return effect.numeric.flat;
    }
  }
  return null;
}

export function combatNotesFromOwnerEffects(
  effects: readonly CatalogEffect[],
): string[] {
  const notes: string[] = [];
  for (const effect of effects) {
    const note = effect.note?.note?.trim();
    if (!note) continue;
    notes.push(note);
  }
  return notes;
}

const NOTE_KINDS = new Set<CatalogEffect['kind']>([
  'combat_note',
  'grant_sense',
  'damage_resistance',
  'save_advantage',
  'check_advantage',
  'combat_mod',
  'grant_inspiration',
  'rest_quirk',
  'speed_set',
  'carry_as_larger_size',
  'reach_bonus',
  'reroll_d20_on_nat1',
  'survive_at_zero',
  'grant_swim_speed',
  'grant_climb_speed',
  'grant_fly_speed',
  'environmental_immunity',
  'ac_bonus',
  'damage_die_override',
  'damage_resistance_reaction',
  'damage_bonus',
]);

const DAMAGE_TYPE_PT: Record<string, string> = {
  fire: 'Ígneo',
  cold: 'Gélido',
  lightning: 'Elétrico',
  acid: 'Ácido',
  poison: 'Venenoso',
  necrotic: 'Necrótico',
  radiant: 'Radiante',
  thunder: 'Trovejante',
};

const DRAGON_ANCESTRY_DAMAGE: Record<string, string> = {
  blue: 'lightning',
  black: 'acid',
  white: 'cold',
  gold: 'fire',
  bronze: 'lightning',
  silver: 'cold',
  copper: 'acid',
  green: 'poison',
  brass: 'fire',
  red: 'fire',
};

const TIEFLING_LEGACY_DAMAGE: Record<string, string> = {
  abyssal: 'poison',
  chthonic: 'necrotic',
  infernal: 'fire',
};

/**
 * Passivas de espécie a partir do catálogo de efeitos (SSOT).
 * Prefer note satélite; senão label; resistência por option resolve o tipo.
 */
export function speciesPassiveNotesFromEffects(
  effects: readonly CatalogEffect[],
  choices: readonly EffectChoiceRef[] = [],
): string[] {
  const notes: string[] = [];
  const seen = new Set<string>();
  for (const effect of effects) {
    if (!NOTE_KINDS.has(effect.kind)) continue;
    const text = formatSpeciesPassiveNote(effect, choices);
    if (!text || seen.has(text)) continue;
    seen.add(text);
    notes.push(text);
  }
  return notes;
}

function formatSpeciesPassiveNote(
  effect: CatalogEffect,
  choices: readonly EffectChoiceRef[],
): string | null {
  const fromNote = effect.note?.note?.trim();
  if (fromNote) return fromNote;

  if (effect.kind === 'damage_resistance') {
    const enriched = formatResistanceNote(effect, choices);
    if (enriched) return enriched;
  }

  const label = effect.label?.trim();
  return label || null;
}

function formatResistanceNote(
  effect: CatalogEffect,
  choices: readonly EffectChoiceRef[],
): string | null {
  const fixed = effect.damageType?.damageTypeSlug;
  if (fixed) {
    const pt = DAMAGE_TYPE_PT[fixed] ?? fixed;
    return effect.label?.trim() || `Resistência a dano ${pt}.`;
  }
  const optionKey = effect.damageType?.optionKey;
  if (!optionKey) return effect.label?.trim() || null;

  const choiceKind =
    optionKey === 'dragonAncestryId'
      ? 'dragon_ancestry'
      : optionKey === 'infernalLegacyId'
        ? 'infernal_legacy'
        : optionKey;
  const value = choices.find((c) => c.choiceKind === choiceKind)?.choiceSlug;
  if (!value) return effect.label?.trim() || null;

  const typeSlug =
    optionKey === 'dragonAncestryId'
      ? DRAGON_ANCESTRY_DAMAGE[value]
      : optionKey === 'infernalLegacyId'
        ? TIEFLING_LEGACY_DAMAGE[value]
        : undefined;
  if (!typeSlug) return effect.label?.trim() || null;
  const pt = DAMAGE_TYPE_PT[typeSlug] ?? typeSlug;
  const suffix =
    optionKey === 'dragonAncestryId'
      ? ' (Herança Dracônica)'
      : ' (Legado Ínfero)';
  return `Resistência a dano ${pt}${suffix}.`;
}

/** Magias concedidas por `grant_spell` de espécie (já gated). */
export function speciesGrantedSpellSlugsFromEffects(
  effects: readonly CatalogEffect[],
  level: number,
  choices: readonly EffectChoiceRef[] = [],
): string[] {
  const choiceSlugs: string[] = [];
  let replaceFixedLevel1 = false;

  for (const effect of effects) {
    if (effect.kind !== 'grant_spell' && effect.kind !== 'grant_spell_by_level') {
      continue;
    }
    if (effect.unlockLevel > level) continue;
    const optionKey = effect.spell?.optionKey?.trim();
    if (!optionKey) continue;
    const choiceKind = choiceKindForOptionKey(optionKey);
    const slug = choices
      .find((row) => row.choiceKind === choiceKind)
      ?.choiceSlug?.trim();
    if (!slug) continue;
    choiceSlugs.push(slug);
    if (optionKey === 'high_elf_cantrip') replaceFixedLevel1 = true;
  }

  const fixedSlugs: string[] = [];
  for (const effect of effects) {
    if (effect.kind !== 'grant_spell' && effect.kind !== 'grant_spell_by_level') {
      continue;
    }
    if (effect.unlockLevel > level) continue;
    if (effect.spell?.optionKey?.trim()) continue;
    if (replaceFixedLevel1 && effect.unlockLevel === 1) continue;
    const slug = effect.spell?.spellSlug?.trim();
    if (slug) fixedSlugs.push(slug);
  }

  return [...new Set([...fixedSlugs, ...choiceSlugs])];
}

export function resolveSpeciesSpellCastEconomyFromEffects(input: {
  effects: readonly CatalogEffect[];
  spellSlug: string;
  choices?: readonly EffectChoiceRef[];
}): EffectCastEconomySatellite | null {
  for (const effect of input.effects) {
    if (effect.kind !== 'grant_spell' && effect.kind !== 'free_cast') continue;
    if (!effect.castEconomy) continue;

    const optionKey = effect.spell?.optionKey?.trim();
    if (optionKey) {
      const choiceKind = choiceKindForOptionKey(optionKey);
      const chosen = input.choices?.find(
        (row) => row.choiceKind === choiceKind,
      )?.choiceSlug;
      if (chosen === input.spellSlug) return effect.castEconomy;
      continue;
    }

    if (effect.spell?.spellSlug === input.spellSlug) {
      return effect.castEconomy;
    }
  }
  return null;
}
