import {
  CharacterFeatDto,
  CharacterSpellDto,
  FeatOptionDto,
  SpeciesChoiceDto,
} from '../dto/character-sheet.dto';
import { ritualSpellSlotIndex } from './ritual-caster-feat-options';

export type CharacterSpellSource = 'class' | 'subclass' | 'feat' | 'species';

/** Linha do catálogo `v_phb_species_granted_spell`. */
export type SpeciesGrantedSpellRow = {
  speciesSlug: string;
  choiceKind: string | null;
  choiceSlug: string | null;
  unlockLevel: number;
  spellSlug: string;
};

/** Linha do catálogo `v_phb_feat_granted_spell`. */
export type FeatGrantedSpellRow = {
  featSlug: string;
  spellSlug: string;
};

/** Magia fixa de subclasse (ex. Finger Guns do Spellslinger). */
export type SubclassGrantedSpellRow = {
  unlockLevel: number;
  spellSlug: string;
};

export function collectSubclassGrantedSpellSlugs(
  level: number,
  rows: readonly SubclassGrantedSpellRow[],
): Set<string> {
  const slugs = new Set<string>();
  for (const row of rows) {
    if (row.unlockLevel <= level) slugs.add(row.spellSlug);
  }
  return slugs;
}

const MAGIC_INITIATE_SPELL_KEYS = new Set([
  'cantrip1',
  'cantrip2',
  'firstLevelSpell',
]);

function isFeatSpellOption(featSlug: string, optionKey: string): boolean {
  if (featSlug === 'magic-initiate') {
    return MAGIC_INITIATE_SPELL_KEYS.has(optionKey);
  }
  if (featSlug === 'fey-touched' || featSlug === 'shadow-touched') {
    return optionKey === 'bonusSpell';
  }
  if (featSlug === 'ritual-caster') {
    return ritualSpellSlotIndex(optionKey) !== null;
  }
  return false;
}

function choiceSlugOf(
  choices: readonly SpeciesChoiceDto[] | undefined,
  choiceKind: string,
): string | undefined {
  return choices?.find((choice) => choice.choiceKind === choiceKind)?.choiceSlug;
}

/** Slugs de magia concedidos por talentos (escolhas em featOptions + fixas do catálogo). */
export function collectFeatGrantedSpellSlugs(
  featOptions: readonly FeatOptionDto[] | undefined,
  characterFeats: readonly CharacterFeatDto[] | undefined,
  featFixedSpells: readonly FeatGrantedSpellRow[] = [],
): Set<string> {
  const slugs = new Set<string>();

  for (const option of featOptions ?? []) {
    if (!option.valueId) continue;
    if (isFeatSpellOption(option.featSlug, option.optionKey)) {
      slugs.add(option.valueId);
    }
  }

  const featSlugs = new Set(
    (characterFeats?.length
      ? characterFeats.map((feat) => feat.featSlug)
      : (featOptions ?? []).map((option) => option.featSlug)
    ),
  );

  for (const row of featFixedSpells) {
    if (featSlugs.has(row.featSlug)) {
      slugs.add(row.spellSlug);
    }
  }

  return slugs;
}

/**
 * Slugs de magia concedidos por espécie a partir do catálogo,
 * filtrados por escolhas da ficha e nível.
 */
export function collectSpeciesGrantedSpellSlugs(
  speciesSlug: string | undefined,
  speciesChoices: readonly SpeciesChoiceDto[] | undefined,
  level: number,
  catalogRows: readonly SpeciesGrantedSpellRow[],
): Set<string> {
  const slugs = new Set<string>();
  if (!speciesSlug) return slugs;

  for (const row of catalogRows) {
    if (row.speciesSlug !== speciesSlug) continue;
    if (row.unlockLevel > level) continue;

    if (row.choiceKind == null) {
      slugs.add(row.spellSlug);
      continue;
    }

    const selected = choiceSlugOf(speciesChoices, row.choiceKind);
    if (selected && selected === row.choiceSlug) {
      slugs.add(row.spellSlug);
    }
  }

  return slugs;
}

export type GrantedSpellMergeContext = {
  featOptions?: readonly FeatOptionDto[];
  characterFeats?: readonly CharacterFeatDto[];
  previousFeatOptions?: readonly FeatOptionDto[];
  previousCharacterFeats?: readonly CharacterFeatDto[];
  speciesSlug?: string;
  speciesChoices?: readonly SpeciesChoiceDto[];
  level?: number;
  previousSpeciesSlug?: string;
  previousSpeciesChoices?: readonly SpeciesChoiceDto[];
  previousLevel?: number;
  /** Catálogo de magias fixas de talento (`v_phb_feat_granted_spell`). */
  featFixedSpells?: readonly FeatGrantedSpellRow[];
  /** Catálogo de magias de espécie (`v_phb_species_granted_spell`). */
  speciesCatalog?: readonly SpeciesGrantedSpellRow[];
  /** Magias always_prepared da subclasse (Finger Guns etc.). */
  subclassGrantedSpells?: readonly SubclassGrantedSpellRow[];
  previousSubclassGrantedSpells?: readonly SubclassGrantedSpellRow[];
};

/**
 * Mantém magias da classe/subclasse e sincroniza always_prepared de talento/espécie.
 * Remove always_prepared que eram só concessão gerenciada e não estão mais concedidas.
 */
export function mergeCharacterSpellsWithGrantedSources(
  baseSpells: readonly CharacterSpellDto[],
  context: GrantedSpellMergeContext,
): CharacterSpellDto[] {
  const level = context.level ?? 1;
  const previousLevel = context.previousLevel ?? level;
  const featFixed = context.featFixedSpells ?? [];
  const speciesCatalog = context.speciesCatalog ?? [];
  const subclassGrants = context.subclassGrantedSpells ?? [];

  const nextGranted = unionSets(
    collectFeatGrantedSpellSlugs(
      context.featOptions,
      context.characterFeats,
      featFixed,
    ),
    collectSpeciesGrantedSpellSlugs(
      context.speciesSlug,
      context.speciesChoices,
      level,
      speciesCatalog,
    ),
    collectSubclassGrantedSpellSlugs(level, subclassGrants),
  );
  const previousGranted = unionSets(
    collectFeatGrantedSpellSlugs(
      context.previousFeatOptions,
      context.previousCharacterFeats,
      featFixed,
    ),
    collectSpeciesGrantedSpellSlugs(
      context.previousSpeciesSlug,
      context.previousSpeciesChoices,
      previousLevel,
      speciesCatalog,
    ),
    collectSubclassGrantedSpellSlugs(
      previousLevel,
      context.previousSubclassGrantedSpells ?? subclassGrants,
    ),
  );

  const kept = baseSpells.filter((spell) => {
    if (spell.listType !== 'always_prepared') return true;
    if (!previousGranted.has(spell.spellSlug)) return true;
    return nextGranted.has(spell.spellSlug);
  });

  const result = kept.map((spell) => ({ ...spell }));

  for (const spellSlug of nextGranted) {
    const alreadyAlways = result.some(
      (spell) =>
        spell.spellSlug === spellSlug && spell.listType === 'always_prepared',
    );
    if (alreadyAlways) continue;
    result.push({ spellSlug, listType: 'always_prepared' });
  }

  return result;
}

/** @deprecated Prefer mergeCharacterSpellsWithGrantedSources */
export function mergeCharacterSpellsWithFeatGrants(
  baseSpells: readonly CharacterSpellDto[],
  featOptions: readonly FeatOptionDto[] | undefined,
  options?: {
    characterFeats?: readonly CharacterFeatDto[];
    previousFeatOptions?: readonly FeatOptionDto[];
    previousCharacterFeats?: readonly CharacterFeatDto[];
    featFixedSpells?: readonly FeatGrantedSpellRow[];
  },
): CharacterSpellDto[] {
  return mergeCharacterSpellsWithGrantedSources(baseSpells, {
    featOptions,
    characterFeats: options?.characterFeats,
    previousFeatOptions: options?.previousFeatOptions,
    previousCharacterFeats: options?.previousCharacterFeats,
    featFixedSpells: options?.featFixedSpells,
  });
}

export function annotateCharacterSpellSources(
  spells: readonly CharacterSpellDto[],
  context: {
    featGrantedSlugs: ReadonlySet<string>;
    speciesGrantedSlugs?: ReadonlySet<string>;
    subclassSpellSlugs?: ReadonlySet<string>;
  },
): CharacterSpellDto[] {
  return spells.map((spell) => ({
    ...spell,
    source: resolveSpellSource(spell.spellSlug, context),
  }));
}

function resolveSpellSource(
  spellSlug: string,
  context: {
    featGrantedSlugs: ReadonlySet<string>;
    speciesGrantedSlugs?: ReadonlySet<string>;
    subclassSpellSlugs?: ReadonlySet<string>;
  },
): CharacterSpellSource {
  if (context.featGrantedSlugs.has(spellSlug)) return 'feat';
  if (context.speciesGrantedSlugs?.has(spellSlug)) return 'species';
  if (context.subclassSpellSlugs?.has(spellSlug)) return 'subclass';
  return 'class';
}

function unionSets(...sets: ReadonlySet<string>[]): Set<string> {
  const result = new Set<string>();
  for (const set of sets) {
    for (const value of set) result.add(value);
  }
  return result;
}
