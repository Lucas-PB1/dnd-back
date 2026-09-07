import type {
  FeatOptionDto,
  SpeciesChoiceDto,
} from '@game/sheet/dto/character-sheet.dto';
import type { CatalogEffect } from '@game/effects';
import {
  resolveCastMaxUses,
  resolveFeatCastEconomyFromEffects,
  resolveFeatFreeCastMaxUsesFromEffects,
  resolveSpeciesSpellCastEconomyFromEffects,
} from '@game/effects';
import type {
  CharacterSpellSource,
  FeatGrantedSpellRow,
} from './granted-spells/types';
import { resolveFeatSlugForGrantedSpell } from './resolve-granted-spellcasting-ability';

export type CastEconomy = 'at_will' | 'once_per_long_rest' | 'slot_only';

function featOptionKeyForSpell(
  spellSlug: string,
  featOptions: readonly FeatOptionDto[] | undefined,
  featFixedSpells: readonly FeatGrantedSpellRow[],
): string | null {
  for (const option of featOptions ?? []) {
    if (option.valueId === spellSlug) {
      return option.optionKey;
    }
  }
  const feat = resolveFeatSlugForGrantedSpell(
    spellSlug,
    featOptions,
    featFixedSpells,
  );
  if (!feat) return null;
  return 'bonusSpell';
}

function featSlugForSpell(
  spellSlug: string,
  featOptions: readonly FeatOptionDto[] | undefined,
  featFixedSpells: readonly FeatGrantedSpellRow[],
): string | null {
  for (const option of featOptions ?? []) {
    if (option.valueId === spellSlug) return option.featSlug;
  }
  return (
    resolveFeatSlugForGrantedSpell(spellSlug, featOptions, featFixedSpells)
      ?.featSlug ?? null
  );
}

/**
 * Economia de conjuração para magias concedidas (domain rules PHB 2024).
 * Espécie/feat: só `phb_effect` cast_economy (incl. truques de escolha tipados).
 */
export function resolveGrantedSpellCastEconomy(input: {
  spellSlug: string;
  source?: CharacterSpellSource;
  featOptions?: readonly FeatOptionDto[];
  featFixedSpells?: readonly FeatGrantedSpellRow[];
  speciesSlug?: string;
  speciesChoices?: readonly SpeciesChoiceDto[];
  featEffects?: readonly CatalogEffect[];
  speciesEffects?: readonly CatalogEffect[];
}): CastEconomy {
  const source = input.source ?? 'class';

  if (source === 'class' || source === 'subclass') {
    return 'slot_only';
  }

  if (source === 'feat') {
    const key = featOptionKeyForSpell(
      input.spellSlug,
      input.featOptions,
      input.featFixedSpells ?? [],
    );
    const featSlug = featSlugForSpell(
      input.spellSlug,
      input.featOptions,
      input.featFixedSpells ?? [],
    );
    if (featSlug && input.featEffects?.length) {
      const fromEffect = resolveFeatCastEconomyFromEffects({
        effects: input.featEffects,
        featSlug,
        optionKey: key,
      });
      if (fromEffect) return fromEffect;
    }
    if (key?.startsWith('ritualSpell')) return 'slot_only';
    return 'slot_only';
  }

  if (source === 'species') {
    if (input.speciesEffects?.length) {
      const fromEffect = resolveSpeciesSpellCastEconomyFromEffects({
        effects: input.speciesEffects,
        spellSlug: input.spellSlug,
        choices: input.speciesChoices,
      });
      if (fromEffect) return fromEffect.economy;
    }
    return 'slot_only';
  }

  return 'slot_only';
}

/** Máximo de free casts por magia concedida (default 1/DL; Greater Freyr = PB). */
export function freeCastMaxUses(input: {
  economy: CastEconomy;
  spellSlug: string;
  featSlug?: string | null;
  optionKey?: string | null;
  proficiencyBonus?: number;
  featEffects?: readonly CatalogEffect[];
  speciesEffects?: readonly CatalogEffect[];
}): number {
  if (input.economy !== 'once_per_long_rest') return 0;
  if (input.featSlug && input.featEffects?.length && input.optionKey) {
    const fromEffect = resolveFeatFreeCastMaxUsesFromEffects({
      effects: input.featEffects,
      featSlug: input.featSlug,
      optionKey: input.optionKey,
      proficiencyBonus: input.proficiencyBonus ?? 1,
    });
    if (fromEffect != null) return fromEffect;
  }
  if (input.speciesEffects?.length) {
    const sat = resolveSpeciesSpellCastEconomyFromEffects({
      effects: input.speciesEffects,
      spellSlug: input.spellSlug,
      choices: undefined,
    });
    if (sat) {
      return resolveCastMaxUses({
        economy: sat.economy,
        usesFormula: sat.usesFormula,
        fixedUses: sat.fixedUses,
        proficiencyBonus: input.proficiencyBonus ?? 1,
      });
    }
  }
  return 1;
}
export function freeCastsRemaining(
  economy: CastEconomy,
  spellSlug: string,
  grantedSpellUses: Record<string, number> | null | undefined,
  maxUses = 1,
): number | null {
  if (economy === 'at_will') return null;
  if (economy === 'slot_only') return 0;
  const used = grantedSpellUses?.[spellSlug] ?? 0;
  return Math.max(0, maxUses - used);
}

export function consumeGrantedFreeCast(
  grantedSpellUses: Record<string, number> | null | undefined,
  spellSlug: string,
): Record<string, number> {
  const next = { ...(grantedSpellUses ?? {}) };
  next[spellSlug] = (next[spellSlug] ?? 0) + 1;
  return next;
}
