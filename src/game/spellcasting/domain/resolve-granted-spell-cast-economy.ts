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

/** Greater Blessing of Freyr and Freyja — Curar Ferimentos free casts = PB / DL. */
export const GREATER_FREYR_FEAT_SLUG = 'greater-blessing-of-freyr-and-freyja';
export const CURAR_FERIMENTOS_SPELL_SLUG = 'curar-ferimentos';

function isSpeciesChoiceCantrip(input: {
  spellSlug: string;
  speciesSlug?: string;
  speciesChoices?: readonly SpeciesChoiceDto[];
}): boolean {
  if (input.speciesSlug === 'elf') {
    const lineage = input.speciesChoices?.find(
      (c) => c.choiceKind === 'elf_lineage',
    )?.choiceSlug;
    const cantrip = input.speciesChoices?.find(
      (c) => c.choiceKind === 'high_elf_cantrip',
    )?.choiceSlug;
    if (lineage === 'high-elf' && cantrip === input.spellSlug) return true;
  }
  if (input.speciesSlug === 'bearfolk') {
    const lineage = input.speciesChoices?.find(
      (c) => c.choiceKind === 'bearfolk_lineage',
    )?.choiceSlug;
    const cantrip = input.speciesChoices?.find(
      (c) => c.choiceKind === 'andari_druid_cantrip',
    )?.choiceSlug;
    if (lineage === 'andari' && cantrip === input.spellSlug) return true;
  }
  return false;
}

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
 * Espécie: `phb_effect` cast_economy (+ truques de escolha Alto Elfo/Andari).
 * Feat: preferência efeitos; fallback heurística por optionKey.
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
    // @deprecated Preferir phb_effect cast_economy quando o optionKey está coberto.
    if (key === 'cantrip1' || key === 'cantrip2') return 'at_will';
    if (
      key === 'firstLevelSpell' ||
      key === 'bonusSpell' ||
      key === 'bloodMagicSpell'
    ) {
      return 'once_per_long_rest';
    }
    if (key?.startsWith('ritualSpell')) return 'slot_only';
    return 'slot_only';
  }

  if (source === 'species') {
    if (input.speciesEffects?.length) {
      const fromEffect = resolveSpeciesSpellCastEconomyFromEffects({
        effects: input.speciesEffects,
        spellSlug: input.spellSlug,
      });
      if (fromEffect) return fromEffect.economy;
    }
    if (isSpeciesChoiceCantrip(input)) return 'at_will';
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
  if (
    input.featSlug === GREATER_FREYR_FEAT_SLUG &&
    input.spellSlug === CURAR_FERIMENTOS_SPELL_SLUG
  ) {
    return Math.max(1, input.proficiencyBonus ?? 1);
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
