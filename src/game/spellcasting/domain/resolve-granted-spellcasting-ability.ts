import type { AbilityKey } from '../../build/domain/ability-generation';
import type {
  FeatOptionDto,
  SpeciesChoiceDto,
} from '../../sheet/dto/character-sheet.dto';
import type { CharacterSpellSource, FeatGrantedSpellRow } from './granted-spells/types';
import { ritualSpellSlotIndex } from './ritual-spell-option-key';

const ABILITY_SLUGS = new Set<AbilityKey>([
  'forca',
  'destreza',
  'constituicao',
  'inteligencia',
  'sabedoria',
  'carisma',
]);

const SPECIES_CASTING_CHOICE_KINDS = [
  'elf_casting_ability',
  'gnome_casting_ability',
  'infernal_casting_ability',
] as const;

const FEAT_SPELL_OPTION_KEYS = new Set([
  'cantrip1',
  'cantrip2',
  'firstLevelSpell',
  'bonusSpell',
]);

function asAbilityKey(value: string | undefined): AbilityKey | null {
  if (!value || !ABILITY_SLUGS.has(value as AbilityKey)) return null;
  return value as AbilityKey;
}

function isFeatSpellOption(featSlug: string, optionKey: string): boolean {
  if (FEAT_SPELL_OPTION_KEYS.has(optionKey)) return true;
  if (featSlug === 'ritual-caster') {
    return ritualSpellSlotIndex(optionKey) !== null;
  }
  return false;
}

/** Resolve featSlug that granted a spell (option choice or fixed catalog grant). */
export function resolveFeatSlugForGrantedSpell(
  spellSlug: string,
  featOptions: readonly FeatOptionDto[] | undefined,
  featFixedSpells: readonly FeatGrantedSpellRow[] = [],
): { featSlug: string; instanceIndex: number } | null {
  for (const option of featOptions ?? []) {
    if (
      option.valueId === spellSlug &&
      isFeatSpellOption(option.featSlug, option.optionKey)
    ) {
      return {
        featSlug: option.featSlug,
        instanceIndex: option.instanceIndex ?? 0,
      };
    }
  }
  for (const row of featFixedSpells) {
    if (row.spellSlug === spellSlug) {
      return { featSlug: row.featSlug, instanceIndex: 0 };
    }
  }
  return null;
}

function castingAbilityFromFeatOptions(
  featSlug: string,
  instanceIndex: number,
  featOptions: readonly FeatOptionDto[] | undefined,
): AbilityKey | null {
  const match = (featOptions ?? []).find(
    (option) =>
      option.featSlug === featSlug &&
      (option.instanceIndex ?? 0) === instanceIndex &&
      option.optionKey === 'castingAbility',
  );
  return asAbilityKey(match?.valueId);
}

function castingAbilityFromSpeciesChoices(
  speciesChoices: readonly SpeciesChoiceDto[] | undefined,
): AbilityKey | null {
  for (const kind of SPECIES_CASTING_CHOICE_KINDS) {
    const choice = speciesChoices?.find((c) => c.choiceKind === kind);
    const ability = asAbilityKey(choice?.choiceSlug);
    if (ability) return ability;
  }
  return null;
}

/**
 * Atributo de conjuração efetivo para uma magia na ficha,
 * considerando classe, talento (`castingAbility`) e espécie (`*_casting_ability`).
 */
export function resolveSpellcastingAbilityForSpell(input: {
  source: CharacterSpellSource | undefined;
  spellSlug: string;
  classAbilitySlug: AbilityKey | null;
  featOptions?: readonly FeatOptionDto[];
  speciesChoices?: readonly SpeciesChoiceDto[];
  featFixedSpells?: readonly FeatGrantedSpellRow[];
}): AbilityKey | null {
  const source = input.source ?? 'class';

  if (source === 'feat') {
    const feat = resolveFeatSlugForGrantedSpell(
      input.spellSlug,
      input.featOptions,
      input.featFixedSpells,
    );
    if (feat) {
      const fromFeat = castingAbilityFromFeatOptions(
        feat.featSlug,
        feat.instanceIndex,
        input.featOptions,
      );
      if (fromFeat) return fromFeat;
    }
    return input.classAbilitySlug;
  }

  if (source === 'species') {
    return (
      castingAbilityFromSpeciesChoices(input.speciesChoices) ??
      input.classAbilitySlug
    );
  }

  return input.classAbilitySlug;
}
