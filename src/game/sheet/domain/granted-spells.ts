import {
  CharacterFeatDto,
  CharacterSpellDto,
  FeatOptionDto,
  SpeciesChoiceDto,
} from '../dto/character-sheet.dto';
import { ritualSpellSlotIndex } from './ritual-caster-feat-options';

export type CharacterSpellSource = 'class' | 'subclass' | 'feat' | 'species';

const MAGIC_INITIATE_SPELL_KEYS = new Set([
  'cantrip1',
  'cantrip2',
  'firstLevelSpell',
]);

/** Magias fixas do talento (não escolhidas em featOptions). */
const FEAT_FIXED_SPELLS: Readonly<Record<string, readonly string[]>> = {
  'fey-touched': ['passo-nebuloso'],
  'shadow-touched': ['invisibilidade'],
};

/** Magias fixas da espécie (sem choice). */
const SPECIES_FIXED_SPELLS: Readonly<Record<string, readonly string[]>> = {
  aasimar: ['luz'],
  tiefling: ['taumaturgia'],
};

type LineageSpellProgression = {
  level1: readonly string[];
  level3: readonly string[];
  level5: readonly string[];
};

/** Linhagem élfica — L1 em texto do catálogo; L3/L5 estruturados. */
const ELF_LINEAGE_SPELLS: Readonly<Record<string, LineageSpellProgression>> = {
  'high-elf': {
    level1: ['prestidigitacao-arcana'],
    level3: ['detectar-magia'],
    level5: ['passo-nebuloso'],
  },
  drow: {
    level1: ['luzes-dancantes'],
    level3: ['fogo-das-fadas'],
    level5: ['escuridao'],
  },
  'wood-elf': {
    level1: ['arte-druidica'],
    level3: ['passos-largos'],
    level5: ['passo-sem-rastro'],
  },
};

/** Legado infernal — L1 cantrip + L3/L5. */
const INFERNAL_LEGACY_SPELLS: Readonly<Record<string, LineageSpellProgression>> =
  {
    abyssal: {
      level1: ['rajada-de-veneno'],
      level3: ['raio-nauseante'],
      level5: ['paralisar-pessoa'],
    },
    chthonic: {
      level1: ['toque-necrotico'],
      level3: ['vitalidade-vazia'],
      level5: ['raio-do-enfraquecimento'],
    },
    infernal: {
      level1: ['raio-de-fogo'],
      level3: ['repreensao-diabolica'],
      level5: ['escuridao'],
    },
  };

/** Linhagem de gnomo — todas desde o 1º nível. */
const GNOME_LINEAGE_SPELLS: Readonly<Record<string, readonly string[]>> = {
  'rock-gnome': ['prestidigitacao-arcana', 'reparar'],
  'forest-gnome': ['ilusao-menor', 'falar-com-animais'],
};

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

function addLineageProgression(
  slugs: Set<string>,
  progression: LineageSpellProgression | undefined,
  level: number,
): void {
  if (!progression) return;
  for (const slug of progression.level1) slugs.add(slug);
  if (level >= 3) {
    for (const slug of progression.level3) slugs.add(slug);
  }
  if (level >= 5) {
    for (const slug of progression.level5) slugs.add(slug);
  }
}

function choiceSlugOf(
  choices: readonly SpeciesChoiceDto[] | undefined,
  choiceKind: string,
): string | undefined {
  return choices?.find((choice) => choice.choiceKind === choiceKind)?.choiceSlug;
}

/** Slugs de magia concedidos por talentos (escolhas + fixas). */
export function collectFeatGrantedSpellSlugs(
  featOptions: readonly FeatOptionDto[] | undefined,
  characterFeats?: readonly CharacterFeatDto[],
): Set<string> {
  const slugs = new Set<string>();
  if (!featOptions?.length && !characterFeats?.length) return slugs;

  for (const option of featOptions ?? []) {
    if (!option.valueId) continue;
    if (isFeatSpellOption(option.featSlug, option.optionKey)) {
      slugs.add(option.valueId);
    }
  }

  const featSlugs = characterFeats?.length
    ? characterFeats.map((feat) => feat.featSlug)
    : [...new Set((featOptions ?? []).map((option) => option.featSlug))];

  for (const featSlug of featSlugs) {
    for (const fixed of FEAT_FIXED_SPELLS[featSlug] ?? []) {
      slugs.add(fixed);
    }
  }

  return slugs;
}

/** Slugs de magia concedidos por espécie + escolhas, respeitando o nível. */
export function collectSpeciesGrantedSpellSlugs(
  speciesSlug: string | undefined,
  speciesChoices: readonly SpeciesChoiceDto[] | undefined,
  level: number,
): Set<string> {
  const slugs = new Set<string>();
  if (!speciesSlug) return slugs;

  for (const fixed of SPECIES_FIXED_SPELLS[speciesSlug] ?? []) {
    slugs.add(fixed);
  }

  if (speciesSlug === 'elf') {
    const lineage = choiceSlugOf(speciesChoices, 'elf_lineage');
    addLineageProgression(slugs, ELF_LINEAGE_SPELLS[lineage ?? ''], level);
  }

  if (speciesSlug === 'tiefling') {
    const legacy = choiceSlugOf(speciesChoices, 'infernal_legacy');
    addLineageProgression(slugs, INFERNAL_LEGACY_SPELLS[legacy ?? ''], level);
  }

  if (speciesSlug === 'gnome') {
    const lineage = choiceSlugOf(speciesChoices, 'gnome_lineage');
    for (const slug of GNOME_LINEAGE_SPELLS[lineage ?? ''] ?? []) {
      slugs.add(slug);
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

  const nextGranted = unionSets(
    collectFeatGrantedSpellSlugs(context.featOptions, context.characterFeats),
    collectSpeciesGrantedSpellSlugs(
      context.speciesSlug,
      context.speciesChoices,
      level,
    ),
  );
  const previousGranted = unionSets(
    collectFeatGrantedSpellSlugs(
      context.previousFeatOptions,
      context.previousCharacterFeats,
    ),
    collectSpeciesGrantedSpellSlugs(
      context.previousSpeciesSlug,
      context.previousSpeciesChoices,
      previousLevel,
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
  },
): CharacterSpellDto[] {
  return mergeCharacterSpellsWithGrantedSources(baseSpells, {
    featOptions,
    characterFeats: options?.characterFeats,
    previousFeatOptions: options?.previousFeatOptions,
    previousCharacterFeats: options?.previousCharacterFeats,
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
