import type { AdvantageMode } from '@game/dice/domain/dice';
import type { AdvantageContribution } from '@game/dice/domain/resolve-net-advantage-mode';
import {
  advantageModeFromManual,
  resolveNetAdvantageMode,
} from '@game/dice/domain/resolve-net-advantage-mode';
import { isRangerClass } from '@game/combat/domain/ranger';
import {
  aggregateTraitTakes,
  collectHeritageTraitPicks,
  type HeritageTraitPick,
} from '@game/sheet/domain/heritage/aggregate-trait-takes';
import type { CharacterFeatLike, SpeciesChoiceLike } from './character-check-bonuses/types';
import { hasAlertFeat } from './character-check-bonuses/compute/saves-and-initiative';

export const FOCUSED_INITIATIVE_TRAIT_SLUG = 'focused-initiative';
export const GIANTKIN_STONE_ANCESTRY_KIND = 'giantkinAncestryId';
export const GIANTKIN_STONE_ANCESTRY_SLUG = 'stone';

export type InitiativeRollContext = {
  dexterityModifier: number;
  wisdomModifier: number;
  intelligenceModifier: number;
  proficiencyBonus: number;
  classSlug: string;
  subclassSlug: string | null;
  level: number;
  characterFeats: readonly CharacterFeatLike[];
  heritageChoices?: readonly HeritageTraitPick[];
  speciesChoices?: readonly SpeciesChoiceLike[];
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
  heritageChoices?: readonly HeritageTraitPick[];
}): boolean {
  return (
    hasAlertFeat(ctx.characterFeats) ||
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

export function resolveInitiativeBonus(
  ctx: InitiativeRollContext,
): InitiativeBonusBreakdown {
  let total = ctx.dexterityModifier;
  const notes: string[] = [];

  if (hasInitiativeProficiency(ctx)) {
    total += ctx.proficiencyBonus;
    if (hasAlertFeat(ctx.characterFeats)) {
      notes.push('Alerta: +PB na Iniciativa');
    }
    if (focusedInitiativeTakeCount(ctx.heritageChoices) >= 1) {
      notes.push('Iniciativa Concentrada: +PB na Iniciativa');
    }
  }

  if (
    isRangerClass(ctx.classSlug) &&
    ctx.subclassSlug === 'gloom-stalker' &&
    ctx.level >= 3
  ) {
    total += ctx.wisdomModifier;
    notes.push(
      `Emboscador das Sombras: +${ctx.wisdomModifier} (mod. de Sabedoria)`,
    );
  }

  if (ctx.subclassSlug === 'trapper-guild' && ctx.level >= 7) {
    total += ctx.intelligenceModifier;
    notes.push(
      `Vantagem do Emboscador: +${ctx.intelligenceModifier} (mod. de Inteligência)`,
    );
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

  if (ctx.classSlug === 'barbarian' && ctx.level >= 7) {
    contributions.push('advantage');
    notes.push('Instintos Primitivos: vantagem na Iniciativa');
  }
  if (ctx.subclassSlug === 'champion' && ctx.level >= 3) {
    contributions.push('advantage');
    notes.push('Atleta Extraordinário: vantagem na Iniciativa');
  }
  if (ctx.subclassSlug === 'assassin' && ctx.level >= 3) {
    contributions.push('advantage');
    notes.push('Assassinar: vantagem na Iniciativa');
  }
  if (ctx.subclassSlug === 'nightwatcher' && ctx.level >= 3) {
    contributions.push('advantage');
    notes.push('Sempre Vigilante: vantagem na Iniciativa');
  }
  if (ctx.subclassSlug === 'highway-rider' && ctx.level >= 3) {
    contributions.push('advantage');
    notes.push('Gatilho Rápido: vantagem na Iniciativa');
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

/** Compat: bônus fixo exibido na ficha (sem d10 situacional). */
export function initiativeBonus(
  dexterityModifier: number,
  proficiencyBonus: number,
  characterFeats: readonly CharacterFeatLike[] | undefined,
  extra?: Omit<
    InitiativeRollContext,
    'dexterityModifier' | 'proficiencyBonus' | 'characterFeats'
  >,
): number {
  return resolveInitiativeBonus({
    dexterityModifier,
    proficiencyBonus,
    characterFeats: characterFeats ?? [],
    wisdomModifier: extra?.wisdomModifier ?? 0,
    intelligenceModifier: extra?.intelligenceModifier ?? 0,
    classSlug: extra?.classSlug ?? '',
    subclassSlug: extra?.subclassSlug ?? null,
    level: extra?.level ?? 0,
    heritageChoices: extra?.heritageChoices,
    speciesChoices: extra?.speciesChoices,
  }).total;
}
