import type { AdvantageMode } from '@game/dice/domain/dice';
import {
  hasInitiativePbFromEffects,
  type CatalogEffect,
} from '@game/effects';
import type { AdvantageContribution } from '@game/dice/domain/resolve-net-advantage-mode';
import {
  advantageModeFromManual,
  resolveNetAdvantageMode,
} from '@game/dice/domain/resolve-net-advantage-mode';
import {
  aggregateTraitTakes,
  collectHeritageTraitPicks,
  type HeritageTraitPick,
} from '@game/sheet/domain/heritage/aggregate-trait-takes';
import type { CharacterFeatLike, SpeciesChoiceLike } from './character-check-bonuses/types';
import type { InitiativeRuleRow } from '../../infrastructure/initiative-rule.queries';

export const FOCUSED_INITIATIVE_TRAIT_SLUG = 'focused-initiative';
export const GIANTKIN_STONE_ANCESTRY_KIND = 'giantkinAncestryId';
export const GIANTKIN_STONE_ANCESTRY_SLUG = 'stone';

const ABILITY_MOD_LABEL_PT: Record<string, string> = {
  forca: 'mod. de Força',
  destreza: 'mod. de Destreza',
  constituicao: 'mod. de Constituição',
  inteligencia: 'mod. de Inteligência',
  sabedoria: 'mod. de Sabedoria',
  carisma: 'mod. de Carisma',
};

export type InitiativeRollContext = {
  dexterityModifier: number;
  wisdomModifier: number;
  intelligenceModifier: number;
  proficiencyBonus: number;
  classSlug: string;
  subclassSlug: string | null;
  level: number;
  characterFeats: readonly CharacterFeatLike[];
  featEffects?: readonly CatalogEffect[];
  heritageChoices?: readonly HeritageTraitPick[];
  speciesChoices?: readonly SpeciesChoiceLike[];
  initiativeRules?: readonly InitiativeRuleRow[];
};

export type InitiativeRollOptions = {
  advantage?: AdvantageMode;
  stonePulse?: boolean;
  kasInitiativeBoost?: boolean;
};

export type InitiativeBonusBreakdown = {
  total: number;
  notes: string[];
};

export function focusedInitiativeTakeCount(
  heritageChoices: readonly HeritageTraitPick[] | undefined,
): number {
  return (
    aggregateTraitTakes(collectHeritageTraitPicks(heritageChoices ?? [])).find(
      (row) => row.traitSlug === FOCUSED_INITIATIVE_TRAIT_SLUG,
    )?.takeCount ?? 0
  );
}

export function hasInitiativeProficiency(ctx: {
  characterFeats: readonly CharacterFeatLike[];
  featEffects?: readonly CatalogEffect[];
  heritageChoices?: readonly HeritageTraitPick[];
}): boolean {
  const featSlugs = ctx.characterFeats.map((feat) => feat.featSlug);
  return (
    hasInitiativePbFromEffects(ctx.featEffects ?? [], featSlugs) ||
    focusedInitiativeTakeCount(ctx.heritageChoices) >= 1
  );
}

export function hasGiantkinStoneAncestry(
  speciesChoices: readonly SpeciesChoiceLike[] | undefined,
): boolean {
  return (speciesChoices ?? []).some(
    (choice) =>
      choice.choiceKind === GIANTKIN_STONE_ANCESTRY_KIND &&
      choice.choiceSlug === GIANTKIN_STONE_ANCESTRY_SLUG,
  );
}

function abilityModifierForSlug(
  ctx: InitiativeRollContext,
  abilitySlug: string,
): number {
  switch (abilitySlug) {
    case 'sabedoria':
      return ctx.wisdomModifier;
    case 'inteligencia':
      return ctx.intelligenceModifier;
    case 'destreza':
      return ctx.dexterityModifier;
    default:
      return 0;
  }
}

function ruleMatchesOwner(
  rule: InitiativeRuleRow,
  ctx: InitiativeRollContext,
): boolean {
  if (rule.ownerKind === 'class') {
    return rule.ownerSlug === ctx.classSlug;
  }
  return rule.ownerSlug === ctx.subclassSlug;
}

export function resolveInitiativeBonus(
  ctx: InitiativeRollContext,
): InitiativeBonusBreakdown {
  let total = ctx.dexterityModifier;
  const notes: string[] = [];

  if (hasInitiativeProficiency(ctx)) {
    total += ctx.proficiencyBonus;
    if (
      hasInitiativePbFromEffects(
        ctx.featEffects ?? [],
        ctx.characterFeats.map((feat) => feat.featSlug),
      )
    ) {
      notes.push('Alerta: +PB na Iniciativa');
    }
    if (focusedInitiativeTakeCount(ctx.heritageChoices) >= 1) {
      notes.push('Iniciativa Concentrada: +PB na Iniciativa');
    }
  }

  for (const rule of ctx.initiativeRules ?? []) {
    if (rule.ruleKind !== 'ability_bonus') continue;
    if (!ruleMatchesOwner(rule, ctx)) continue;
    if (ctx.level < rule.unlockLevel) continue;
    if (!rule.abilitySlug) continue;
    const mod = abilityModifierForSlug(ctx, rule.abilitySlug);
    total += mod;
    const abilityLabel =
      ABILITY_MOD_LABEL_PT[rule.abilitySlug] ?? `mod. de ${rule.abilitySlug}`;
    notes.push(`${rule.label}: +${mod} (${abilityLabel})`);
  }

  return { total, notes };
}

export function resolveInitiativeAdvantageContributions(
  ctx: InitiativeRollContext,
  options: InitiativeRollOptions,
): { mode: AdvantageMode; notes: string[] } {
  const contributions: AdvantageContribution[] = [
    ...advantageModeFromManual(options.advantage),
  ];
  const notes: string[] = [];

  for (const rule of ctx.initiativeRules ?? []) {
    if (rule.ruleKind !== 'advantage') continue;
    if (!ruleMatchesOwner(rule, ctx)) continue;
    if (ctx.level < rule.unlockLevel) continue;
    contributions.push('advantage');
    notes.push(rule.label);
  }

  if (
    options.stonePulse &&
    hasGiantkinStoneAncestry(ctx.speciesChoices)
  ) {
    contributions.push('advantage');
    notes.push('Pulso de Pedra: vantagem na Iniciativa (solo sólido)');
  }

  return { mode: resolveNetAdvantageMode(contributions), notes };
}

export function applyFocusedInitiativeFloor(
  kept: readonly number[],
  heritageChoices: readonly HeritageTraitPick[] | undefined,
): { kept: number[]; note?: string } {
  if (focusedInitiativeTakeCount(heritageChoices) < 2) {
    return { kept: [...kept] };
  }
  const adjusted = kept.map((face) => (face <= 9 ? 10 : face));
  const changed = adjusted.some((face, index) => face !== kept[index]);
  return {
    kept: adjusted,
    note: changed
      ? 'Iniciativa Concentrada (2×): d20 9 ou menos conta como 10'
      : undefined,
  };
}
