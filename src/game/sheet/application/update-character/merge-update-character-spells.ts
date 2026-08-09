import { DataSource } from 'typeorm';
import {
  CharacterSheetData,
  CharacterSheetInput,
} from '@game/sheet/domain/character-sheet.types';
import { CharacterFeatDto, FeatOptionDto, SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';
import { UpdateCharacterDto } from '@game/sheet/dto/update-character.dto';
import { mergeGrantedSpells } from '@game/spellcasting/application/merge-granted-spells';
import { LoadGrantedSpellCatalog } from '@game/spellcasting/application/load-granted-spell-catalog';
import { resolveEldritchGrantedSpellSlugs } from '../eldritch-granted-spells';

export async function mergeUpdateCharacterSpells(input: {
  dto: UpdateCharacterDto;
  sheetInput: CharacterSheetInput;
  sheetSnapshot: CharacterSheetData;
  effective: {
    speciesSlug: string;
    subclassSlug: string | null;
    level: number;
  };
  previous: {
    speciesSlug: string;
    subclassSlug: string | null;
    level: number;
  };
  effectiveCharacterFeats: CharacterFeatDto[];
  effectiveFeatOptions: FeatOptionDto[];
  effectiveSpeciesChoices: SpeciesChoiceDto[] | undefined;
  grantedSpellCatalog: LoadGrantedSpellCatalog;
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
    dataSource,
  } = input;

  const featSlugs = [
    ...effectiveCharacterFeats.map((f) => f.featSlug),
    ...sheetSnapshot.characterFeats.map((f) => f.featSlug),
  ];
  const { speciesCatalog, featFixedSpells, subclassGrantedSpells } =
    await grantedSpellCatalog.loadMergeCatalog({
      speciesSlugs: [effective.speciesSlug, previous.speciesSlug],
      featSlugs,
      subclassSlug: effective.subclassSlug,
    });
  const previousSubclassGrantedSpells =
    await grantedSpellCatalog.loadSubclassGrantedSpells(previous.subclassSlug);

  const nextClassOptions =
    dto.classOptions !== undefined
      ? dto.classOptions
      : sheetSnapshot.classOptions;
  const [extraGrantedSpellSlugs, previousExtraGrantedSpellSlugs] =
    await Promise.all([
      resolveEldritchGrantedSpellSlugs(dataSource, nextClassOptions),
      resolveEldritchGrantedSpellSlugs(dataSource, sheetSnapshot.classOptions),
    ]);

  sheetInput.characterSpells = mergeGrantedSpells(
    dto.characterSpells ?? sheetSnapshot.characterSpells,
    {
      featOptions: effectiveFeatOptions,
      characterFeats: effectiveCharacterFeats,
      previousFeatOptions: sheetSnapshot.featOptions,
      previousCharacterFeats: sheetSnapshot.characterFeats,
      speciesSlug: effective.speciesSlug,
      speciesChoices: effectiveSpeciesChoices,
      level: effective.level,
      previousSpeciesSlug: previous.speciesSlug,
      previousSpeciesChoices: sheetSnapshot.speciesChoices,
      previousLevel: previous.level,
      speciesCatalog,
      featFixedSpells,
      subclassGrantedSpells,
      previousSubclassGrantedSpells,
      extraGrantedSpellSlugs,
      previousExtraGrantedSpellSlugs,
    },
  );

  if (dto.featOptions === undefined && dto.characterFeats !== undefined) {
    sheetInput.featOptions = effectiveFeatOptions;
  }
}
