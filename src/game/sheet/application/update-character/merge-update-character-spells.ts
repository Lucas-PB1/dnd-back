import { DataSource } from 'typeorm';
import {
  CharacterSheetData,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';
import { CharacterFeatDto, FeatOptionDto, SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';
import { UpdateCharacterDto } from '@game/sheet/dto/update-character.dto';
import { mergeGrantedSpells } from '@game/spellcasting/application/merge-granted-spells';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { ResolveSubclassOptionGrantedSpells } from '@game/spellcasting/application/resolve-subclass-option-granted-spells';
import { resolveEldritchGrantedSpellSlugs } from '../eldritch-granted-spells';

export async function mergeUpdateCharacterSpells(input: {
  dto: UpdateCharacterDto;
  sheetInput: CharacterSheetInput;
  sheetSnapshot: CharacterSheetData;
  effective: {
    classSlug: string;
    speciesSlug: string | null;
    subclassSlug: string | null;
    level: number;
  };
  previous: {
    classSlug: string;
    speciesSlug: string | null;
    subclassSlug: string | null;
    level: number;
  };
  effectiveCharacterFeats: CharacterFeatDto[];
  effectiveFeatOptions: FeatOptionDto[];
  effectiveSpeciesChoices: SpeciesChoiceDto[] | undefined;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
  resolveSubclassOptionGrants: ResolveSubclassOptionGrantedSpells;
  dataSource: DataSource;
}): Promise<void> {
  const {
    dto,
    sheetInput,
    sheetSnapshot,
    effective,
    previous,
    effectiveCharacterFeats,
    effectiveFeatOptions,
    effectiveSpeciesChoices,
    grantedSpellCatalog,
    resolveSubclassOptionGrants,
    dataSource,
  } = input;

  const effectiveSubclassOptions =
    dto.subclassOptions !== undefined
      ? dto.subclassOptions
      : sheetSnapshot.subclassOptions;
  const previousSubclassOptions = sheetSnapshot.subclassOptions;

  const featSlugs = [
    ...effectiveCharacterFeats.map((f) => f.featSlug),
    ...sheetSnapshot.characterFeats.map((f) => f.featSlug),
  ];
  const { speciesCatalog, featFixedSpells, subclassGrantedSpells, classGrantedSpells } =
    await grantedSpellCatalog.loadMergeCatalog({
      speciesSlugs: [effective.speciesSlug, previous.speciesSlug].filter(
        (slug): slug is string => Boolean(slug),
      ),
      featSlugs,
      subclassSlug: effective.subclassSlug,
      classSlug: effective.classSlug,
      subclassOptions: effectiveSubclassOptions,
    });
  const [previousSubclassGrantedSpells, previousClassGrantedSpells] =
    await Promise.all([
      grantedSpellCatalog.loadSubclassGrantedSpells(
        previous.subclassSlug,
        previousSubclassOptions,
      ),
      grantedSpellCatalog.loadClassGrantedSpells(previous.classSlug),
    ]);

  const nextClassOptions =
    dto.classOptions !== undefined
      ? dto.classOptions
      : sheetSnapshot.classOptions;
  const [
    eldritchGranted,
    previousEldritchGranted,
    loreGranted,
    previousLoreGranted,
  ] = await Promise.all([
    resolveEldritchGrantedSpellSlugs(dataSource, nextClassOptions),
    resolveEldritchGrantedSpellSlugs(dataSource, sheetSnapshot.classOptions),
    resolveSubclassOptionGrants.resolveExtraGrantedSlugs(
      effective.subclassSlug,
      effective.level,
      effectiveSubclassOptions,
    ),
    resolveSubclassOptionGrants.resolveExtraGrantedSlugs(
      previous.subclassSlug,
      previous.level,
      previousSubclassOptions,
    ),
  ]);
  const extraGrantedSpellSlugs = unionSets(eldritchGranted, loreGranted);
  const previousExtraGrantedSpellSlugs = unionSets(
    previousEldritchGranted,
    previousLoreGranted,
  );

  sheetInput.characterSpells = mergeGrantedSpells(
    dto.characterSpells ?? sheetSnapshot.characterSpells,
    {
      featOptions: effectiveFeatOptions,
      characterFeats: effectiveCharacterFeats,
      previousFeatOptions: sheetSnapshot.featOptions,
      previousCharacterFeats: sheetSnapshot.characterFeats,
      speciesSlug: effective.speciesSlug ?? undefined,
      speciesChoices: effectiveSpeciesChoices,
      level: effective.level,
      previousSpeciesSlug: previous.speciesSlug ?? undefined,
      previousSpeciesChoices: sheetSnapshot.speciesChoices,
      previousLevel: previous.level,
      speciesCatalog,
      featFixedSpells,
      subclassGrantedSpells,
      previousSubclassGrantedSpells,
      classGrantedSpells,
      previousClassGrantedSpells,
      extraGrantedSpellSlugs,
      previousExtraGrantedSpellSlugs,
    },
  );

  if (dto.featOptions === undefined && dto.characterFeats !== undefined) {
    sheetInput.featOptions = effectiveFeatOptions;
  }
}

function unionSets(...sets: ReadonlySet<string>[]): Set<string> {
  const result = new Set<string>();
  for (const set of sets) {
    for (const slug of set) result.add(slug);
  }
  return result;
}
