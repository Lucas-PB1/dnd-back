import {
  CharacterSheetData,
  CharacterSheetInput,
} from '../../domain/character-sheet.types';
import { CharacterFeatDto, FeatOptionDto, SpeciesChoiceDto } from '../../dto/character-sheet.dto';
import { UpdateCharacterDto } from '../../dto/update-character.dto';
import { mergeCharacterSpellsWithGrantedSources } from '../../../spellcasting/domain/granted-spells';
import { GrantedSpellCatalogService } from '../../../spellcasting/infrastructure/granted-spell-catalog.service';

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
  grantedSpellCatalog: GrantedSpellCatalogService;
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

  sheetInput.characterSpells = mergeCharacterSpellsWithGrantedSources(
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
    },
  );

  if (dto.featOptions === undefined && dto.characterFeats !== undefined) {
    sheetInput.featOptions = effectiveFeatOptions;
  }
}
