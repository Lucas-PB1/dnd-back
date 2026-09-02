import type {
  FeatOptionDto,
  SpeciesChoiceDto,
} from '@game/sheet/dto/character-sheet.dto';
import type {
  CharacterSpellSource,
  FeatGrantedSpellRow,
  SpeciesGrantedSpellRow,
} from './granted-spells/types';
import { resolveFeatSlugForGrantedSpell } from './resolve-granted-spellcasting-ability';

export type CastEconomy = 'at_will' | 'once_per_long_rest' | 'slot_only';

/** Greater Blessing of Freyr and Freyja — Curar Ferimentos free casts = PB / DL. */
export const GREATER_FREYR_FEAT_SLUG = 'greater-blessing-of-freyr-and-freyja';
export const CURAR_FERIMENTOS_SPELL_SLUG = 'curar-ferimentos';

const SPECIES_CHOICE_KINDS_FOR_LINEAGE = new Set([
  'elf_lineage',
  'gnome_lineage',
  'infernal_legacy',
]);

function matchingSpeciesUnlockLevel(
  spellSlug: string,
  speciesSlug: string | undefined,
  speciesChoices: readonly SpeciesChoiceDto[] | undefined,
  catalogRows: readonly SpeciesGrantedSpellRow[],
): number | null {
  if (!speciesSlug) return null;
  let best: number | null = null;
  for (const row of catalogRows) {
    if (row.speciesSlug !== speciesSlug || row.spellSlug !== spellSlug) continue;
    if (row.choiceKind == null) {
      best = best == null ? row.unlockLevel : Math.max(best, row.unlockLevel);
      continue;
    }
    if (!SPECIES_CHOICE_KINDS_FOR_LINEAGE.has(row.choiceKind)) continue;
    const selected = speciesChoices?.find((c) => c.choiceKind === row.choiceKind)
      ?.choiceSlug;
    if (selected === row.choiceSlug) {
      best = best == null ? row.unlockLevel : Math.max(best, row.unlockLevel);
    }
  }
  return best;
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
  // Fixed catalog grants (misty step etc.) are typically once per long rest free.
  return 'bonusSpell';
}

/**
 * Economia de conjuração para magias concedidas (domain rules PHB 2024).
 * Cantrips → at_will; lineage L3+ e firstLevel/bonusSpell → once_per_long_rest.
 */
export function resolveGrantedSpellCastEconomy(input: {
  spellSlug: string;
  source?: CharacterSpellSource;
  featOptions?: readonly FeatOptionDto[];
  featFixedSpells?: readonly FeatGrantedSpellRow[];
  speciesSlug?: string;
  speciesChoices?: readonly SpeciesChoiceDto[];
  speciesCatalog?: readonly SpeciesGrantedSpellRow[];
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
    const unlock = matchingSpeciesUnlockLevel(
      input.spellSlug,
      input.speciesSlug,
      input.speciesChoices,
      input.speciesCatalog ?? [],
    );
    if (unlock == null) return 'slot_only';
    if (unlock <= 1) return 'at_will';
    if (unlock >= 3) return 'once_per_long_rest';
    return 'slot_only';
  }

  return 'slot_only';
}

/** Máximo de free casts por magia concedida (default 1/DL; Greater Freyr = PB). */
export function freeCastMaxUses(input: {
  economy: CastEconomy;
  spellSlug: string;
  featSlug?: string | null;
  proficiencyBonus?: number;
}): number {
  if (input.economy !== 'once_per_long_rest') return 0;
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
